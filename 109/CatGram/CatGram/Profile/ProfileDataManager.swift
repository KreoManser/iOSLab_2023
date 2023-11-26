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
    var publicationsUsers: [ProfilePublication] = []
    private var publicationsDictionary: [String: [ProfilePublication]] = [:]

    private let usesrsDefualt = UserDefaults(suiteName: "PublicationsProfile")
    private let publicationsKey = "publicationsKey"

    private override init() {
        super.init()
        if publicationsDictionary.isEmpty {
            publicationsDictionary["Славный_Котик"] = slavnyyPublications
            publicationsDictionary["Kitty"] = kittyPublications
            publicationsDictionary["Bad_Cat"] = badCatPublications
        }
        self.setAllPublications()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        syncGetAllPosts(forUser: UserDefaults.standard.object(forKey: "user") as? String ?? "").count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier, for: indexPath)
            as? ProfileCollectionViewCell else { return UICollectionViewCell() }
        cell.config(with: syncGetAllPosts(forUser: UserDefaults.standard.object(forKey: "user") as? String ?? "")[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectPublication!(indexPath)
    }

    private let saveQueue = OperationQueue()
    private let deleteQueue = OperationQueue()
    private let getAllPostsQueue = OperationQueue()

    func syncSave(_ model: ProfilePublication) {
        publicationsUsers.append(model)
    }

    func asyncSave(_ model: ProfilePublication, completion: @escaping (Result<Void, Error>) -> Void) {
        let operation = BlockOperation {
            self.publicationsUsers.append(model)
        }
        operation.completionBlock = {
            DispatchQueue.global().async {
                completion(.success(()))
            }
        }
        saveQueue.addOperation(operation)
    }

    func syncDelete(_ model: ProfilePublication) {
        if let index = publicationsUsers.firstIndex(where: { $0.id == model.id }) {
            publicationsUsers.remove(at: index)
        }
    }

    func asyncDelete(_ model: ProfilePublication, completion: @escaping (Result<Void, Error>) -> Void) {
        let operation = BlockOperation {
            if let index = self.publicationsUsers.firstIndex(where: { $0.id == model.id }) {
                self.publicationsUsers.remove(at: index)
            }
        }
        if let index = self.publicationsDictionary[
            UserDefaults.standard.object(forKey: "user") as? String ?? ""
        ]?.firstIndex(where: { $0.id == model.id }) {
            self.publicationsDictionary[
                UserDefaults.standard.object(forKey: "user") as? String ?? ""
            ]?.remove(at: index)
        }
        operation.completionBlock = {
            DispatchQueue.global().async {
                completion(.success(()))
            }
        }
        deleteQueue.addOperation(operation)
    }

    func syncGetAllPosts() -> [ProfilePublication] {
        return publicationsUsers
    }

    func syncGetAllPosts(forUser user: String) -> [ProfilePublication] {
        return publicationsDictionary[user] ?? []
    }

    func asyncGetAllPosts(completion: @escaping (Result<[ProfilePublication], Error>) -> Void) {
        let operation = BlockOperation {
            completion(.success(self.publicationsUsers))
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
                self.publicationsUsers.append(publication)
            }
        }
    }

    private var slavnyyPublications: [ProfilePublication] = [
        ProfilePublication(
            id: UUID(),
            image: UIImage(named: "kot"),
            caption: "hello world",
            date: "11.11.2011",
            isLiked: false,
            userProfile: (userName: "Славный_Котик", avatar: UIImage(named: "kot3"))
        ),
        ProfilePublication(
            id: UUID(),
            image: UIImage(named: "kot1"),
            caption: "как дела", date: "01.11.3311",
            isLiked: false, userProfile: (userName: "Славный_Котик", avatar: UIImage(named: "kot3"))
        ),
        ProfilePublication(
            id: UUID(),
            image: UIImage(named: "kot2"),
            caption: "все отлично", date: "11.32.2041",
            isLiked: false,
            userProfile: (userName: "Славный_Котик", avatar: UIImage(named: "kot3"))
        ),
        ProfilePublication(
            id: UUID(),
            image: UIImage(named: "kot3"),
            caption: "йоу", date: "77.11.2051",
            isLiked: false,
            userProfile: (userName: "Славный_Котик", avatar: UIImage(named: "kot3"))
        ),
        ProfilePublication(
            id: UUID(),
            image: UIImage(named: "kot4"),
            caption: "йюпийо", date: "11.66.2099",
            isLiked: false,
            userProfile: (userName: "Славный_Котик", avatar: UIImage(named: "kot3"))
        )
    ]

    private var kittyPublications: [ProfilePublication] = [
        ProfilePublication(
            id: UUID(),
            image: UIImage(named: "k2"),
            caption: "текст 1",
            date: "11.11.2011",
            isLiked: false,
            userProfile: (userName: "kitty", avatar: UIImage(named: "k1"))
        ),
        ProfilePublication(
            id: UUID(),
            image: UIImage(named: "k3"),
            caption: "текст 2",
            date: "01.11.3311",
            isLiked: false,
            userProfile: (userName: "kitty", avatar: UIImage(named: "k1"))
        ),
        ProfilePublication(
            id: UUID(),
            image: UIImage(named: "k4"),
            caption: "текст 3",
            date: "11.32.43422",
            isLiked: false,
            userProfile: (userName: "kitty", avatar: UIImage(named: "k1"))
        ),
        ProfilePublication(
            id: UUID(),
            image: UIImage(named: "k5"),
            caption: "текст 4",
            date: "77.11.2023",
            isLiked: false,
            userProfile: (userName: "kitty", avatar: UIImage(named: "k1"))
        ),
        ProfilePublication(
            id: UUID(),
            image: UIImage(named: "k6"),
            caption: "текст 5",
            date: "11.66.1212",
            isLiked: false,
            userProfile: (userName: "kitty", avatar: UIImage(named: "k1"))
        )
    ]
    private var badCatPublications: [ProfilePublication] = [
        ProfilePublication(
            id: UUID(),
            image: UIImage.badcat4,
            caption: "hello world 1",
            date: "11.11.2011",
            isLiked: false,
            userProfile: (userName: "Bad_Cat", avatar: UIImage.badcat1)
        ),
        ProfilePublication(
            id: UUID(),
            image: UIImage.badcat2,
            caption: "hello world 2",
            date: "7 дней назад",
            isLiked: false,
            userProfile: (userName: "Bad_Cat", avatar: UIImage.badcat1)
        ),
        ProfilePublication(
            id: UUID(),
            image: UIImage.badcat3,
            caption: "hello world 3",
            date: "1 час назад",
            isLiked: false,
            userProfile: (userName: "Bad_Cat", avatar: UIImage.badcat1)
        ),
        ProfilePublication(
            id: UUID(),
            image: UIImage.badcat5,
            caption: "hello world 4",
            date: "3 часа назад",
            isLiked: false,
            userProfile: (userName: "Bad_Cat", avatar: UIImage.badcat1)
        ),
        ProfilePublication(
            id: UUID(),
            image: UIImage.badcat6,
            caption: "hello world 5",
            date: "11.66.2099",
            isLiked: false,
            userProfile: (userName: "Bad_Cat", avatar: UIImage.badcat1)
        )
    ]
}

