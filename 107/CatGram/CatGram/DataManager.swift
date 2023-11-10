import Foundation
import UIKit

class DataManager: DataManagerProtocol {

    private var users: [User]
    private var posts: [Post]

    init() {
        self.posts = []
        self.users = []
        self.initPosts()
        self.initUsers()
    }

    private let saveSemaphore = DispatchSemaphore(value: 1)
    private let getPostsSemaphore = DispatchSemaphore(value: 1)
    private let deleteSemaphore = DispatchSemaphore(value: 1)
    private let searchSemaphore = DispatchSemaphore(value: 1)
    private let getUsersSemaphore = DispatchSemaphore(value: 1)

    private let saveQueue = OperationQueue()
    private let getQueue = OperationQueue()
    private let deleteQueue = OperationQueue()
    private let searchQueue = OperationQueue()
    private let getUsersQueue = OperationQueue()

    func initPosts() {
        if let image1 = UIImage(named: "miniCat") {
            posts.append(Post(id: 1, image: image1, caption: "The mini Cat", date: Date(), countOfLikes: 5))
        }
        if let image2 = UIImage(named: "3in1Cats") {
            posts.append(Post(id: 2, image: image2, caption: "With bro", date: Date(), countOfLikes: 11))
        }
        if let image3 = UIImage(named: "mrCat") {
            posts.append(Post(id: 3, image: image3, caption: "Mr Cat", date: Date(), countOfLikes: 7))
        }
    }
    func initUsers() {
        if let image1 = UIImage(named: "msCat") {
            users.append(User(username: "misskitty", description: "whiskas is top", profileImage: image1, login: "misskitty", password: "1111"))
        }
        if let image2 = UIImage(named: "kingCat") {
            users.append(User(username: "kingcat", description: "where is my throne", profileImage: image2, login: "kingcat", password: "1234"))
        }
        if let image3 = UIImage(named: "funnyCat") {
            users.append(User(username: "funnyCat", description: "the best thing is bed", profileImage: image3, login: "funnycat", password: "1212"))
        }
    }

    func syncGetUsers() -> [User] {
        getUsersSemaphore.wait()
        let currentUsers = users
        getUsersSemaphore.signal()
        return currentUsers
    }
    func asyncGetUsers() async -> [User] {
        return await withCheckedContinuation { continuation in
            let getUsersOperation = BlockOperation {
                let gotUsers = self.users
                continuation.resume(returning: gotUsers)
            }
            getUsersQueue.addOperation(getUsersOperation)
        }
    }

    func getUsers() -> [User] {
        return users
    }

    func syncSave(post: Post) {
        saveSemaphore.wait()
        posts.append(post)
        saveSemaphore.signal()
    }
    func asyncSave(post: Post) async -> Bool {
        return await withCheckedContinuation { continuation in
            let saveOperation = BlockOperation {
                self.posts.append(post)
                continuation.resume(returning: true)
            }
            saveQueue.addOperation(saveOperation)
        }
    }
//    func asyncSave(post: Post, completion: @escaping (Bool) -> Void) {
//        let saveOperation = BlockOperation {
//            DispatchQueue.main.async {
//                self.posts.append(post)
//                completion(true)
//            }
//        }
//        saveQueue.addOperation(saveOperation)
//    }

    func syncGetPosts() -> [Post] {
        getPostsSemaphore.wait()
        let currentPosts = posts
        getPostsSemaphore.signal()
        return currentPosts
    }
    func asyncGetPosts() async -> [Post] {
        return await withCheckedContinuation { continuation in
            let getPostsOperation = BlockOperation {
                let gotPosts = self.posts
                continuation.resume(returning: gotPosts)
            }
            getQueue.addOperation(getPostsOperation)
        }
    }
//    func asyncGetPosts(completion: @escaping ([Post]) -> Void) {
//        let getPostsOperation = BlockOperation {
//            let gotPosts = self.posts
//            DispatchQueue.main.async {
//                completion(gotPosts)
//            }
//        }
//        getQueue.addOperation(getPostsOperation)
//    }

    func syncDelete(post: Post) {
        deleteSemaphore.wait()
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            posts.remove(at: index)
        }
        deleteSemaphore.signal()
    }
    func asyncDelete(post: Post) async -> Bool {
        return await withCheckedContinuation { continuation in
            let deleteOperation = BlockOperation {
                if let index = self.posts.firstIndex(where: { $0.id == post.id }) {
                    self.posts.remove(at: index)
                    continuation.resume(returning: true)
                } else {
                    continuation.resume(returning: false)
                }
            }
            deleteQueue.addOperation(deleteOperation)
        }
    }
//    func asyncDelete(post: Post, completion: @escaping (Bool) -> Void) {
////        print("!!!!!!!!!!!!!!!!!posts in DM before deleting:\(posts)")
//        let deleteOperation = BlockOperation {
//            if let index = self.posts.firstIndex(where: { $0.id == post.id }) {
//                DispatchQueue.main.async {
//                    self.posts.remove(at: index)
//                    completion(true)
//                }
//            }
//            else {
//                DispatchQueue.main.async {
//                    completion(false)
//                }
//            }
//        }
//        deleteQueue.addOperation(deleteOperation)
//    }

    func syncSearchPostById(byId id: Int) -> Post? {
        searchSemaphore.wait()
        let foundPost = posts.first(where: { $0.id == id })
        searchSemaphore.signal()
        return foundPost
    }
    func asyncSearchPostById(byId id: Int) async -> Post? {
        return await withCheckedContinuation { continuation in
            let searchOperation = BlockOperation {
                let foundPost = self.posts.first(where: { $0.id == id })
                continuation.resume(returning: foundPost)
            }
            searchQueue.addOperation(searchOperation)
        }
    }
    //    func asyncSearchPostById(byId id: Int, completion: @escaping (Post?) -> Void) {
    //        let searchOperation = BlockOperation {
    //            var foundPost: Post?
    //            DispatchQueue.main.async {
    //                foundPost = self.posts.first(where: { $0.id == id })
    //                completion(foundPost)
    //            }
    //        }
    //        searchQueue.addOperation(searchOperation)
    //    }
}
