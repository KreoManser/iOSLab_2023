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

    var publicationsUser: [ProfilePublication] = []

    private var publicationsDictionary: [String: [ProfilePublication]] = [:]

    private override init() {
        super.init()
        if publicationsDictionary.isEmpty {
            publicationsDictionary["Славный_Котик"] = slavnyyPublications
            publicationsDictionary["Kitty"] = kittyPublications
            publicationsDictionary["Bad_Cat"] = badCatPublications
        }
        self.setAllPublications()
    }

    private var slavnyyPublications: [ProfilePublication] = [
        ProfilePublication(
            id: UUID(),
            image: UIImage(named: "kot"),
            caption: "hello world",
            date: "11.11.2011",
            isFavorite: false,
            userProfile: (userName: "Славный_Котик", avatar: UIImage(named: "kot3"))
        ),
        ProfilePublication(
            id: UUID(),
            image: UIImage(named: "kot1"),
            caption: "как дела", date: "01.11.3311",
            isFavorite: false, userProfile: (userName: "Славный_Котик", avatar: UIImage(named: "kot3"))
        ),
        ProfilePublication(
            id: UUID(),
            image: UIImage(named: "kot2"),
            caption: "все отлично", date: "11.32.2041",
            isFavorite: false,
            userProfile: (userName: "Славный_Котик", avatar: UIImage(named: "kot3"))
        ),
        ProfilePublication(
            id: UUID(),
            image: UIImage(named: "kot3"),
            caption: "йоу", date: "77.11.2051",
            isFavorite: false,
            userProfile: (userName: "Славный_Котик", avatar: UIImage(named: "kot3"))
        ),
        ProfilePublication(
            id: UUID(),
            image: UIImage(named: "kot4"),
            caption: "йюпийо", date: "11.66.2099",
            isFavorite: false,
            userProfile: (userName: "Славный_Котик", avatar: UIImage(named: "kot3"))
        )
    ]

    private var kittyPublications: [ProfilePublication] = [
        ProfilePublication(
            id: UUID(),
            image: UIImage(named: "k2"),
            caption: "текст 1",
            date: "11.11.2011",
            isFavorite: false,
            userProfile: (userName: "kitty", avatar: UIImage(named: "k1"))
        ),
        ProfilePublication(
            id: UUID(),
            image: UIImage(named: "k3"),
            caption: "текст 2",
            date: "01.11.3311",
            isFavorite: false,
            userProfile: (userName: "kitty", avatar: UIImage(named: "k1"))
        ),
        ProfilePublication(
            id: UUID(),
            image: UIImage(named: "k4"),
            caption: "текст 3",
            date: "11.32.43422",
            isFavorite: false,
            userProfile: (userName: "kitty", avatar: UIImage(named: "k1"))
        ),
        ProfilePublication(
            id: UUID(),
            image: UIImage(named: "k5"),
            caption: "текст 4",
            date: "77.11.2023",
            isFavorite: false,
            userProfile: (userName: "kitty", avatar: UIImage(named: "k1"))
        ),
        ProfilePublication(
            id: UUID(),
            image: UIImage(named: "k6"),
            caption: "текст 5",
            date: "11.66.1212",
            isFavorite: false,
            userProfile: (userName: "kitty", avatar: UIImage(named: "k1"))
        )
    ]
    private var badCatPublications: [ProfilePublication] = [
        ProfilePublication(
            id: UUID(),
            image: UIImage.badcat4,
            caption: "hello world 1",
            date: "11.11.2011",
            isFavorite: false,
            userProfile: (userName: "Bad_Cat", avatar: UIImage.badcat1)
        ),
        ProfilePublication(
            id: UUID(),
            image: UIImage.badcat2,
            caption: "hello world 2",
            date: "7 дней назад",
            isFavorite: false,
            userProfile: (userName: "Bad_Cat", avatar: UIImage.badcat1)
        ),
        ProfilePublication(
            id: UUID(),
            image: UIImage.badcat3,
            caption: "hello world 3",
            date: "1 час назад",
            isFavorite: false,
            userProfile: (userName: "Bad_Cat", avatar: UIImage.badcat1)
        ),
        ProfilePublication(
            id: UUID(),
            image: UIImage.badcat5,
            caption: "hello world 4",
            date: "3 часа назад",
            isFavorite: false,
            userProfile: (userName: "Bad_Cat", avatar: UIImage.badcat1)
        ),
        ProfilePublication(
            id: UUID(),
            image: UIImage.badcat6,
            caption: "hello world 5",
            date: "11.66.2099",
            isFavorite: false,
            userProfile: (userName: "Bad_Cat", avatar: UIImage.badcat1)
        )
    ]

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        syncGetAllPosts(forUser: AuthorizationDataManager.authUser).count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier, for: indexPath)
            as? ProfileCollectionViewCell else { return UICollectionViewCell()}
        cell.config(with: syncGetAllPosts(forUser: AuthorizationDataManager.authUser)[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectPublication!(indexPath)
    }

    private let saveQueue = OperationQueue()
    private let deleteQueue = OperationQueue()
    private let getAllPostsQueue = OperationQueue()

    func syncSave(_ model: ProfilePublication) {
        publicationsUser.append(model)
    }

    func asyncSave(_ model: ProfilePublication, completion: @escaping (Result<Void, Error>) -> Void) {
        let operation = BlockOperation {
            self.publicationsUser.append(model)
        }
        operation.completionBlock = {
            DispatchQueue.global().async {
                completion(.success(()))
            }
        }
        saveQueue.addOperation(operation)
    }

    func syncDelete(_ model: ProfilePublication) {
        if let index = publicationsUser.firstIndex(where: { $0.id == model.id }) {
            publicationsUser.remove(at: index)
        }
    }

    func asyncDelete(_ model: ProfilePublication, completion: @escaping (Result<Void, Error>) -> Void) {
        let operation = BlockOperation {
            if let index = self.publicationsUser.firstIndex(where: { $0.id == model.id }) {
                self.publicationsUser.remove(at: index)
            }
        }
        if let index = self.publicationsDictionary[AuthorizationDataManager.authUser]?.firstIndex(where: { $0.id == model.id }) {
            self.publicationsDictionary[AuthorizationDataManager.authUser]?.remove(at: index)
        }
        operation.completionBlock = {
            DispatchQueue.global().async {
                completion(.success(()))
            }
        }
        deleteQueue.addOperation(operation)
    }

    func syncGetAllPosts() -> [ProfilePublication] {
        return publicationsUser
    }

    func syncGetAllPosts(forUser user: String) -> [ProfilePublication] {
        return publicationsDictionary[user] ?? []
    }

    func asyncGetAllPosts(completion: @escaping (Result<[ProfilePublication], Error>) -> Void) {
        let operation = BlockOperation {
            completion(.success(self.publicationsUser))
        }

        getAllPostsQueue.addOperation(operation)
    }

    func asyncGetAllPosts(forUser user: String, completion: @escaping (Result<[ProfilePublication], Error>) -> Void) {
        let operation = BlockOperation {
            completion(.success(self.publicationsDictionary[user] ?? []))
        }

        getAllPostsQueue.addOperation(operation)
    }

    private func setAllPublications() {
        for publications in publicationsDictionary {
            for publication in publications.value {
                self.publicationsUser.append(publication)
            }
        }
    }
}

