//
//  DataManager.swift
//  Homework6
//
//  Created by kerik on 30.10.2023.
//

import Foundation

protocol DataManagerProtocol {
    func syncSave(_ post: Post)
    func asyncSave(_ post: Post)

    func syncGetAllPosts() -> [Post]
    func asyncGetAllPosts() -> [Post]

    func syncDelete(index: Int)
    func asyncDelete(index: Int)
}

public class DataManager: DataManagerProtocol {

    private var posts: [Post] = []

    static let shared = DataManager()

    private init() {
        posts = [
            Post(id: 1, imageName: "cat1", description: "Кот 1", date: "18-04-2023"),
            Post(id: 2, imageName: "cat2", description: "Кот 2", date: "30-05-2022"),
            Post(id: 3, imageName: "cat3", description: "Кот 3", date: "20-06-2011"),
            Post(id: 4, imageName: "cat4", description: "Кот 4", date: "10-06-2004"),
            Post(id: 5, imageName: "cat5", description: "Кот 5", date: "7-09-2022"),
            Post(id: 6, imageName: "cat6", description: "Кот 6", date: "7-09-2022"),
            Post(id: 7, imageName: "cat7", description: "Кот 7", date: "7-09-2022")
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
