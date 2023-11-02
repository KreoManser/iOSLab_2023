//
//  DataManager.swift
//  CatGram
//
//  Created by Аделя Миннехузина on 01.11.2023.
//

import Foundation
import UIKit

class ProfileDataManager: NSObject, DataProtocol, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    static let shared = ProfileDataManager()

    private var posts: [Post] = [
        Post(id: UUID(), image: UIImage(named: "cat1"), caption: "first", date: "02.02.2022", isFavorite: false),
        Post(id: UUID(), image: UIImage(named: "cat2"), caption: "second", date: "03.03.2022", isFavorite: false),
        Post(id: UUID(), image: UIImage(named: "cat3"), caption: "third", date: "04.04.2022", isFavorite: false),
        Post(id: UUID(), image: UIImage(named: "cat4"), caption: "fourth", date: "05.05.2022", isFavorite: false),
        Post(id: UUID(), image: UIImage(named: "cat5"), caption: "fifth", date: "06.06.2022", isFavorite: false),
        Post(id: UUID(), image: UIImage(named: "cat6"), caption: "sixth", date: "07.07.2022", isFavorite: false)
    ]
    private let saveQueue = OperationQueue()
    private let deleteQueue = OperationQueue()
    private let getAllPostsQueue = OperationQueue()

    override init() {}

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        syncGetAllPosts().count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 3
        let height = width
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier, for: indexPath) as? ProfileCollectionViewCell else { return UICollectionViewCell()}

        let posts = syncGetAllPosts()
        cell.configure(with: posts[indexPath.row])
        cell.contentMode = .scaleAspectFill
        cell.clipsToBounds = true

        return cell
    }

    func syncSave(_ post: Post) {
        posts.append(post)
    }

    func asyncSave(_ post: Post, completion: @escaping (Result<Void, Error>) -> Void) {
        let operation = BlockOperation {
            self.posts.append(post)
        }
        operation.completionBlock = {
            DispatchQueue.global().async {
                completion(.success(()))
            }
        }
        saveQueue.addOperation(operation)
    }

    func syncDelete(_ post: Post) {
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            posts.remove(at: index)
        }
    }

    func asyncDelete(_ post: Post, completion: @escaping (Result<Void, Error>) -> Void) {
        let operation = BlockOperation {
            if let index = self.posts.firstIndex(where: { $0.id == post.id }) {
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
}

