import Foundation
import UIKit

class DataManager: DataManagerProtocol {

    private var posts: [Post]

    init() {
        self.posts = []
        self.initPosts()
    }

    private let saveSemaphore = DispatchSemaphore(value: 1)
    private let getSemaphore = DispatchSemaphore(value: 1)
    private let deleteSemaphore = DispatchSemaphore(value: 1)
    private let searchSemaphore = DispatchSemaphore(value: 1)

    private let saveQueue = OperationQueue()
    private let getQueue = OperationQueue()
    private let deleteQueue = OperationQueue()
    private let searchQueue = OperationQueue()

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

    func syncSave(post: Post) {
        saveSemaphore.wait()
        posts.append(post)
        saveSemaphore.signal()
    }
    func asyncSave(post: Post, completion: @escaping (Bool) -> Void) {
        let saveOperation = BlockOperation {
            DispatchQueue.main.async {
                self.posts.append(post)
                completion(true)
            }
        }
        saveQueue.addOperation(saveOperation)
    }

    func syncGetPosts() -> [Post] {
        getSemaphore.wait()
        let currentPosts = posts
        getSemaphore.signal()
        return currentPosts
    }
    func asyncGetPosts(completion: @escaping ([Post]) -> Void) {
        let getPostsOperation = BlockOperation {
            let gotPosts = self.posts
            DispatchQueue.main.async {
                completion(gotPosts)
            }
        }
        getQueue.addOperation(getPostsOperation)
    }

    func syncDelete(post: Post) {
        deleteSemaphore.wait()
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            posts.remove(at: index)
        }
        deleteSemaphore.signal()
    }
    func asyncDelete(post: Post, completion: @escaping (Bool) -> Void) {
        let deleteOperation = BlockOperation {
            if let index = self.posts.firstIndex(where: { $0.id == post.id }) {
                DispatchQueue.main.async {
                    self.posts.remove(at: index)
                    completion(true)
                }
            } else {
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
        deleteQueue.addOperation(deleteOperation)
    }

    func syncSearchPostById(byId id: Int) -> Post? {
        searchSemaphore.wait()
        let foundPost = posts.first(where: { $0.id == id })
        searchSemaphore.signal()
        return foundPost
    }
    func asyncSearchPostById(byId id: Int, completion: @escaping (Post?) -> Void) {
        let searchOperation = BlockOperation {
            var foundPost: Post?
            DispatchQueue.main.sync {
                foundPost = self.posts.first(where: { $0.id == id })
                completion(foundPost)
            }
        }
        searchQueue.addOperation(searchOperation)
    }
}
