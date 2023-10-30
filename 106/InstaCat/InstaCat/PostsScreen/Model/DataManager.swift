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

    func syncSearchByName(_ name: String)
    func asyncSearchByName(_ name: String)

    func syncSearchById(_ id: Int)
    func asyncSearchById(_ id: Int)

    func syncDelete(index: Int)
    func asyncDelete(index: Int)
}

public class DataManager: DataManagerProtocol {

    private var posts: [Post] = []

    private var filteredPosts: [Post] = []

    var filteredPostsCount: Int {
        return filteredPosts.count
    }

    var isSearching: Bool = false
    static let shared = DataManager()

    private init() {
        posts = [
            Post(id: 0, imageName: "cat1", description: "очень крутой кот 1"),
            Post(id: 1, imageName: "cat2", description: "кот смотрит 2"),
            Post(id: 2, imageName: "cat3", description: "кот в крутой кепке из одеяла 3"),
            Post(id: 3, imageName: "cat4", description: "два кота смотрят головача 4"),
            Post(id: 4, imageName: "cat5", description: "котик устал жесть 5"),
            Post(id: 5, imageName: "catcar", description: "мотомото котомоболь 6"),
            Post(id: 6, imageName: "cat7", description: "крутой кот в чоках 7"),
            Post(id: 7, imageName: "cat8", description: "еще один крутой кот в очечях 8"),
            Post(id: 8, imageName: "cat2", description: "опять кот смотрит 9"),
            Post(id: 9, imageName: "cat7", description: "снизу крутой кот 10"),
            Post(id: 10, imageName: "cat1", description: "всерху крутой кот 11"),
            Post(id: 11, imageName: "cat5", description: "устал жесть КОТикк 12"),
            Post(id: 12, imageName: "cat6", description: "Кот под чем-то 13")
        ]
    }

    func syncGetSearchedPosts() -> [Post] {
        return filteredPosts
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

    func syncSearchByName(_ name: String) {
        filteredPosts = posts.filter { $0.description.lowercased().contains(name.lowercased()) }
    }

    func asyncSearchByName(_ name: String) {
        let operationQueue = OperationQueue()
        let operation = BlockOperation {
            self.filteredPosts = self.posts.filter { $0.description.lowercased().contains(name.lowercased()) }
        }

        operation.completionBlock = {
            print("found!")
        }
        operationQueue.addOperation(operation)
    }

    func syncSearchById(_ id: Int) {
        filteredPosts = posts.filter { $0.id == id }
    }

    func asyncSearchById(_ id: Int) {
        let operationQueue = OperationQueue()

        let operation = BlockOperation {
            self.filteredPosts = self.posts.filter { $0.id == id }
        }

        operation.completionBlock = {
            print("found!")
        }

        operationQueue.addOperation(operation)
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
