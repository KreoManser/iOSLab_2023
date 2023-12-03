//
//  DataManager.swift
//  CatGram
//
//  Created by Mac on 2023-10-30.
//

import UIKit

protocol UpdateUserProtocol: AnyObject {
    func updateUser(posts: [Post])
    func updateLike(posts: [Post])
}

protocol UpdateNewsProtocol: AnyObject {
    func updateNews(posts: [Post])
}

protocol PostsManagerProtocol {
    func savePostSunc(_ post: Post)
    func savePostAsync(_ post: Post)

    func getPostsSync() -> [Post]
    func getPostsAsync(completion: @escaping ([Post]) -> Void)

    func searchByIdSync(_ id: Int) -> [Post]
    func searchByIdAsync(_ id: Int, completion: @escaping ([Post]) -> Void)

    func searchByNameSync(_ name: String)

    func searchByIndexSync(_ index: Int) -> Post

    func deletePostSync(_ index: Int)
    func deletePostAsync(_ index: Int)

    func likePostAsync(_ index: Int)
}

class PostsManager: PostsManagerProtocol {
    static let postsManager = PostsManager()
    weak var delegateUser: UpdateUserProtocol?
    weak var delegateNews: UpdateNewsProtocol?
    private let userDefaults = UserDefaults.standard

    private let support = SupportFunctions()

    var postWithFilter: [Post] = []
    var isSearching: Bool = false
    private var posts: [Post] = []

    private let savePostQueue = OperationQueue()
    private let deletePostQueue = OperationQueue()
    private let searchByIdQueue = OperationQueue()
    private let searchByNameQueue = OperationQueue()
    private let getPostsQueue = OperationQueue()
    private let likePostQueue = OperationQueue()

    func configurePosts(user: User) {
        self.posts = user.posts
    }

    func getSearchedPostsSync() -> [Post] {
        return postWithFilter
    }

    func searchByNameSync(_ name: String) {
        postWithFilter = posts.filter { $0.description.lowercased().contains(name.lowercased()) }
    }
    func searchByNameAsync(_ name: String) {
        let operation = BlockOperation {
            if name.count >= 3 {
                self.postWithFilter = self.posts.filter { $0.description.lowercased().contains(name.lowercased()) }
            } else {
                self.postWithFilter = self.posts
            }
        }
        operation.completionBlock = {
            print("посты с именем \(name) done асинк")
        }
        searchByNameQueue.addOperation(operation)
    }
    func searchByIndexSync(_ index: Int) -> Post {
        return posts[index]
    }

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

    func deletePostSync(_ index: Int) {
        self.posts.remove(at: index)
        self.delegateUser?.updateUser(posts: posts)
        self.delegateNews?.updateNews(posts: posts)
    }
    func deletePostAsync(_ index: Int) {
        let operation = BlockOperation {
            self.posts.remove(at: index)
            self.delegateUser?.updateUser(posts: self.posts)
            self.delegateNews?.updateNews(posts: self.posts)
        }
        operation.completionBlock = {
            print("пост по индексу \(index) удален асинк")
        }
        deletePostQueue.addOperation(operation)
    }

    func likePostAsync(_ index: Int) {
        let operation = BlockOperation {
            if self.posts[index].isLike {
                self.posts[index].isLike = false
                self.posts[index].amountOfLikes -= 1
            } else {
                self.posts[index].isLike = true
                self.posts[index].amountOfLikes += 1
            }

            self.delegateUser?.updateLike(posts: self.posts)
            self.delegateNews?.updateNews(posts: self.posts)
        }
        operation.completionBlock = {
            print("у поста по индексу \(index) изменён лайк асинк")
        }
        likePostQueue.addOperation(operation)
    }
}
