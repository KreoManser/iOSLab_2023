//
//  Source.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 30.10.2023.
//

import Foundation
import UIKit

class ProfileDataManager: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, DataManagerProtocol {

    var didSelectPublication: ((_ indexPath: IndexPath) -> Void)?

    static let shared = ProfileDataManager()

    private override init() {}

    private var publications: [ProfilePublication] = [
        ProfilePublication(id: UUID(), image: UIImage(named: "kot"), caption: "hello world", date: "11.11.2011", isFavorite: false),
        ProfilePublication(id: UUID(), image: UIImage(named: "kot1"), caption: "как дела", date: "01.11.3311", isFavorite: false),
        ProfilePublication(id: UUID(), image: UIImage(named: "kot2"), caption: "все отлично", date: "11.32.2041", isFavorite: false),
        ProfilePublication(id: UUID(), image: UIImage(named: "kot3"), caption: "йоу", date: "77.11.2051", isFavorite: false),
        ProfilePublication(id: UUID(), image: UIImage(named: "kot4"), caption: "йюпийо", date: "11.66.2099", isFavorite: false)
    ]

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        publications.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier, for: indexPath)
            as? ProfileCollectionViewCell else { return UICollectionViewCell()}
        cell.config(with: publications[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectPublication!(indexPath)
    }

    private let saveQueue = OperationQueue()
    private let deleteQueue = OperationQueue()
    private let getAllPostsQueue = OperationQueue()

    func syncSave(_ model: ProfilePublication) {
        publications.append(model)
    }

    func asyncSave(_ model: ProfilePublication, completion: @escaping (Result<Void, Error>) -> Void) {
        let operation = BlockOperation {
            self.publications.append(model)
        }
        operation.completionBlock = {
            DispatchQueue.global().async {
                completion(.success(()))
            }
        }
        saveQueue.addOperation(operation)
    }

    func syncDelete(_ model: ProfilePublication) {
        if let index = publications.firstIndex(where: { $0.id == model.id }) {
            publications.remove(at: index)
        }
    }

    func asyncDelete(_ model: ProfilePublication, completion: @escaping (Result<Void, Error>) -> Void) {
        let operation = BlockOperation {
            if let index = self.publications.firstIndex(where: { $0.id == model.id }) {
                self.publications.remove(at: index)
            }
        }
        operation.completionBlock = {
            DispatchQueue.global().async {
                completion(.success(()))
            }
        }
        deleteQueue.addOperation(operation)
    }

    func syncGetAllPosts() -> [ProfilePublication] {
        return publications
    }
    func asyncGetAllPosts(completion: @escaping (Result<[ProfilePublication], Error>) -> Void) {
        let operation = BlockOperation {
            completion(.success(self.publications))
        }

        getAllPostsQueue.addOperation(operation)
    }
}

