//
//  DataManger.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 31.10.2023.
//

import Foundation

protocol DataManagerProtocol {
    func syncSave(post: PostInfo)
    func asyncSave(post: PostInfo)
    func syncGetAllPost() -> [PostInfo]
    func asyncGetAllPost() -> [PostInfo]
    func syncSearchByName(postName: String)
    func asyncSearchByName(postName: String)
    func syncSearchById(id: Int)
    func asyncSearchById(id: Int)
    func syncDelete(indexPath: Int)
    func asyncDelete(indexPath: Int)
}

class DataManager: DataManagerProtocol {
    var user: User?
    var posts: [PostInfo] = []
    var filteredPost: [PostInfo] = []
    let saveOpertionQueue = OperationQueue()
    let getOpertionQueue =  OperationQueue()
    let searchNameOpertionQueue = OperationQueue()
    let searchIdOpertionQueue = OperationQueue()
    let deleateOpertionQueue = OperationQueue()
    static let sigelton = DataManager()
    var isSearching = false
    func syncSave(post: PostInfo) {
        posts.append(post)
    }
    func setupUser(user: User) {
        self.user = user
        self.posts = user.posts
    }
    func asyncSave(post: PostInfo) {
        let saveOpertion = BlockOperation {
            self.posts.append(post)
        }
        saveOpertion.completionBlock = {
            print("Операция добавления была выполнена")
        }
        saveOpertionQueue.addOperation(saveOpertion)
    }
    func syncGetAllPost() -> [PostInfo] {
        return posts
    }
    func syncGetAllFilteredPost() -> [PostInfo] {
        return filteredPost
    }
    func asyncGetAllPost() -> [PostInfo] {
        var result: [PostInfo] = []
        let getPostOpertion = BlockOperation {
            result = self.posts
        }
        getPostOpertion.completionBlock = {
            print("Посты успешно переданы")
        }
        getOpertionQueue.addOperation(getPostOpertion)
        return result
    }
    func syncSearchByName(postName: String) {
        filteredPost = posts.filter {$0.postComment.lowercased().contains(postName.lowercased())}
    }
    func asyncSearchByName(postName: String) {
        let searchByNameOpertion = BlockOperation {
            self.filteredPost = self.posts.filter {$0.postComment.lowercased().contains(postName.lowercased())}
        }
        searchByNameOpertion.completionBlock = {
            print("Поиск по имени выполнен успешно")
        }
        searchNameOpertionQueue.addOperation(searchByNameOpertion)
    }
    func syncSearchById(id: Int) {
        filteredPost = posts.filter {$0.postID == id}
    }
    func asyncSearchById(id: Int) {
        let searchByIdOpertion = BlockOperation {
            self.filteredPost = self.posts.filter {$0.postID == id}
        }
        searchByIdOpertion.completionBlock = {
            print("Поиск по ID успешно выполнен")
        }
        searchIdOpertionQueue.addOperation(searchByIdOpertion)
    }
    func syncDelete(indexPath: Int) {
        posts.remove(at: indexPath)
    }
    func asyncDelete(indexPath: Int) {
        let deleateOperation = BlockOperation {
            self.posts.remove(at: indexPath)
        }
        deleateOperation.completionBlock = {
            print("Пост успешно удален")
        }
        deleateOpertionQueue.addOperation(deleateOperation)
    }
}
