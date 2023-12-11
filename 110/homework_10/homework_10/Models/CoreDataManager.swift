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
        let container = NSPersistentContainer(name: "homework_10")
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
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Post")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print("Ошибка удаления объектов User: \(error), \(error.userInfo)")
        }
    }

    func getFriendsByUser() -> [User] {
        let freindsArray = getAuthUser()?.friends?.allObjects as? [Friends] ?? []
        var friendsUserArray: [User] = []
        for friend in freindsArray {
            friendsUserArray.append(friend.friend)
        }
        return friendsUserArray
    }

    // MARK: - Core Data Post Func-s

    func obtainAllPosts() -> [Post] {
        let userFetchRequest = Post.fetchRequest()

        let result = try? viewContext.fetch(userFetchRequest)
        return result ?? []
    }

    func obtainPostById(id: UUID) -> Post? {
        let posts = obtainAllPosts()
        return posts.first(where: {$0.id.uuidString == id.uuidString})
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
}
