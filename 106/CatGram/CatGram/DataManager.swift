//
//  DataManager.swift
//  CatGram
//
//  Created by Mac on 2023-10-30.
//

import UIKit

protocol DataManagerProtocol {
    func savePostSunc(_ post: Post)
    func savePostAsync(_ post: Post)

    func getPostsSync() -> [Post]
    func getPostsAsync(completion: @escaping ([Post]) -> Void)

    func searchByIdSync(_ id: Int) -> [Post]
    func searchByIdAsync(_ id: Int, completion: @escaping ([Post]) -> Void)

    func deletePostSync(_ index: Int)
    func deletePostAsync(_ index: Int)
}

class DataManager: DataManagerProtocol {
    lazy var posts: [Post] = []
    static let dataManager = DataManager()

    private init() {
        self.posts = createPosts()
    }

    private let savePostQueue = OperationQueue()
    private let deletePostQueue = OperationQueue()
    private let searchByIdQueue = OperationQueue()
    private let getPostsQueue = OperationQueue()

    func savePostSunc(_ post: Post) {
        posts.append(post)
    }
    func savePostAsync(_ post: Post) {
        let operation = BlockOperation {
            self.posts.append(post)
        }
        operation.completionBlock = {
            print("пост c описанием \(post.description) добавлен асинк")
        }
        savePostQueue.addOperation(operation)
    }
    func deletePostSync(_ index: Int) {
        self.posts.remove(at: index)
    }
    func deletePostAsync(_ index: Int) {
        let operation = BlockOperation {
            self.posts.remove(at: index)
        }
        operation.completionBlock = {
            print("пост по индексу \(index) удалён асинк")
        }
        deletePostQueue.addOperation(operation)
    }
    func getPostsSync() -> [Post] {
        return posts
    }
    func getPostsAsync(completion: @escaping ([Post]) -> Void) {
        var result: [Post] = []
        let operation = BlockOperation {
            result = self.posts
        }
        operation.completionBlock = {
            print("все посты найдены асинк")
            completion(result)
        }
        getPostsQueue.addOperation(operation)
    }
    func searchByIdSync(_ id: Int) -> [Post] {
        let result = posts.filter { $0.id == id }
        return result
    }
    func searchByIdAsync(_ id: Int, completion: @escaping ([Post]) -> Void) {
        var result: [Post] = []
        let operation = BlockOperation {
            result = self.posts.filter { $0.id == id }
        }
        operation.completionBlock = {
            print("все посты по id \(id) найдены асинк")
            completion(result)
        }
        searchByIdQueue.addOperation(operation)
    }
    func deleteSync(index: Int) {
        posts.remove(at: index)
    }
    func deleteAsync(index: Int) {
        let operation = BlockOperation {
            self.posts.remove(at: index)
        }
        operation.completionBlock = {
            print("пост по индексу \(index) удален асинк")
        }
        deletePostQueue.addOperation(operation)
    }
}

// MARK: - Support things
extension DataManager {
    private func createImageCat(_ name: String) -> UIImage {
        UIImage(named: name) ?? UIImage()
    }
    private func createUser() -> User {
        User(iconUrl: URL(string: "https://clck.ru/36GD6d")!, nick: "evaklq")
    }
    private func createPost() -> Post {
        let user = createUser()
        let photos = createCatsImages()
        let descriptions = createCatsDescriptions()
        let post = Post(id: Int.random(in: 1...20),
                    author: user,
                    photos: photos[Int.random(in: 0...6)],
                    dateOfPublication: Date.now,
                    comments: [], amountOfLikes: 7,
                    description: descriptions[Int.random(in: 0...3)])
        return post
    }
    private func createCatsImages() -> [UIImage] {
        let photos = [
            createImageCat("cat1"),
            createImageCat("cat2"),
            createImageCat("cat3"),
            createImageCat("cat4"),
            createImageCat("cat5"),
            createImageCat("cat6"),
            createImageCat("cat7")
        ]
        return photos
    }
    private func createCatsDescriptions() -> [String] {
        let words = [
            "Супер кот лялялялялялял супер кот лялялялялял",
            "Мне очень нравится этот кот, он очень милый и хороший, я его люблю",
            "кааааайф",
            "мяу мяу мяу мяуямуя"
        ]
        return words
    }
    private func createPosts() -> [Post] {
        [
            createPost(),
            createPost(),
            createPost(),
            createPost(),
            createPost(),
            createPost(),
            createPost(),
            createPost(),
            createPost(),
            createPost(),
            createPost(),
            createPost(),
            createPost(),
            createPost()
        ]
    }
}
