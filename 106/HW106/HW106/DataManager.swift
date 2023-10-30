import Foundation
import UIKit

protocol DataManagerProtocol {
    func syncSave(_ post: Post)
    func asyncSave(_ post: Post)

    func syncGetPosts() -> [Post]
    func asyncGetPosts() -> [Post]

    func syncFindByName(_ postDescription: String) -> [Post]
    func asyncFindByName(_ postDescription: String) -> [Post]

    func syncFindByID(_ postID: Int) -> [Post]
    func asyncFindByID(_ postID: Int) -> [Post]

    func syncDelete(_ postID: Int)
    func asyncDelete(_ postID: Int)
}

class DataManager: DataManagerProtocol {
    private var posts: [Post] = [
         Post(id: 1, postImage: UIImage(named: "Image_2")!,
              postDescription: "My first post", postDate: "03.01.2023"),
         Post(id: 2, postImage: UIImage(named: "Image_3")!,
              postDescription: "My second post", postDate: "11.02.2023"),
         Post(id: 3, postImage: UIImage(named: "Image_5")!,
              postDescription: "My third post", postDate: "23.03.2023"),
         Post(id: 4, postImage: UIImage(named: "Image_6")!,
              postDescription: "My fourth post", postDate: "05.04.2023"),
         Post(id: 5, postImage: UIImage(named: "Image_7")!,
              postDescription: "My fith post", postDate: "06.05.2023"),
         Post(id: 6, postImage: UIImage(named: "Image_8")!,
              postDescription: "My sixth post", postDate: "12.07.2023"),
         Post(id: 7, postImage: UIImage(named: "Image_9")!,
              postDescription: "My seventh post", postDate: "17.08.2023")
    ]
    static let shared = DataManager()

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
            resultPosts =  self.posts
        }

        operation.completionBlock = {
            print("All posts have been received!")
        }

        operationQueue.addOperation(operation)
        return resultPosts
    }

    func syncFindByName(_ postDescription: String) -> [Post] {
        return posts.filter { $0.postDescription == postDescription }
    }

    func asyncFindByName(_ postDescription: String) -> [Post] {
        var resultPosts: [Post] = []
        let operationQueue = OperationQueue()
        let operation = BlockOperation {
            resultPosts =  self.posts.filter { $0.postDescription == postDescription }
        }

        operation.completionBlock = {
            print("All posts with \(postDescription) description have been received!")
        }

        operationQueue.addOperation(operation)
        return resultPosts
    }

    func syncFindByID(_ postID: Int) -> [Post] {
        return posts.filter { $0.id == postID }
    }

    func asyncFindByID(_ postID: Int) -> [Post] {
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

    func syncDelete(_ postID: Int) {
        if let index = self.posts.firstIndex(where: { $0.id == postID }) {
            posts.remove(at: index)
        }
    }

    func asyncDelete(_ postID: Int) {
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
}
