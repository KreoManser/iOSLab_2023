//
//  ProfileDataManager.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 29.10.2023.
//

import Foundation
import UIKit

class ProfileDataManager: NSObject, DataManaging, UICollectionViewDataSource {
    static let shared = ProfileDataManager()

    var posts: [Post] = [
        Post(id: UUID(), caption: "Are you kitten me?",
             photo: UIImage(named: "whitecat.jpeg"),
             date: "20th May 2018", isFav: false),
        Post(id: UUID(), caption: "Putting the fur in furniture",
             photo: UIImage(named: "greycat.jpeg"),
             date: "14th Oct 2021", isFav: false),
        Post(id: UUID(), caption: "Black cats are not evil",
             photo: UIImage(named: "blackcat.jpeg"),
             date: "26th Dec 2023", isFav: false)
    ]

    /// custom queues for respective methods.
    private let saveQueue = OperationQueue()
    private let deleteQueue = OperationQueue()
    private let searchQueue = OperationQueue()
    private let retrievePostQueue = OperationQueue()

    /// closure to notify the viewcontroller that the image was tapped
    var didTapImage: ((_ indexPath: IndexPath) -> Void)?
    var reloadcollectionData: (() -> Void)?

    override init() {}

    func savePost(_ post: Post) {
        posts.append(post)
    }
    func retrievePost() -> [Post] {
        return posts
    }
    func searchPostByCaption(byCaption caption: String) -> [Post] {
        let filteredPosts = posts.filter { $0.caption.contains(caption)}
        return filteredPosts
    }
    func deletePost(_ post: Post) {
        if let index = posts.firstIndex(where: { $0.id == post.id}) {
            posts.remove(at: index)
        }
    }
    func asyncSavePost(_ post: Post, completion: @escaping (Bool) -> Void) {
        saveQueue.addOperation {
            self.posts.append(post)
            completion(true)
        }
    }
    func asyncSearchPostsByCaption(byCaption caption: String, completion: @escaping (Post?) -> Void) {
        searchQueue.addOperation {
            if let filteredPosts = self.posts.first( where: { $0.caption == caption }) {
                print("post found!")
                completion(filteredPosts)
            } else {
                print("post not found!")
                completion(nil)
            }
        }
    }

    func asyncDeletePost(_ post: Post, completion: @escaping (Bool) -> Void) {
        self.deleteQueue.addOperation {
            if let index = self.posts.firstIndex(where: { $0.id == post.id}) {
                self.posts.remove(at: index)
            }
            completion(true)
        }
    }
    func asyncRetrievePost(completion: @escaping ([Post]) -> Void) {
        self.retrievePostQueue.addOperation {
            print("posts retrieved!")
            completion(self.posts)
        }
    }
}

extension ProfileDataManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return retrievePost().count
    }
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: ProfileCollectionViewCell.reuseidentifier,
        for: indexPath) as? ProfileCollectionViewCell else {
            return UICollectionViewCell()}
        let posts = retrievePost()
        let post = posts[indexPath.row]
        cell.configure(with: post)
        cell.contentMode = .scaleAspectFill
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          didTapImage?(indexPath)
    }
}
extension ProfileDataManager: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 3
        let height = width
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView,

                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
