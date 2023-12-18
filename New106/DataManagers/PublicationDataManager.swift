//
//  ProfileDataManager.swift
//  New106
//
//  Created by Alina on 01.11.2023.
//

import Foundation
 import UIKit

 class PublicationDataManager: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

     var postTapped: ((_ indexPath: IndexPath) -> Void)?

     static let shared = PublicationDataManager()
     private var posts: [Post] = [
        Post(id: UUID(), image: UIImage(named: "1"), caption: "Cute cat", date: "1 november"),
        Post(id: UUID(), image: UIImage(named: "2"), caption: "Funny cat", date: "1 november"),
        Post(id: UUID(), image: UIImage(named: "3"), caption: "Kind cat", date: "1 november"),
        Post(id: UUID(), image: UIImage(named: "4"), caption: "Beautiful cat", date: "1 november"),
        Post(id: UUID(), image: UIImage(named: "5"), caption: "Nice cat", date: "1 november"),
        Post(id: UUID(), image: UIImage(named: "6"), caption: "Smile cat", date: "1 november"),
        Post(id: UUID(), image: UIImage(named: "7"), caption: "Happy cat", date: "1 november"),
        Post(id: UUID(), image: UIImage(named: "8"), caption: "Cool cat", date: "1 november"),
        Post(id: UUID(), image: UIImage(named: "9"), caption: "Super cat", date: "1 november"),
     ]

     private override init() {}

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         syncGetAllPosts().count
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let width = collectionView.frame.width / 3
         let height = width
         return CGSize(width: width, height: height)
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 0
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return 0
     }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PublicationCollectionViewCell.reuseIdentifier, for: indexPath) as? PublicationCollectionViewCell else { return UICollectionViewCell()}

         let posts = syncGetAllPosts()
         cell.configure(with: posts[indexPath.row])
         cell.contentMode = .scaleAspectFill
         cell.clipsToBounds = true

         return cell
     }
     
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         postTapped!(indexPath)
     }
     
     private let saveQueue = OperationQueue()
     func syncSave(_ model: Post) {
         posts.append(model)
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

     private let deleteQueue = OperationQueue()
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
     
     private let getAllPostsQueue = OperationQueue()
     func syncGetAllPosts() -> [Post] {
         return posts
     }
     func asyncGetAllPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
         let operation = BlockOperation {
             completion(.success(self.posts))
         }

         getAllPostsQueue.addOperation(operation)
     }
     
     private let searchQueue = OperationQueue()
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
 }
