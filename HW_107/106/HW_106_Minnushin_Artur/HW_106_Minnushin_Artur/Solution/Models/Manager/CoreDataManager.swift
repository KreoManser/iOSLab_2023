//
//  CoreDataManager.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 10.12.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    var obtainUsers: [User] = []
    var authorizationUser: User?
    private init () {}
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Coredata")
        container.loadPersistentStores(completionHandler: {( _, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
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
    func addNewUser(login: String, password: String, name: String, subscription: String, avatarNmae: String) {
        let user = User(context: viewContext)
        user.userLogin = login
        user.userPassword = password
        user.userName = name
        user.userDescription = subscription
        user.userAvatarImageName = avatarNmae
        let newID = Int64.random(in: 1..<100000)
        for userObj in obtaineSavedUser() where userObj.userId != newID {
            user.userId = newID
            break
        }
        user.posts = []
        user.likedPost = []
        user.userCountFolowers = 0
        user.userCountFolowing = 0
        user.userCountPosts = Int32(user.posts.count)
        authorizationUser = user
        if viewContext.hasChanges {
            try? viewContext.save()
        }
    }
    func deletePost(userId: Int, postId: Int) {
        if let user = obtaineSavedUser().first(where: {$0.userId == userId}) {
            if let post = user.posts.first(where: {$0.postID == postId}) {
                viewContext.delete(post)
                try? viewContext.save()
            }
        }
    }
    func addPost(userId: Int,
                 photoName: String,
                 postComment: String,
                 postDay: Int,
                 postMounth: Int,
                 postYear: Int) {
        if let user = obtaineSavedUser().first(where: {$0.userId == userId}) {
            let post = Post(context: viewContext)
            var newID = Int64.random(in: 1..<100000)
            var flag = false
            while flag == false {
                newID = Int64.random(in: 1..<100000)
                for postObj in user.posts {
                    if postObj.postID == newID {
                        flag = false
                        break
                    }
                    flag = true
                }
            }
            post.postID = newID
            post.isLiked = false
            post.counterLikes = 0
            post.postPhotoNmae = photoName
            post.postComment = postComment
            var dateComponents = DateComponents()
            dateComponents.year = postYear
            dateComponents.month = postMounth
            dateComponents.day = postDay
            post.postDate = Calendar.current.date(from: dateComponents)!
            user.addToPosts(post)
        }
    }
    func deleteUser(id: Int) {
        let user = obtaineSavedUser().first(where: {$0.userId == id})
        viewContext.delete(user!)
        try? viewContext.save()
    }
    func obtaineSavedUser() -> [User] {
        let userFetchRequest = User.fetchRequest()
        let sortDescriptors = NSSortDescriptor(key: "userName", ascending: true)
        userFetchRequest.sortDescriptors = [sortDescriptors]
        let result = try? viewContext.fetch(userFetchRequest)
        return result ?? []
    }
    func obtaineSavedPost() -> [Post] {
        let postFetchRequest = Post.fetchRequest()
        let sortDescriptors = NSSortDescriptor(key: "postDate", ascending: true)
        postFetchRequest.sortDescriptors = [sortDescriptors]
        let result = try? viewContext.fetch(postFetchRequest)
        return result ?? []
    }
    func obtaineSavedLikedPost() -> [LikedPost] {
        let likedPostFetchRequest = LikedPost.fetchRequest()
        let sortDescriptors = NSSortDescriptor(key: "userPostId", ascending: true)
        likedPostFetchRequest.sortDescriptors = [sortDescriptors]
        let result = try? viewContext.fetch(likedPostFetchRequest)
        return result ?? []
    }
    func obtaineSavedFriend() -> [Friends] {
        let likedPostFetchRequest = Friends.fetchRequest()
        let sortDescriptors = NSSortDescriptor(key: "userPostId", ascending: true)
        likedPostFetchRequest.sortDescriptors = [sortDescriptors]
        let result = try? viewContext.fetch(likedPostFetchRequest)
        return result ?? []
    }
    func checkAuth(login: String, password: String) -> Bool {
        var users: [User]
        if !obtainDefaultData().isEmpty {
            users = obtaineSavedUser()
        } else {
            users = obtainDefaultData()
        }
        authorizationUser = users.first(where: {$0.userLogin == login && $0.userPassword == password})
        if authorizationUser != nil {
            return true
        } else {
            return false
        }
    }
    func getAuthorizationUser() -> User {
        return authorizationUser!
    }
    func getAllPost() -> [Post] {
        var posts: [Post] = []
        for user in obtaineSavedUser() {
            posts.append(contentsOf: user.posts)
        }
        posts.sort {$0.postDate > $1.postDate}
        return posts
    }
    func updateAuthorizationUser(user: User) {
        authorizationUser = user
    }
    func getPostsAuthorizationUser() -> [Post] {
        var posts: [Post] = []
        authorizationUser?.posts.forEach({ post in
            posts.append(post)
        })
        posts.sort {$0.postDate > $1.postDate}
        return posts
    }
    func deletePostById(userId: Int, postId: Int) {
        if let user = obtaineSavedUser().first(where: {$0.userId == userId}) {
            if let post = user.posts.first(where: {$0.postID == postId}) {
                viewContext.delete(post)
                if viewContext.hasChanges {
                    try? viewContext.save()
                }
            }
        }
    }
    func loginCheck(login: String) -> Bool {
        for user in obtaineSavedUser() where user.userLogin == login {
            print(user.userLogin)
            print(login)
            return true
        }
        return false
    }
    func checkLiked(userId: Int, postId: Int) -> Bool {
        for post in authorizationUser!.likedPost
        where post.userPostId == userId && post.postID == postId && post.user == authorizationUser {
            return true
        }
        return false
    }
    func checkFriended(userId: Int) -> Bool {
        for friend in authorizationUser!.friends where friend.userID == userId {
            return true
        }
        return false
    }
    func updateFriends(userID: Int) {
        if checkFriended(userId: userID) {
            let friend = (authorizationUser?.friends.first(where: {$0.userID == userID})!)!
            obtaineSavedUser().first(where: {$0.userId == userID})?.userCountFolowers -= 1
            viewContext.delete(friend)
        } else {
            let friend = Friends(context: viewContext)
            friend.userID = Int32(userID)
            obtaineSavedUser().first(where: {$0.userId == userID})?.userCountFolowers += 1
            authorizationUser?.addToFriends(friend)
        }
        if viewContext.hasChanges {
            try? viewContext.save()
        }
        print(authorizationUser?.friends.count)
    }
    func updateLikedPost(userId: Int, postId: Int) {
        if checkLiked(userId: userId, postId: postId) {
            let likedPost = obtaineSavedLikedPost().first(where: {
                $0.userPostId == Int64(userId) && $0.postID == Int64(postId)
            })!
            obtaineSavedPost().first(where: {
                $0.userPostId == Int64(userId) && $0.postID == Int64(postId)})!.counterLikes -= 1
            viewContext.delete(likedPost)
        } else {
            let likedPost = LikedPost(context: viewContext)
            likedPost.postID = Int64(postId)
            likedPost.userPostId = Int64(userId)
            obtaineSavedPost().first(where: {
                $0.userPostId == Int64(userId) && $0.postID == Int64(postId)})!.counterLikes += 1
            authorizationUser!.addToLikedPost(likedPost)
        }
        if viewContext.hasChanges {
            try? viewContext.save()
        }
    }
    func tapLikeButtonFunc(userId: Int, postId: Int) {
        if let user = obtaineSavedUser().first(where: {$0.userId == userId}) {
            if let post = user.posts.first(where: {$0.postID == postId}) {
                if post.isLiked == false {
                    post.counterLikes += 1
                    let likedPost = LikedPost(context: viewContext)
                    likedPost.postID = post.postID
                    likedPost.userPostId = user.userId
                    user.addToLikedPost(likedPost)
                } else {
                    post.counterLikes -= 1
                    if let deleteLikedPost = user.likedPost.first(where: {$0.postID == post.postID}) {
                        user.removeFromLikedPost(deleteLikedPost)
                        viewContext.delete(deleteLikedPost)
                    }
                }
                if viewContext.hasChanges {
                    try? viewContext.save()
                }
            }
        }
    }
    func createPreparedFetchedUserResultController() -> NSFetchedResultsController<User> {
        var userFetchRequest = User.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "userName", ascending: true)
        userFetchRequest.sortDescriptors = [sortDescriptor]
        let resultController = NSFetchedResultsController(
            fetchRequest: userFetchRequest,
            managedObjectContext: viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        return resultController
    }
    func createPreparedFetchedPostResultController() -> NSFetchedResultsController<Post> {
        let userFetchRequest = Post.fetchRequest()
        var idList: [Int64] = []
        for friend in authorizationUser!.friends {
            idList.append(Int64(friend.userID))
        }
        let sortDescriptor = NSSortDescriptor(key: "postDate", ascending: false)
        userFetchRequest.predicate = NSPredicate(format: "userPostId IN %@", idList)
        userFetchRequest.sortDescriptors = [sortDescriptor]
        let resultController = NSFetchedResultsController(
            fetchRequest: userFetchRequest,
            managedObjectContext: viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        return resultController
    }
    func deleteLike() {
        for likedPost in obtaineSavedLikedPost() {
            viewContext.delete(likedPost)
        }
        try? viewContext.save()
        for post in obtaineSavedPost() {
            post.counterLikes = 0
        }
    }
}

extension CoreDataManager {
    func obtainDefaultData() -> [User] {
            var users = [User]()
            let user1 = User(context: viewContext)
            user1.userLogin = "1"
            user1.userPassword = "1"
            user1.userId = 1
            user1.userName = "Artur Minnushin"
            user1.userAvatarImageName = "avatar1"
            user1.userCountPosts = 10
            user1.userCountFolowing = 10
            user1.userCountFolowers = 10
            user1.userDescription = "Я iOS разработчик и кот :)"
            for counter in 1..<9 {
                let post = Post(context: viewContext)
                post.postID = Int64(counter)
                post.userPostId = user1.userId
                post.isLiked = false
                post.counterLikes = 0
                post.postPhotoNmae = "Photo1"
                post.postComment = "Пост: \(counter)"
                var dateComponents = DateComponents()
                dateComponents.year = Int.random(in: 2000..<2024)
                dateComponents.month = Int.random(in: 1..<13)
                dateComponents.day = Int.random(in: 1..<32)
                post.postDate = Calendar.current.date(from: dateComponents)!
                user1.addToPosts(post)
            }
            user1.likedPost = []
            let user2 = User(context: viewContext)
            user2.userLogin = "2"
            user2.userPassword = "2"
            user2.userId = 2
            user2.userName = "Timofei Brisovix"
            user2.userAvatarImageName = "avatar2"
            user2.userCountPosts = 10
            user2.userCountFolowing = 10
            user2.userCountFolowers = 10
            user2.userDescription = "Я кот и что :)"
            user2.likedPost = []
            for counter in 1..<9 {
                let post = Post(context: viewContext)
                post.postID = Int64(counter)
                post.userPostId = user2.userId
                post.isLiked = false
                post.counterLikes = 0
                post.postPhotoNmae = "Photo2"
                post.postComment = "Пост: \(counter)"
                var dateComponents = DateComponents()
                dateComponents.year = Int.random(in: 2000..<2024)
                dateComponents.month = Int.random(in: 1..<13)
                dateComponents.day = Int.random(in: 1..<32)
                post.postDate = Calendar.current.date(from: dateComponents)!
                user2.addToPosts(post)
            }
            let user3 = User(context: viewContext)
            user3.userLogin = "3"
            user3.userPassword = "3"
            user3.userId = 3
            user3.userName = "Bond, Cat Bond"
            user3.userAvatarImageName = "avatar3"
            user3.userCountPosts = 10
            user3.userCountFolowing = 10
            user3.userCountFolowers = 10
            user3.userDescription = "Меня сложно найти, легко потерять и невозможно убить. Я Bond, Cat Bond"
            user3.likedPost = []
            for counter in 1..<9 {
                let post = Post(context: viewContext)
                post.postID = Int64(counter)
                post.userPostId = user3.userId
                post.isLiked = false
                post.counterLikes = 0
                post.postPhotoNmae = "Photo3"
                post.postComment = "Пост: \(counter)"
                var dateComponents = DateComponents()
                dateComponents.year = Int.random(in: 2000..<2024)
                dateComponents.month = Int.random(in: 1..<13)
                dateComponents.day = Int.random(in: 1..<32)
                post.postDate = Calendar.current.date(from: dateComponents)!
                user3.addToPosts(post)
            }
            users.append(user1)
            users.append(user2)
            users.append(user3)
            return users
        }
}
