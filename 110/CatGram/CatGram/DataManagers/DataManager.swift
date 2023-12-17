import Foundation
import UIKit

protocol ProfilePostLikeDataManagerDelegate: AnyObject {
    func reloadArrayAfterLiking(_ dataManager: DataManager)
}
protocol FeedPostLikeDataManagerDelegate: AnyObject {
    func reloadArrayAfterLiking(_ dataManager: DataManager)
}

class DataManager: DataManagerProtocol {

    private let userDefaults = UserDefaults.standard
    private let usersKey = "saved_users"

    weak var profileDelegate: ProfilePostLikeDataManagerDelegate?
    weak var feedDelegate: FeedPostLikeDataManagerDelegate?
    lazy var coreDataManager = CoreDataManager.shared

    private var users = [User] ()
    private var posts = [Post] ()

    init() {
//        self.posts = []
//        self.users = []
//        self.initPosts()
//        self.users = coreDataManager.initUsers()
        self.users = coreDataManager.obtainSavedUsers()
//        coreDataManager.initPosts()
        self.posts = coreDataManager.getCurrentUserPosts()
//        print(posts)

//        self.initUsers()
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

//    func initPosts() {
//        if let image1 = UIImage(named: "miniCat") {
//            posts.append(Post(id: 1, image: image1, caption: "The mini Cat", date: Date(), countOfLikes: 5))
//        }
//        if let image2 = UIImage(named: "3in1Cats") {
//            posts.append(Post(id: 2, image: image2, caption: "With bro", date: Date(), countOfLikes: 11))
//        }
//        if let image3 = UIImage(named: "mrCat") {
//            posts.append(Post(id: 3, image: image3, caption: "Mr Cat", date: Date(), countOfLikes: 7))
//        }
//    }

    //    функции кэширования 
    func loginDefaults() {
        self.userDefaults.setValue(true, forKey: "logged_in")
    }
    func logOutDefaults() {
        self.userDefaults.setValue(false, forKey: "logged_in")
    }
//    сохраняем текущего пользователя (временно пока вошел в аккаунт)
    func saveUserByLogin(_ user: User) {
        let login = user.login
        userDefaults.setValue(login, forKey: usersKey)
    }
//    получение текущего пользователя
    func obtainUserByLogin() -> User? {
        guard let log = userDefaults.string(forKey: usersKey) else { return nil }
        return users.first(where: { $0.login == log })
    }

//    функция для лайка
//    func toLikePost(post: Post) {
//        userDefaults.setValue(true, forKey: String(post.id))
//        for index in posts.indices {
//            if posts[index] == post {
//                posts[index].countOfLikes += 1
//                print("count of posts in data manager\(posts)")
//                profileDelegate?.reloadArrayAfterLiking(self)
//                feedDelegate?.reloadArrayAfterLiking(self)
//            }
//        }
//    }
//    func toUnlikePost(post: Post) {
//        userDefaults.setValue(false, forKey: String(post.id))
//        for index in posts.indices {
//            if posts[index] == post {
//                posts[index].countOfLikes -= 1
//                profileDelegate?.reloadArrayAfterLiking(self)
//                feedDelegate?.reloadArrayAfterLiking(self)
//            }
//        }
//    }

    func addNewUser(user: User) {
        users.append(user)
//        coreDataManager.saveContext()
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

//    func syncSearchPostById(byId id: Int) -> Post? {
//        searchSemaphore.wait()
//        let foundPost = posts.first(where: { $0.id == id })
//        searchSemaphore.signal()
//        return foundPost
//    }
//    func asyncSearchPostById(byId id: Int) async -> Post? {
//        return await withCheckedContinuation { continuation in
//            let searchOperation = BlockOperation {
//                let foundPost = self.posts.first(where: { $0.id == id })
//                continuation.resume(returning: foundPost)
//            }
//            searchQueue.addOperation(searchOperation)
//        }
//    }
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
//extension DataManager: ReloadArraySignUpDelegate {
//    func reloadArrayAfterAddingNewUser(_ sugnUpVC: SignUpViewController, user: User) {
//        users.append(user)
//    }
//}
