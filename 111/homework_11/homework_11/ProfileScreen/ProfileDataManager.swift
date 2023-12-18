import Foundation
import UIKit

class ProfileDataManager: NSObject, DataManagerProtocol, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var postTapped: ((_ indexPath: IndexPath) -> Void)?

    static let shared = ProfileDataManager()
    private var posts: [Post] = []

    private let coreDataManager = CoreDataManager.shared

    private var postsDictionary: [String: [Post]] = [:]

    private var pushinkaPosts: [Post] = []

    private var adminPosts: [Post] = []

    private var dogLoverPosts: [Post] = []

    private let saveQueue = OperationQueue()
    private let deleteQueue = OperationQueue()
    private let searchQueue = OperationQueue()
    private let getAllPostsQueue = OperationQueue()

    private override init() {
        super.init()
        if postsDictionary.isEmpty {
            postsDictionary["Pushinka.52NGG"] = coreDataManager.obtainAllPosts().filter {$0.author?.login == "Pushinka.52NGG"}
            postsDictionary["Admin"] = coreDataManager.obtainAllPosts().filter {$0.author?.login == "Admin"}
            postsDictionary["dogLover"] = coreDataManager.obtainAllPosts().filter {$0.author?.login == "dogLover"}
        }
        self.setAllPosts()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        syncGetAllPosts(forUser: coreDataManager.getAuthUser()?.login ?? "").count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath)
        -> CGSize {
        let width = collectionView.frame.width / 3 - 3
        let height = width
        return CGSize(width: width, height: height)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int)
        -> CGFloat {
        return 3
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int)
        -> CGFloat {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                ProfileCollectionViewCell.reuseIdentifier, for: indexPath) as? ProfileCollectionViewCell
        else { return UICollectionViewCell()}

        let posts = syncGetAllPosts(forUser: coreDataManager.getAuthUser()?.login ?? "")
        cell.configure(with: posts[indexPath.row])
        cell.contentMode = .scaleAspectFill
        cell.clipsToBounds = true

        return cell
    }

    func syncSave(_ model: Post) {
        posts.append(model)
    } // not used

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        postTapped?(indexPath)
    }

    func asyncSave(_ model: Post, completion: @escaping (Result<Void, Error>) -> Void) {
        let operation = BlockOperation {
            self.posts.append(model)
        }
        operation.completionBlock = {
            DispatchQueue.global().async {
                completion(.success(()))
            }
        }
        saveQueue.addOperation(operation)
    } // not used

    func syncDelete(_ model: Post) {
        if let index = posts.firstIndex(where: { $0.id == model.id }) {
            posts.remove(at: index)
        }
    } // not used

    func asyncDelete(_ model: Post, completion: @escaping (Result<Void, Error>) -> Void) {
        let operation = BlockOperation {
            if let index = self.posts.firstIndex(where: { $0.id == model.id }) {
                self.posts.remove(at: index)
            }
            if let index = self.postsDictionary[self.coreDataManager.getAuthUser()?.login ?? ""]?.firstIndex(where: { $0.id == model.id }) {
                self.postsDictionary[self.coreDataManager.getAuthUser()?.login ?? ""]?.remove(at: index)
            }
        }

        operation.completionBlock = {
            DispatchQueue.global().async {
                completion(.success(()))
            }
        }
        deleteQueue.addOperation(operation)
    }

    func syncGetAllPosts() -> [Post] {
        return posts
    } // not used

    func asyncGetAllPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        let operation = BlockOperation {
            completion(.success(self.posts))
        }

        getAllPostsQueue.addOperation(operation)
    } // not used

    func syncGetAllPosts(forUser user: String) -> [Post] {
        return postsDictionary[user] ?? []
    }

    func asyncGetAllPosts(forUser user: String, completion: @escaping (Result<[Post], Error>) -> Void) {
        let operation = BlockOperation {
            completion(.success(self.postsDictionary[user] ?? []))
        }

        getAllPostsQueue.addOperation(operation)
    } // not used

    func syncSearchPosts(by caption: String) -> [Post] {
        let filteredPosts = posts.filter { $0.caption.contains(caption) }
        return filteredPosts
    } // not used

    func asyncSearchPosts(by caption: String, completion: @escaping (Result<[Post], Error>) -> Void) {
        let operation = BlockOperation { [self] in
            let filteredPosts = posts.filter { $0.caption.contains(caption) }
            OperationQueue.main.addOperation {
                completion(.success(filteredPosts))
            }
        }
        searchQueue.addOperation(operation)
    }

    private func setAllPosts() {
        for posts in postsDictionary {
            for post in posts.value {
                self.posts.append(post)
            }
        }
    }
}
