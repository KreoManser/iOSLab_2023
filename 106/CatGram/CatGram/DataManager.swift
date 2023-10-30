import Foundation

class DataManager: DataManagerProtocol {

    private var posts: [Post] = []

    private let saveSemaphore = DispatchSemaphore(value: 1)
    private let getSemaphore = DispatchSemaphore(value: 1)
    private let deleteSemaphore = DispatchSemaphore(value: 1)
    private let searchSemaphore = DispatchSemaphore(value: 1)

    private let saveQueue = OperationQueue()
    private let getQueue = OperationQueue()
    private let deleteQueue = OperationQueue()
    private let searchQueue = OperationQueue()

    func syncSave(post: Post) {
        saveSemaphore.wait()
        posts.append(post)
        saveSemaphore.signal()
    }
    func asyncSave(post: Post, completion: @escaping (Bool) -> Void) {
        let saveOperation = BlockOperation {
            self.posts.append(post)
            completion(true)
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
            completion(gotPosts)
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
                self.posts.remove(at: index)
            }
            completion(true)
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
            let foundPost = self.posts.first(where: { $0.id == id })
            completion(foundPost)
        }
        searchQueue.addOperation(searchOperation)
    }
}
