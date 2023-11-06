import UIKit
class ProfileDataManager: NSObject, DataManagerProtocol, UICollectionViewDelegate,
                            UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var postTapped: ((_ indexPath: IndexPath) -> Void)?

    static let shared = ProfileDataManager()
    private var posts: [Post] = [
        Post(id: UUID(), image: UIImage(named: "photo-6"), description: "Я в понедельник", date: "11.10.2023"),
        Post(id: UUID(), image: UIImage(named: "photo-5"), description: "Милаш", date: "01.10.2023"),
        Post(id: UUID(), image: UIImage(named: "photo-4"), description: "биба", date: "09.09.2023"),
        Post(id: UUID(), image: UIImage(named: "photo-3"), description: "боба", date: "08.09.2023"),
        Post(id: UUID(), image: UIImage(named: "photo-2"), description: "Пирожочек", date: "03.04.2023"),
        Post(id: UUID(), image: UIImage(named: "photo-1"), description: "Cтепка", date: "22.03.2023")
    ]
    private let saveQueue = OperationQueue()
    private let deleteQueue = OperationQueue()
    private let searchQueue = OperationQueue()
    private let getAllPostsQueue = OperationQueue()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        syncGetAllPosts().count
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 3
        let height = width
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                            ProfileCollectionViewCell.reuseIdentifier,
                                for: indexPath) as? ProfileCollectionViewCell
                                            else { return UICollectionViewCell()}

        let posts = syncGetAllPosts()
        cell.configure(with: posts[indexPath.row])
        cell.contentMode = .scaleAspectFill
        cell.clipsToBounds = true

        return cell
    }

    func syncSave(_ model: Post) {
        posts.append(model)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        postTapped!(indexPath)
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

    func syncSearchPosts(by description: String) -> [Post] {
        let filteredPosts = posts.filter { $0.description.contains(description) }
        return filteredPosts
    }

    func asyncSearchPosts(by description: String, completion: @escaping (Result<[Post], Error>) -> Void) {
        let operation = BlockOperation { [self] in
            let filteredPosts = posts.filter { $0.description.contains(description) }
            OperationQueue.main.addOperation {
                completion(.success(filteredPosts))
            }
        }
        searchQueue.addOperation(operation)
    }
}
