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
    private init () {}
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Coredata")
        container.loadPersistentStores(completionHandler: {( storeDescription, error) in
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
            let day = Int.random(in: 1..<32)
            let mounth = Int.random(in: 1..<13)
            let year = Int.random(in: 2000..<2024)
            post.postDate = "\(day):\(mounth):\(year)"
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
            post.userPostId = user1.userId
            post.isLiked = false
            post.counterLikes = 0
            post.postPhotoNmae = "Photo2"
            post.postComment = "Пост: \(counter)"
            let day = Int.random(in: 1..<32)
            let mounth = Int.random(in: 1..<13)
            let year = Int.random(in: 2000..<2024)
            post.postDate = "\(day):\(mounth):\(year)"
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
            post.userPostId = user1.userId
            post.isLiked = false
            post.counterLikes = 0
            post.postPhotoNmae = "Photo3"
            post.postComment = "Пост: \(counter)"
            var day = Int.random(in: 1..<32)
            var mounth = Int.random(in: 1..<13)
            var year = Int.random(in: 2000..<2024)
            post.postDate = "\(day):\(mounth):\(year)"
            user3.addToPosts(post)
        }
        users.append(user1)
        users.append(user2)
        users.append(user3)
        return users
    }
    func obtaineSavedData() -> [User] {
        let userFetchRequest = User.fetchRequest()
        let sortDescriptors = NSSortDescriptor(key: "userName", ascending: true)
        userFetchRequest.sortDescriptors = [sortDescriptors]
        let result = try? viewContext.fetch(userFetchRequest)
        return result ?? []
    }
}
