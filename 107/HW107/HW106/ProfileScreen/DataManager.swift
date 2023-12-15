import Foundation
import UIKit

protocol DataManagerProtocol {
    func syncSave(_ post: Post)
    func asyncSave(_ post: Post)

    func syncGetPosts() -> [Post]
    func asyncGetPosts() -> [Post]

    func syncFindByName(_ postDescription: String)
    func asyncFindByName(_ postDescription: String)

    func syncFindByID(_ postID: UUID) -> [Post]
    func asyncFindByID(_ postID: UUID) -> [Post]

    func syncDelete(_ postID: UUID)
    func asyncDelete(_ postID: UUID)

    func asyncGetPostsByUser(login: String) -> [Post]
    func syncGetPostsByUser(login: String) -> [Post]
}

class DataManager: DataManagerProtocol {
    var curUser: User?
    let userDefaults = UserDefaults.standard
    var currentUserKey: String {
        return "currentUser"
    }
    var loginBoolKey: String {
        return "LoggedIn"
    }
    private var allPosts: [Post] = []
    private var timerglotPosts: [Post] = [
//    Post(id: 1, postImageName: "Image_2",
//    postDescription: "My first post", postDate: "03.01.2023"),
//    Post(id: 2, postImageName: "Image_3",
//    postDescription: "My second post", postDate: "04.02.2023"),
//    Post(id: 3, postImageName: "Image_5",
//    postDescription: "My third post", postDate: "07.03.2023"),
//    Post(id: 4, postImageName: "Image_6",
//    postDescription: "My fourth post", postDate: "09.04.2023")
    ]

    private var gigaChadPosts: [Post] = [
//    Post(id: 1, postImageName: "Image_7",
//    postDescription: "My fith post", postDate: "11.05.2023"),
//    Post(id: 2, postImageName: "Image_8",
//    postDescription: "My sixth post", postDate: "15.07.2023"),
//    Post(id: 3, postImageName: "Image_9",
//    postDescription: "My seventh post", postDate: "17.08.2023")
    ]

    private var theBenkoPosts: [Post] = [
//    Post(id: 1, postImageName: "Image_7",
//    postDescription: "My fith post", postDate: "10.05.2023"),
//    Post(id: 2, postImageName: "Image_8",
//    postDescription: "My sixth post", postDate: "14.07.2023"),
//    Post(id: 3, postImageName: "Image_9",
//    postDescription: "My seventh post", postDate: "17.08.2023"),
//    Post(id: 4, postImageName: "Image_5",
//    postDescription: "My third post", postDate: "06.03.2023"),
//    Post(id: 5, postImageName: "Image_6",
//    postDescription: "My fourth post", postDate: "09.04.2023")
    ]
    private var postDict: [String: [Post]] = [:]
    lazy var posts: [Post] = CoreDataManager.shared.getAllPosts()
    private var allStories: [Story] = []
    private init() {
        for post in self.posts {
            guard let user = post.user else { return }
            if (user.id != CoreDataManager.shared.getCurUser()?.id) {
                self.allStories.append(Story(userName: user.login, imageName: post.postImageName))
            }
        }
    }
    private var searchedPosts: [Post] = []
    static let shared = DataManager()
    var isSearching: Bool = false

    func getSearchedPosts() -> [Post] {
        return searchedPosts
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
            print("New post was saved!")
        }

        operationQueue.addOperation(operation)
    }

    func syncGetPosts() -> [Post] {
        return posts
    }

    func asyncGetPosts() -> [Post] {
        var resultPosts: [Post] = []
        let operationQueue = OperationQueue()
        let operation = BlockOperation {
            resultPosts = self.posts
        }

        operation.completionBlock = {
            print("All posts have been received!")
        }

        operationQueue.addOperation(operation)
        return resultPosts
    }

    func syncFindByName(_ postDescription: String) {
        self.searchedPosts = posts.filter { $0.postDescription.contains(postDescription)}
    }

    func asyncFindByName(_ postDescription: String) {
        let operationQueue = OperationQueue()
        let operation = BlockOperation {
            self.searchedPosts = self.posts.filter { $0.postDescription.contains(postDescription)}
        }

        operation.completionBlock = {
            print("All posts with \(postDescription) description have been received!")
        }

        operationQueue.addOperation(operation)
    }

    func syncFindByID(_ postID: UUID) -> [Post] {
        return posts.filter { $0.id == postID }
    }

    func asyncFindByID(_ postID: UUID) -> [Post] {
        var resultPosts: [Post] = []
        let operationQueue = OperationQueue()
        let operation = BlockOperation { [self] in
            resultPosts = posts.filter { $0.id == postID }
        }

        operation.completionBlock = {
            print("Post by ID have been received!")
        }

        operationQueue.addOperation(operation)
        return resultPosts
    }

    func syncDelete(_ postID: UUID) {
        if let index = self.posts.firstIndex(where: { $0.id == postID }) {
            posts.remove(at: index)
        }
    }

    func asyncDelete(_ postID: UUID) {
        let operationQueue = OperationQueue()
        let operation = BlockOperation { [self] in
            if let index = self.posts.firstIndex(where: { $0.id == postID }) {
                posts.remove(at: index)
            }
        }

        operation.completionBlock = {
            print("Post by ID have been deleted!")
        }

        operationQueue.addOperation(operation)
    }

    func asyncGetPostsByUser(login: String) -> [Post] {
        var resultPosts: [Post] = []
        let operationQueue = OperationQueue()
        let operation = BlockOperation { [self] in
            resultPosts = postDict[login] ?? []
        }

        operation.completionBlock = {
            print("Post by login have been received!")
        }

        operationQueue.addOperation(operation)
        return resultPosts
    }

    func syncGetPostsByUser(login: String) -> [Post] {
        return postDict[login] ?? []
    }

    func getAllUsersPosts() -> [Post] {
        return allPosts
    }

    func getAllStories() -> [Story] {
        return allStories
    }
}

extension DataManager {
    func logOutUser() {
        curUser = nil
        LoginDataManager.curUser = ""
        userDefaults.removeObject(forKey: currentUserKey)
        userDefaults.setValue(false, forKey: loginBoolKey)
    }

    func saveUser(user: User) throws {
        userDefaults.setValue(user.id.uuidString, forKey: currentUserKey)
    }
}

enum UserError: Error {
    case userError
}
