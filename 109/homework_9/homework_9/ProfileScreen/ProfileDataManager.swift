import Foundation
import UIKit

class ProfileDataManager: NSObject, DataManagerProtocol, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var postTapped: ((_ indexPath: IndexPath) -> Void)?

    static let shared = ProfileDataManager()
    private var posts: [Post] = []
    private let userDefaults = UserDefaults.standard

    private var postsDictionary: [String: [Post]] = [:]

    private var pushinkaPosts: [Post] = [
        Post(id: UUID(), image: UIImage(named: "cat1Image"), caption: "Мой друг 1", date: "06.07.2006",
            isFavorite: false, author: ("Pushinka.52NGG", UIImage.logo)),
        Post(id: UUID(), image: UIImage(named: "cat2Image"), caption: "Мой друг 2", date: "07.08.2005",
            isFavorite: false, author: ("Pushinka.52NGG", UIImage.logo)),
        Post(id: UUID(), image: UIImage(named: "cat3Image"), caption: "Мой друг 3", date: "08.09.2004",
            isFavorite: false, author: ("Pushinka.52NGG", UIImage.logo)),
        Post(id: UUID(), image: UIImage(named: "cat4Image"), caption: "Мой друг 4", date: "09.10.2003",
            isFavorite: false, author: ("Pushinka.52NGG", UIImage.logo)),
        Post(id: UUID(), image: UIImage(named: "cat5Image"), caption: "Мой друг 5", date: "10.11.2002",
            isFavorite: false, author: ("Pushinka.52NGG", UIImage.logo)),
        Post(id: UUID(), image: UIImage(named: "cat6Image"), caption: "Мой друг 6", date: "11.12.2001",
            isFavorite: false, author: ("Pushinka.52NGG", UIImage.logo))
    ]

    private var adminPosts: [Post] = [
        Post(id: UUID(), image: UIImage.adminLogo, caption: "Мой админ 1", date: "01.01.2006",
            isFavorite: false, author: ("Admin", UIImage.adminLogo)),
        Post(id: UUID(), image: UIImage.adminLogo, caption: "Мой админ 2", date: "02.02.2005",
            isFavorite: false, author: ("Admin", UIImage.adminLogo)),
        Post(id: UUID(), image: UIImage.adminLogo, caption: "Мой админ 3", date: "03.03.2004",
            isFavorite: false, author: ("Admin", UIImage.adminLogo))
    ]

    private var dogLoverPosts: [Post] = [
        Post(id: UUID(), image: UIImage.dog1, caption: "Мой друг собака 1", date: "10.01.2006",
            isFavorite: false, author: ("dogLover", UIImage.dogLogo)),
        Post(id: UUID(), image: UIImage.dog2, caption: "Мой друг собака 2", date: "10.02.2005",
            isFavorite: false, author: ("dogLover", UIImage.dogLogo)),
        Post(id: UUID(), image: UIImage.dog3, caption: "Мой друг собака 3", date: "10.03.2004",
            isFavorite: false, author: ("dogLover", UIImage.dogLogo))
    ]

    private let saveQueue = OperationQueue()
    private let deleteQueue = OperationQueue()
    private let searchQueue = OperationQueue()
    private let getAllPostsQueue = OperationQueue()

    private override init() {
        super.init()
        if postsDictionary.isEmpty {
            postsDictionary["Pushinka.52NGG"] = pushinkaPosts
            postsDictionary["Admin"] = adminPosts
            postsDictionary["dogLover"] = dogLoverPosts
        }
        self.setAllPosts()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        syncGetAllPosts(forUser: getAuthUser()?.login ?? "").count
    }

    func getAuthUser() -> User? {
        do {
            guard let user = UserDefaults.standard.data(forKey: "loggedInUser") else { return nil}
            let decodedUser = try JSONDecoder().decode(User.self, from: user)
            return decodedUser
        } catch {
            print("obtain error \(error)")
        }
        return nil
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

        let posts = syncGetAllPosts(forUser: getAuthUser()?.login ?? "")
        cell.configure(with: posts[indexPath.row])
        cell.contentMode = .scaleAspectFill
        cell.clipsToBounds = true

        return cell
    }

    func syncSave(_ model: Post) {
        posts.append(model)
    }

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
    }

    func syncDelete(_ model: Post) {
        if let index = posts.firstIndex(where: { $0.id == model.id }) {
            posts.remove(at: index)
        }
    }

    func asyncDelete(_ model: Post, completion: @escaping (Result<Void, Error>) -> Void) {
        let operation = BlockOperation {
            if let index = self.posts.firstIndex(where: { $0.id == model.id }) {
                self.posts.remove(at: index)
            }
            if let index = self.postsDictionary[self.getAuthUser()?.login ?? ""]?.firstIndex(where: { $0.id == model.id }) {
                self.postsDictionary[self.getAuthUser()?.login ?? ""]?.remove(at: index)
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
    }

    func asyncGetAllPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        let operation = BlockOperation {
            completion(.success(self.posts))
        }

        getAllPostsQueue.addOperation(operation)
    }

    func syncGetAllPosts(forUser user: String) -> [Post] {
        return postsDictionary[user] ?? []
    }

    func asyncGetAllPosts(forUser user: String, completion: @escaping (Result<[Post], Error>) -> Void) {
        let operation = BlockOperation {
            completion(.success(self.postsDictionary[user] ?? []))
        }

        getAllPostsQueue.addOperation(operation)
    }

    func syncSearchPosts(by caption: String) -> [Post] {
        let filteredPosts = posts.filter { $0.caption.contains(caption) }
        return filteredPosts
    }

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
