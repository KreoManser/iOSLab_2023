//
//  DataManager.swift
//  InstaCat
//
//  Created by Камил Хайрутдинов on 29.10.2023.
//

import Foundation
protocol DataManagerProtocol {
    func syncSave(_ post: Post)
    func asyncSave(_ post: Post)

    func syncGetAllPosts() -> [Post]
    func asyncGetAllPosts() -> [Post]

    func syncSearchByName(_ name: String) -> [Post]
    func asyncSearchByName(_ name: String) -> [Post]

    func syncSearchById(_ id: Int) -> [Post]
    func asyncSearchById(_ id: Int) -> [Post]

    func syncDelete(index: Int)
    func asyncDelete(index: Int)
}

public class DataManager: DataManagerProtocol {

    private var posts: [Post] = []

    static let shared = DataManager()

    private init() {
        posts = [
            Post(id: 0, imageName: "cat1", description: "В чем секрет кота бориса? Он крутой"),
            Post(id: 1, imageName: "cat2", description: "В чем секрет кота бориса? Он крутой"),
            Post(id: 2, imageName: "cat3", description: "В чем секрет кота бориса? Он крутой"),
            Post(id: 3, imageName: "cat4", description: "В чем секрет кота бориса? Он крутой"),
            Post(id: 4, imageName: "cat5", description: "В чем секрет кота бориса? Он крутой"),
            Post(id: 5, imageName: "cat6", description: "В чем секрет кота бориса? Он крутой"),
            Post(id: 6, imageName: "cat7", description: "В чем секрет кота бориса? Он крутой"),
            Post(id: 7, imageName: "cat8", description: "В чем секрет кота бориса? Он крутой"),
            Post(id: 8, imageName: "cat2", description: "В чем секрет кота бориса? Он крутой"),
            Post(id: 9, imageName: "cat7", description: "В чем секрет кота бориса? Он крутой"),
            Post(id: 10, imageName: "cat2", description: "В чем секрет кота бориса? Он крутой"),
            Post(id: 11, imageName: "cat5", description: "В чем секрет кота бориса? Он крутой")
        ]
    }

    func syncSave(_ post: Post) {
        posts.append(post)
    }

    func asyncSave(_ post: Post) {
        let operationQueue = OperationQueue()

        let operation = BlockOperation {
            self.posts.append(post)
        }

        operation.completionBlock = {
            print("saved!")
        }

        operationQueue.addOperation(operation)
    }

    func syncGetAllPosts() -> [Post] {
        return posts
    }

    func asyncGetAllPosts() -> [Post] {
        var result: [Post] = []

        let operationQueue = OperationQueue()

        let operation = BlockOperation {
            result = self.posts
        }

        operation.completionBlock = {
            print("post get all")
        }

        operationQueue.addOperation(operation)
        return result
    }

    func syncSearchByName(_ name: String) -> [Post] {
        let result = posts.filter { $0.description == name }
        return result
    }

    func asyncSearchByName(_ name: String) -> [Post] {
        let operationQueue = OperationQueue()
        var result: [Post] = []
        let operation = BlockOperation {
            result = self.posts.filter { $0.description == name }
        }

        operation.completionBlock = {
            print("found!")
        }
        operationQueue.addOperation(operation)

        return result
    }

    func syncSearchById(_ id: Int) -> [Post] {
        let result = posts.filter { $0.id == id }
        return result
    }

    func asyncSearchById(_ id: Int) -> [Post] {
        let operationQueue = OperationQueue()
        var result: [Post] = []
        let operation = BlockOperation {
            result = self.posts.filter { $0.id == id }
        }

        operation.completionBlock = {
            print("found!")
        }

        operationQueue.addOperation(operation)

        return result
    }

    func syncDelete(index: Int) {
        posts.remove(at: index)
    }

    func asyncDelete(index: Int) {
        let operationQueue = OperationQueue()

        let operation = BlockOperation {
            self.posts.remove(at: index)
        }

        operation.completionBlock = {
            print("Deleted!")
        }

        operationQueue.addOperation(operation)
    }

}
