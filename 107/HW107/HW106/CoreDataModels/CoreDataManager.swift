import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    private var searchedPosts: [Post] = []

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    private init() {}

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
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
}

extension CoreDataManager {
    func getAllUsers() -> [User] {
        let userFetchRequest = User.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "login", ascending: true)
        userFetchRequest.sortDescriptors = [sortDescriptor]

        let result = try? viewContext.fetch(userFetchRequest)
        return result ?? []
    }

    func getCurUser() -> User? {
        let users = getAllUsers()
        let curUserId = UserDefaults.standard.string(forKey: "currentUser")
        return users.first(where: { $0.id.uuidString == curUserId })
    }

    func createUser(login: String, password: String) {
        let user = User(context: viewContext)
        user.id = UUID()
        user.login = login
        user.password = password
        user.avatarImageName = "defaultUser"

        saveContext()
    }

    func deleteUser(user: User) {
        viewContext.delete(user)
        saveContext()
    }

    func getFriendsFromCurUser() -> [User] {
        let freindsArray = getCurUser()?.friends?.allObjects as? [Friend] ?? []
        var friendsUserArray: [User] = []
        for friend in freindsArray {
            friendsUserArray.append(friend.friendUserEntity)
        }
        return friendsUserArray
    }

    func createPostForCurUser(description: String, date: String, imageName: String) {
        let post = Post(context: viewContext)
        let curUser = getCurUser()
        post.user = curUser
        post.id = UUID()
        post.postDescription = description
        post.postDate = date
        post.postImageName = imageName
        curUser?.addToPosts(post)
        saveContext()
    }

    func getAllPosts() -> [Post] {
        let userFetchRequest = Post.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "postDate", ascending: true)
        userFetchRequest.sortDescriptors = [sortDescriptor]

        let result = try? viewContext.fetch(userFetchRequest)
        return result ?? []
    }

    func getAllPostForCurUserFriends() -> [Post] {
        let posts = getAllPosts()
        let friends = getFriendsFromCurUser()
        return posts.filter({ friends.contains($0.user ?? User()) })
    }

    func getPostById(id: UUID) -> Post? { getAllPosts().first(where: { $0.id == id }) }

    func getPostByDescription(description: String) {
        searchedPosts = getPostsFromCurUser().filter({ $0.postDescription.contains(description) })
    }

    func getSearchedPosts() -> [Post] { searchedPosts }

    func getPostsFromCurUser() -> [Post] { getCurUser()?.posts?.allObjects as? [Post] ?? [] }

    func updatePostById(id: UUID, description: String, imageName: String) {
        let post = getPostById(id: id)
        post?.postImageName = imageName
        post?.postDescription = description
        saveContext()
    }

    func deletePostById(id: UUID) {
        guard let post = getPostById(id: id) else { return }
        getCurUser()?.removeFromPosts(getPostById(id: id) ?? Post())
        viewContext.delete(post)
        saveContext()
    }

    func getAllLikedPostsForCurUser() -> [Like] {
        let likedPostsFetchRequest = Like.fetchRequest()
        guard let curUser = getCurUser() else { return [] }
        likedPostsFetchRequest.predicate = NSPredicate(format: "user.id == %@", curUser.id as CVarArg)
        do {
            let likedPosts = try viewContext.fetch(likedPostsFetchRequest)
            return likedPosts
        } catch {
            print("Fetching error \(error)")
        }
        return []
    }

    func isPostLikedByCurUser(post: Post) -> Bool {
        let likes = getAllLikedPostsForCurUser()
        return likes.contains(where: { $0.post?.id == post.id })
    }

    func toggleLikeForPost(post: Post) {
        if isPostLikedByCurUser(post: post) {
            guard let like = getAllLikedPostsForCurUser().first(where: { $0.post?.id == post.id }) else { return }
            viewContext.delete(like)
        } else {
            let like = Like(context: viewContext)
            like.id = UUID()
            like.user = getCurUser()
            like.post = post
            getCurUser()?.addToLikes(like)
            post.addToLiked(like)
        }
        saveContext()
    }

    func toggleCurUserSubs(user: User) {
        guard let curUser = getCurUser() else { return }
        if isCurUserSubToUser(user: user) {
            let friends = curUser.friends?.allObjects as? [Friend] ?? []
            guard let friendship = friends.first(where: { $0.friendUserEntity.id == user.id }) else { return }
            curUser.removeFromFriends(friendship)
            viewContext.delete(friendship)
        } else {
            let friendship = Friend(context: viewContext)
            friendship.id = UUID()
            friendship.user = curUser
            friendship.friendUserEntity = user
            curUser.addToFriends(friendship)
        }
        saveContext()
    }

    func isCurUserSubToUser(user: User) -> Bool {
        let friends = CoreDataManager.shared.getFriendsFromCurUser()
        return friends.contains(where: { $0.id == user.id })
    }

    func getLikeCount(post: Post) -> Int {
        return post.liked?.count ?? 0
    }

    func getCurUserSubsCount() -> Int {
        return getFriendsFromCurUser().count
    }

    func getAvatarNameByUser(user: User) -> String {
        switch user.login {
        case "Timerglot":
            return "avatar1"
        case "Giga_chad":
            return "avatar2"
        case "The_benko":
            return "avatar3"
        default:
            return "defaultUser"
        }
    }

    func createUsersFetchResultController() -> NSFetchedResultsController<User> {
        guard let user = getCurUser() else { return NSFetchedResultsController() }
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

    func setDefaultUsers() {
        let user1 = User(context: viewContext)
        user1.id = UUID()
        user1.login = "Timerglot"
        user1.password = "Tim1"
        user1.avatarImageName = "avatar1"

        let user2 = User(context: viewContext)
        user2.id = UUID()
        user2.login = "Giga_chad"
        user2.password = "G1ga"
        user2.avatarImageName = "avatar2"

        let user3 = User(context: viewContext)
        user3.id = UUID()
        user3.login = "The_benko"
        user3.password = "Misha"
        user3.avatarImageName = "avatar3"

        let user12Friendship = Friend(context: viewContext)
        user12Friendship.id = UUID()
        user12Friendship.user = user1
        user12Friendship.friendUserEntity = user2

        let user21Friendship = Friend(context: viewContext)
        user21Friendship.id = UUID()
        user21Friendship.user = user2
        user21Friendship.friendUserEntity = user1

        let user13Friendship = Friend(context: viewContext)
        user13Friendship.id = UUID()
        user13Friendship.user = user1
        user13Friendship.friendUserEntity = user3

        let user31Friendship = Friend(context: viewContext)
        user31Friendship.id = UUID()
        user31Friendship.user = user3
        user31Friendship.friendUserEntity = user1

        let user23Friendship = Friend(context: viewContext)
        user23Friendship.id = UUID()
        user23Friendship.user = user2
        user23Friendship.friendUserEntity = user3

        let user32Friendship = Friend(context: viewContext)
        user32Friendship.id = UUID()
        user32Friendship.user = user3
        user32Friendship.friendUserEntity = user2

        user1.addToFriends(user12Friendship)
        user1.addToFriends(user13Friendship)

        user2.addToFriends(user21Friendship)
        user2.addToFriends(user23Friendship)

        user3.addToFriends(user31Friendship)
        user3.addToFriends(user32Friendship)

        saveContext()
    }

    func setDefaultPosts() {
        let users = getAllUsers()

        let post1 = Post(context: viewContext)
        post1.id = UUID()
        post1.postDescription = "First post"
        post1.postDate = "09.03.2023"
        post1.postImageName = "image_1"
        post1.user = users.first(where: { $0.login == "Timerglot" })

        let post2 = Post(context: viewContext)
        post2.id = UUID()
        post2.postDescription = "Second post"
        post2.postDate = "12.05.2023"
        post2.postImageName = "image_2"
        post2.user = users.first(where: { $0.login == "Timerglot" })

        let post3 = Post(context: viewContext)
        post3.id = UUID()
        post3.postDescription = "Third post"
        post3.postDate = "21.07.2023"
        post3.postImageName = "image_3"
        post3.user = users.first(where: { $0.login == "Timerglot" })

        let post4 = Post(context: viewContext)
        post4.id = UUID()
        post4.postDescription = "First post"
        post4.postDate = "03.01.2023"
        post4.postImageName = "image_4"
        post4.user = users.first(where: { $0.login == "Giga_chad" })

        let post5 = Post(context: viewContext)
        post5.id = UUID()
        post5.postDescription = "Second post"
        post5.postDate = "11.04.2023"
        post5.postImageName = "image_5"
        post5.user = users.first(where: { $0.login == "Giga_chad" })

        let post6 = Post(context: viewContext)
        post6.id = UUID()
        post6.postDescription = "Third post"
        post6.postDate = "15.07.2023"
        post6.postImageName = "image_6"
        post6.user = users.first(where: { $0.login == "Giga_chad" })

        let post7 = Post(context: viewContext)
        post7.id = UUID()
        post7.postDescription = "First post"
        post7.postDate = "05.01.2023"
        post7.postImageName = "image_7"
        post7.user = users.first(where: { $0.login == "The_benko" })

        let post8 = Post(context: viewContext)
        post8.id = UUID()
        post8.postDescription = "Second post"
        post8.postDate = "07.02.2023"
        post8.postImageName = "image_1"
        post8.user = users.first(where: { $0.login == "The_benko" })

        let post9 = Post(context: viewContext)
        post9.id = UUID()
        post9.postDescription = "Third post"
        post9.postDate = "10.03.2023"
        post9.postImageName = "image_4"
        post9.user = users.first(where: { $0.login == "The_benko" })

        let post10 = Post(context: viewContext)
        post10.id = UUID()
        post10.postDescription = "Fourth post"
        post10.postDate = "11.04.2023"
        post10.postImageName = "image_5"
        post10.user = users.first(where: { $0.login == "The_benko" })

        let post11 = Post(context: viewContext)
        post11.id = UUID()
        post11.postDescription = "Third post"
        post11.postDate = "25.07.2023"
        post11.postImageName = "image_6"
        post11.user = users.first(where: { $0.login == "The_benko" })

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

    func deleteAllPosts() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Post")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print("Ошибка удаления объектов User: \(error), \(error.userInfo)")
        }
    }

    func deleteAllLikes() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Like")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print("Ошибка удаления объектов User: \(error), \(error.userInfo)")
        }
    }

    func deleteAllFriends() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Friend")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print("Ошибка удаления объектов User: \(error), \(error.userInfo)")
        }
    }
}
