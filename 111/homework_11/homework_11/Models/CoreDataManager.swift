//
//  CoreDataManager.swift
//  homework_10
//
//  Created by Кирилл Щёлоков on 10.12.2023.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {

    static let shared = CoreDataManager()

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    private init() {}

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "homework_11")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    // MARK: - Core Data User Func-s

    func obtainAllUsers() -> [User] {
        let userFetchRequest = User.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "login", ascending: true)
        userFetchRequest.sortDescriptors = [sortDescriptor]

        let result = try? viewContext.fetch(userFetchRequest)
        return result ?? []
    }

    func getAuthUser() -> User? {
        let users = obtainAllUsers()
        let loggedInUserId = UserDefaults.standard.string(forKey: "loggedInUser")
        return users.first(where: {$0.id.uuidString == loggedInUserId})
    }

    func createUser(login: String, password: String, avatarImage: UIImage) {
        let newUser = User(context: viewContext)
        newUser.id = UUID()
        newUser.login = login
        newUser.password = password
        newUser.avatarImage = avatarImage.pngData()

        saveContext()
    }

    func deleteAllUsers() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "User")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print("Ошибка удаления объектов User: \(error), \(error.userInfo)")
        }
    }

    func getFriendsByUser() -> [User] {
        let friendsArray = getAuthUser()?.friends?.allObjects as? [Friends] ?? []
        var friendsUserArray: [User] = []
        for friend in friendsArray {
            friendsUserArray.append(friend.friend)
        }
        return friendsUserArray
    }

    func createUsersFetchResultController() -> NSFetchedResultsController<User> {
        guard let user = getAuthUser() else { return NSFetchedResultsController()}
        let userFetchRequest = User.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "login", ascending: true)
        userFetchRequest.sortDescriptors = [sortDescriptor]
        userFetchRequest.predicate = NSPredicate(format: "id != %@", user.id as CVarArg)

        let resultController = NSFetchedResultsController(
            fetchRequest: userFetchRequest,
            managedObjectContext: viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil)

        return resultController
    }

    // MARK: - Core Data Post Func-s

    func obtainAllPosts() -> [Post] {
        let postFetchRequest = Post.fetchRequest()

        let result = try? viewContext.fetch(postFetchRequest)
        return result ?? []
    }

    func obtainPostById(id: UUID) -> Post? {
        let posts = obtainAllPosts()
        return posts.first(where: {$0.id.uuidString == id.uuidString})
    }

    func obtainFriendsPosts() -> [Post] {
        guard let authUser = getAuthUser() else { return [] }

        let freindsArray = authUser.friends?.allObjects as? [Friends] ?? []
        let friendUserIDs = freindsArray.map { $0.friend.id }

        let postFetchRequest = Post.fetchRequest()

        postFetchRequest.predicate = NSPredicate(format: "author.id IN %@", friendUserIDs as CVarArg)

        let result = try? viewContext.fetch(postFetchRequest)
        return result ?? []
    }

    func obtainPostsForAuthUser() -> [Post] {
        guard let userId = getAuthUser()?.id else { return [] }
        let postFetchRequest = Post.fetchRequest()
        postFetchRequest.predicate = NSPredicate(format: "author.id == %@", userId as CVarArg)

        let result = try? viewContext.fetch(postFetchRequest)
        return result ?? []
    }

    func updatePostById(id: UUID, newCaption: String?, newImage: UIImage?) {
        guard let post = obtainPostById(id: id) else { return }
        post.caption = newCaption ?? post.caption
        post.postImage = newImage?.pngData() ?? post.postImage
        saveContext()
    }

    func deletePostById(id: UUID) {
        guard let post = obtainPostById(id: id) else { return }
        viewContext.delete(post)
        saveContext()
    }

    func deleteAllPostForUser(userId: UUID) {
        let posts = obtainAllPosts()
        let userPosts = posts.filter {$0.author?.id == userId}
        for userPost in userPosts {
            viewContext.delete(userPost)
        }
        saveContext()
    }

    func createPostForUser(userId: UUID, caption: String, date: String, postImage: UIImage) {
        let user = obtainAllUsers().first(where: {$0.id == userId})
        let newPost = Post(context: viewContext)
        newPost.id = UUID()
        newPost.postImage = postImage.pngData()
        newPost.caption = caption
        newPost.date = date
        newPost.isFavorite = false
        user?.addToPosts(newPost)
    }

    // MARK: - Core Data Like Func-s

    func getAllLikedPostsByUser(userId: UUID) -> [Like] {
        let likeFetchRequest: NSFetchRequest<Like> = Like.fetchRequest()
        likeFetchRequest.predicate = NSPredicate(format: "user.id == %@", userId as CVarArg)
        do {
            let likedPosts = try viewContext.fetch(likeFetchRequest)
            return likedPosts
        } catch {
            print("Error fetching liked posts: \(error)")
        }
        return []
    }

    func getLikeCountForPost(post: Post) -> Int {
        let likeCountFetchRequest = Like.fetchRequest()
        likeCountFetchRequest.predicate = NSPredicate(format: "post.id == %@", post.id as CVarArg)
        do {
            let likedPosts = try viewContext.fetch(likeCountFetchRequest)
            return likedPosts.count
        } catch {
            print("Error fetching liked posts: \(error)")
        }
        return 0
    }

    func isPostLikedByUser(post: Post) -> Bool {
        guard let user = getAuthUser() else { return false }
        let posts = getAllLikedPostsByUser(userId: user.id)
        if posts.contains(where: {$0.post?.id == post.id}) {
            return true
        }
        return false
    }

    func likePostByUser(post: Post) {
        let likedPost = Like(context: viewContext)
        likedPost.id = UUID()
        likedPost.user = getAuthUser()
        likedPost.post = post

        getAuthUser()?.addToLikedPosts(likedPost)
    }

    func unlikePostByUser(post: Post) {
        guard let authUserId = getAuthUser()?.id else { return }

        let fetchRequest: NSFetchRequest<Like> = Like.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "user.id == %@ AND post.id == %@", authUserId as CVarArg, post.id as CVarArg)

        do {
            let likedPosts = try viewContext.fetch(fetchRequest)
            for like in likedPosts {
                viewContext.delete(like)
            }
            saveContext()
        } catch {
            print("Error deleting like: \(error)")
        }
    }

    // MARK: - Core Data Friends Func-s

    func obtainFriendsCount() -> Int {
        guard let user = getAuthUser() else { return 0 }
        return user.friends?.count ?? 0
    }

    func isFriendForAuthUser(friend: User) -> Bool {
        let friends = getFriendsByUser()
        return friends.contains(where: {$0.id == friend.id})
    }

    func addNewFriend(friend: User) {
        guard let user = getAuthUser() else { return }
        let newFriendship = Friends(context: viewContext)
        newFriendship.id = UUID()
        newFriendship.user = user
        newFriendship.friend = friend

        user.addToFriends(newFriendship)
        saveContext()
    }

    func createFriendsFetchResultController() -> NSFetchedResultsController<Friends> {
        guard let user = getAuthUser() else { return NSFetchedResultsController()}
        let friendsArray = getAuthUser()?.friends?.allObjects as? [Friends] ?? []
        let friendsFetchRequest = Friends.fetchRequest()
        friendsFetchRequest.predicate = NSPredicate(format: "user.id == %@", user.id as CVarArg)
        let sortDescriptor = NSSortDescriptor(key: "user.login", ascending: true)
        friendsFetchRequest.sortDescriptors = [sortDescriptor]

        let resultController = NSFetchedResultsController(
            fetchRequest: friendsFetchRequest,
            managedObjectContext: viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil)

        return resultController
    }

    func removeFriend(friend: User) {
        guard let user = getAuthUser() else { return }
        let freindsArray = getAuthUser()?.friends?.allObjects as? [Friends] ?? []
        guard let friendship = freindsArray.first(where: {$0.friend == friend}) else { return }
        user.removeFromFriends(friendship)
        saveContext()
    }

    // MARK: - Core Data default data setUp

    func setDefaultUsers() {
        let pushinka = User(context: viewContext)
        pushinka.id = UUID()
        pushinka.login = "Pushinka.52NGG"
        pushinka.password = "123"
        pushinka.avatarImage = UIImage(named: "logoImage")?.pngData()

        let admin = User(context: viewContext)
        admin.id = UUID()
        admin.login = "Admin"
        admin.password = "admin"
        admin.avatarImage = UIImage(named: "adminLogo")?.pngData()

        let dogLover = User(context: viewContext)
        dogLover.id = UUID()
        dogLover.login = "dogLover"
        dogLover.password = "dogLover"
        dogLover.avatarImage = UIImage(named: "dogLogo")?.pngData()

        let adminPushinkaFriend = Friends(context: viewContext)
        adminPushinkaFriend.id = UUID()
        adminPushinkaFriend.user = admin
        adminPushinkaFriend.friend = pushinka

        let adminDogLoverFriend = Friends(context: viewContext)
        adminDogLoverFriend.id = UUID()
        adminDogLoverFriend.user = admin
        adminDogLoverFriend.friend = dogLover

        admin.addToFriends(adminPushinkaFriend)
        admin.addToFriends(adminDogLoverFriend)

        let dogLoverPushinkaFriend = Friends(context: viewContext)
        dogLoverPushinkaFriend.id = UUID()
        dogLoverPushinkaFriend.user = dogLover
        dogLoverPushinkaFriend.friend = pushinka

        let dogLoverAdminFriend = Friends(context: viewContext)
        dogLoverAdminFriend.id = UUID()
        dogLoverAdminFriend.user = dogLover
        dogLoverAdminFriend.friend = admin

        dogLover.addToFriends(dogLoverAdminFriend)
        dogLover.addToFriends(dogLoverPushinkaFriend)

        let pushinkaAdminFriend = Friends(context: viewContext)
        pushinkaAdminFriend.id = UUID()
        pushinkaAdminFriend.user = pushinka
        pushinkaAdminFriend.friend = admin

        let pushinkaDogLoverFriend = Friends(context: viewContext)
        pushinkaDogLoverFriend.id = UUID()
        pushinkaDogLoverFriend.user = pushinka
        pushinkaDogLoverFriend.friend = dogLover

        pushinka.addToFriends(pushinkaAdminFriend)
        pushinka.addToFriends(pushinkaDogLoverFriend)

        saveContext()
    }

    func setDefaultPosts() {
        let users = obtainAllUsers()

        let pushinkaPost1 = Post(context: viewContext)
        pushinkaPost1.id = UUID()
        pushinkaPost1.postImage = UIImage(named: "cat1Image")?.pngData()
        pushinkaPost1.caption = "Мой друг 1"
        pushinkaPost1.date = "06.07.2006"
        pushinkaPost1.isFavorite = false
        pushinkaPost1.author = users.first(where: {$0.login == "Pushinka.52NGG"})

        let pushinkaPost2 = Post(context: viewContext)
        pushinkaPost2.id = UUID()
        pushinkaPost2.postImage = UIImage(named: "cat2Image")?.pngData()
        pushinkaPost2.caption = "Мой друг 2"
        pushinkaPost2.date = "07.08.2005"
        pushinkaPost2.isFavorite = false
        pushinkaPost2.author = users.first(where: { $0.login == "Pushinka.52NGG" })

        let pushinkaPost3 = Post(context: viewContext)
        pushinkaPost3.id = UUID()
        pushinkaPost3.postImage = UIImage(named: "cat3Image")?.pngData()
        pushinkaPost3.caption = "Мой друг 3"
        pushinkaPost3.date = "08.09.2004"
        pushinkaPost3.isFavorite = false
        pushinkaPost3.author = users.first(where: { $0.login == "Pushinka.52NGG" })

        let pushinkaPost4 = Post(context: viewContext)
        pushinkaPost4.id = UUID()
        pushinkaPost4.postImage = UIImage(named: "cat4Image")?.pngData()
        pushinkaPost4.caption = "Мой друг 4"
        pushinkaPost4.date = "09.10.2003"
        pushinkaPost4.isFavorite = false
        pushinkaPost4.author = users.first(where: { $0.login == "Pushinka.52NGG" })

        let pushinkaPost5 = Post(context: viewContext)
        pushinkaPost5.id = UUID()
        pushinkaPost5.postImage = UIImage(named: "cat5Image")?.pngData()
        pushinkaPost5.caption = "Мой друг 5"
        pushinkaPost5.date = "10.11.2002"
        pushinkaPost5.isFavorite = false
        pushinkaPost5.author = users.first(where: { $0.login == "Pushinka.52NGG" })

        let pushinkaPost6 = Post(context: viewContext)
        pushinkaPost6.id = UUID()
        pushinkaPost6.postImage = UIImage(named: "cat6Image")?.pngData()
        pushinkaPost6.caption = "Мой друг 6"
        pushinkaPost6.date = "11.12.2001"
        pushinkaPost6.isFavorite = false
        pushinkaPost6.author = users.first(where: { $0.login == "Pushinka.52NGG" })

        let adminPost1 = Post(context: viewContext)
        adminPost1.id = UUID()
        adminPost1.postImage = UIImage.adminLogo.pngData()
        adminPost1.caption = "Мой админ 1"
        adminPost1.date = "01.01.2006"
        adminPost1.isFavorite = false
        adminPost1.author = users.first(where: { $0.login == "Admin" })

        let adminPost2 = Post(context: viewContext)
        adminPost2.id = UUID()
        adminPost2.postImage = UIImage.adminLogo.pngData()
        adminPost2.caption = "Мой админ 2"
        adminPost2.date = "02.02.2005"
        adminPost2.isFavorite = false
        adminPost2.author = users.first(where: { $0.login == "Admin" })

        let adminPost3 = Post(context: viewContext)
        adminPost3.id = UUID()
        adminPost3.postImage = UIImage.adminLogo.pngData()
        adminPost3.caption = "Мой админ 3"
        adminPost3.date = "03.03.2004"
        adminPost3.isFavorite = false
        adminPost3.author = users.first(where: { $0.login == "Admin" })

        let dogLoverPost1 = Post(context: viewContext)
        dogLoverPost1.id = UUID()
        dogLoverPost1.postImage = UIImage.dog1.pngData()
        dogLoverPost1.caption = "Мой друг собака 1"
        dogLoverPost1.date = "10.01.2006"
        dogLoverPost1.isFavorite = false
        dogLoverPost1.author = users.first(where: { $0.login == "dogLover" })

        let dogLoverPost2 = Post(context: viewContext)
        dogLoverPost2.id = UUID()
        dogLoverPost2.postImage = UIImage.dog2.pngData()
        dogLoverPost2.caption = "Мой друг собака 2"
        dogLoverPost2.date = "10.02.2005"
        dogLoverPost2.isFavorite = false
        dogLoverPost2.author = users.first(where: { $0.login == "dogLover" })

        let dogLoverPost3 = Post(context: viewContext)
        dogLoverPost3.id = UUID()
        dogLoverPost3.postImage = UIImage.dog3.pngData()
        dogLoverPost3.caption = "Мой друг собака 3"
        dogLoverPost3.date = "10.03.2004"
        dogLoverPost3.isFavorite = false
        dogLoverPost3.author = users.first(where: { $0.login == "dogLover" })

        saveContext()
    }
}
