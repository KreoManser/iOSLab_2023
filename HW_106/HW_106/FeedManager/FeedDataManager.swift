//
//  FeedDataManager.swift
//  HW_106
//
//  Created by Азат Зиганшин on 05.11.2023.
//

import Foundation
import UIKit

class FeedDataManager: FeedDataManagerProtocol {

    static let shared = FeedDataManager()

    private init() {
//        publications = [
//            Publication(userId: "1", photo: UIImage(named: "remy_wash"), text: "Я помылся"),
//            Publication(userId: "1", photo: UIImage(named: "remy_eat"), text: "Тут я ем"),
//            Publication(userId: "1", photo: UIImage(named: "remy_sleeping"), text: "Это я уже сплю"),
//            Publication(userId: "1", photo: UIImage(named: "remy_sleep"), text: "Хочу поспать"),
//            Publication(userId: "1", photo: UIImage(named: "remy_born"), text: "Это я только родился"),
//            Publication(userId: "1", photo: UIImage(named: "remy"), text: "Добро пожаловать на мой аккаунт")
//        ]
    }
    private var publications: [Publication] = []
    private let locker = NSLock()

    func syncSavePublication(_ publication: Publication) {
        locker.lock()
        publications.append(publication)
        locker.unlock()
    }

    func asyncSavePublication(_ publication: Publication) async {

        let queue = OperationQueue()

        return await withCheckedContinuation { continuation in
            queue.addOperation {
                self.syncSavePublication(publication)
                continuation.resume()
            }
        }
    }

    func syncGetAllPublications() -> [Publication] {
        locker.lock()
        let result = publications
        locker.unlock()
        return result
    }

    func asyncGetAllPublications() async -> [Publication] {

        let queue = OperationQueue()

        return await withCheckedContinuation { continuation in
            queue.addOperation {
                continuation.resume(returning: self.syncGetAllPublications())
            }
        }
    }

    func syncGetAllPublications(byUserId userId: String) -> [Publication] {

        locker.lock()
        let result = publications.filter { $0.userId == userId}
        locker.unlock()
        return result
    }

    func asyncGetAllPublications(byUserId userId: String) async -> [Publication] {

        let queue = OperationQueue()

        return await withCheckedContinuation { continuation in
            queue.addOperation {
                continuation.resume(returning: self.syncGetAllPublications(byUserId: userId))
            }
        }
    }

    func syncDeletePublication(withIndex index: Int) {
        locker.lock()
        publications.remove(at: index)
        locker.unlock()
    }

    func asyncDeletePublication(withIndex index: Int) async {

        let queue = OperationQueue()

        return await withCheckedContinuation { continuation in
            queue.addOperation {
                self.syncDeletePublication(withIndex: index)
                continuation.resume()
            }
        }
    }
}
