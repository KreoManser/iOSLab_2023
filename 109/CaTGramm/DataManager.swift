//
//  DataManager.swift
//  CaTGramm
//
//  Created by Rustem on 29.10.2023.
//

import Foundation
import UIKit

class DataManager: DataManagerProtocol {

    var dataSource: [Post]

    var currentUser: User

    func syncSave(_ picture: Post) {
        if let i = dataSource.firstIndex(where: { $0.id == picture.id }) {
            dataSource[i] = picture
            print("picture saved sync")
        }
    }

    func asyncSave(_ picture: Post) {
        let operationQueue = OperationQueue()
        let saveOperation = BlockOperation {
            print("async saving started")
        }
        saveOperation.completionBlock = {
            if let i = self.dataSource.firstIndex(where: { $0.id == picture.id }) {
                self.dataSource[i] = picture
                print("picture saved async")
            }
        }
        operationQueue.addOperation(saveOperation)
    }

    func syncGetAllPosts() -> [Post] {
        return dataSource
    }

    func syncGetCurrentUserPosts() -> [Post] {
        return dataSource.filter { $0.nickname == self.getCurrentUser().userName }
    }

    func getCurrentUser() -> User {
        return UserManager.shared.syncGetUserByName(username: UserDefaults.standard.string(forKey: "current_user") ?? "UsualCat")
    }

    func syncGetModel(_ picture: Post) {
        if let i = dataSource.firstIndex(where: { $0.id == picture.id }) {
            print("\(i) is the index of this picture")
        }
    }

    func asyncGetModel(_ picture: Post) {
        let operationQueue = OperationQueue()
        let getOperation = BlockOperation {
            print("async getting started")
        }
        getOperation.completionBlock = {
            if let i = self.dataSource.firstIndex(where: { $0.id == picture.id }) {
                print("\(i) is the index of this picture")
            }
        }
        operationQueue.addOperation(getOperation)
    }

    func syncDeleteModel(_ picture: Post) {
        if let i = dataSource.firstIndex(where: { $0.id == picture.id }) {
            dataSource.remove(at: i)
            print("picture deleted sync")
            print(dataSource.count)
        }
    }

    func asyncDeleteModel(_ picture: Post) {
        let operationQueue = OperationQueue()
        let deleteOperation = BlockOperation {
            print("async deleting started")
        }
        deleteOperation.completionBlock = {
            if let i = self.dataSource.firstIndex(where: { $0.id == picture.id }) {
                self.dataSource.remove(at: i)
                print("picture deleted async")
            }
        }
        operationQueue.addOperation(deleteOperation)
    }

    func syncSearchModel(_ name: String) {
        if let i = dataSource.firstIndex(where: { $0.text == name }) {
            print("\(dataSource[i]) is our post")
        }
    }

    func asyncSearchModel(_ name: String) {
        let operationQueue = OperationQueue()
        let deleteOperation = BlockOperation {
            print("async finding by desc started")
        }
        deleteOperation.completionBlock = {
            if let i = self.dataSource.firstIndex(where: { $0.text == name }) {
                print("\(self.dataSource[i]) is our post")
            }
        }
        operationQueue.addOperation(deleteOperation)
    }

    func getCurrentUserLikedPosts() -> [PictureModel] {
        let emptyLikes: [PictureModel] = []
        return (UserDefaults.standard.array(forKey: "liked_posts") ?? nil) as? [PictureModel] ?? emptyLikes
    }

    private init () {
        currentUser = UserManager.shared.syncGetUserByName(username: UserDefaults.standard.string(forKey: "current_user") ?? "UsualCat")
        dataSource = []
        let post = Post(context: CoreDataManager.shared.viewContext)
        post.user = UserManager.shared.syncGetUserByName(username: "123")
        post.date = Date()
        post.likes = Set<Like>()
        post.avatar = "myava"
        post.picture = "myava"
        post.nickname = post.user.userName
        post.text = "моя топ ава)"
        post.id = UUID()
        dataSource.append(post)
    }

    func createPost(avatar: String, nickname: String, picture: String, text: String) -> Post {
        let post = Post(context: CoreDataManager.shared.viewContext)
        post.user = getCurrentUser()
        post.date = Date()
        post.likes = Set<Like>()
        post.avatar = "myava"
        post.picture = "myava"
        post.nickname = post.user.userName
        post.text = "моя топ ава)"
        post.id = UUID()
        return post
    }

    public static var OurDataManager = DataManager()
}
