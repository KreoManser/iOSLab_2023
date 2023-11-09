//
//  Manager.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 30.10.2023.
//

import Foundation
import UIKit

class PublicationDataManager: PublicationProtocol {
    var isCallObserver: Bool = true

    static let shared = PublicationDataManager()
    static var publicationsCurrentUser: [Publication]? {
        willSet {
            PublicationDataManager.shared.isCallObserver = false
        }
        didSet {
            RegistrationDataManager.user?.publications = publicationsCurrentUser ?? []
            RegistrationDataManager.shared.delegate?.updateData()
            RegistrationDataManager.shared.delegate1?.updateData()
            RegistrationDataManager.shared.delegate2?.updateData()

        }
    }
    var dictionaryUserAndPublication: [String: [Publication]] = [:]
    weak var delegate: UpdateDataDelegate?
    private let saveQueue = OperationQueue()
    private let getQueue = OperationQueue()
    private let searchQueue = OperationQueue()
    private let deleteQueue = OperationQueue()

    var publications1 = [
        Publication(id: UUID(), imageAvatar: UIImage(named: "photo1"),
            label: "Cat1", description: "Это я)", date: "4 июня",
            image: UIImage(named: "photo1")),
        Publication(id: UUID(), imageAvatar: UIImage(named: "photo1"),
            label: "Cat1", description: "Заработал денег)", date: "30 июня",
            image: UIImage(named: "photo1_2"))
    ]

    var publications2 = [
        Publication(id: UUID(), imageAvatar: UIImage(named: "photo2"),
            label: "Cat2", description: "Это я)", date: "21 августа",
            image: UIImage(named: "photo2")),
        Publication(id: UUID(), imageAvatar: UIImage(named: "photo2"),
            label: "Cat2", description: "Я плохой кот", date: "21 августа",
            image: UIImage(named: "photo2_2"))
    ]

    var publications3 = [
        Publication(id: UUID(), imageAvatar: UIImage(named: "photo3"),
            label: "Cat3", description: "Это я)", date: "20 июля",
            image: UIImage(named: "photo3")),
        Publication(id: UUID(), imageAvatar: UIImage(named: "photo3"),
            label: "Cat3", description: "Рад всех видеть на своем канале", date: "20 июля",
            image: UIImage(named: "photo3_2")),
        Publication(id: UUID(), imageAvatar: UIImage(named: "photo3"),
            label: "Cat3", description: "Типичные будни програмиста)))",
            date: "20 июля", image: UIImage(named: "photo3_3"))
    ]
    private init () {

        dictionaryUserAndPublication["Cat1"] = publications1
        dictionaryUserAndPublication["Cat2"] = publications2
        dictionaryUserAndPublication["Cat3"] = publications3
    }
    func asyncGetEverythingPublication() async -> [Publication] {
        guard let currentUser = await RegistrationDataManager.shared.getCurrentUser() else { return [] }
        var allPublications: [Publication] = []
        for user in currentUser.subscriptions {
            let publicationsUser = await asyncPublicationCurrentUser(user: user)
            allPublications += publicationsUser
        }
        allPublications += currentUser.publications
        return allPublications
    }
    func asyncPublicationCurrentUser(user: User) async -> [Publication] {
        if let publications = self.dictionaryUserAndPublication.first(where: {$0.key == user.login})?.value {
            if isCallObserver {
                PublicationDataManager.publicationsCurrentUser = publications
            }
            return publications
        } else {
            return []
        }
    }

    func asyncDelete(_ publication: Publication) {
        deleteQueue.addOperation {
            DispatchQueue.main.async {
                if let publicationId = PublicationDataManager
                    .publicationsCurrentUser?
                    .firstIndex(where: {$0.id == publication.id}) {
                    PublicationDataManager.publicationsCurrentUser?
                        .remove(at: publicationId)
                }
            }
        }
    }

    func asyncFind(withCriteria id: String, completion: @escaping (Publication?) -> Void) {
        //
    }
    func asyncSave(_ publication: Publication, completion: @escaping (Bool) -> Void) {
        //
    }
}
