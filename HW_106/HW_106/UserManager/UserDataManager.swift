//
//  UserDataManager.swift
//  HW_106
//
//  Created by Азат Зиганшин on 05.11.2023.
//

import Foundation
import UIKit

class UserDataManager: UserDataManagerProtocol {

    static let shared = UserDataManager()

    private init() {
        users = [
            User(id: "1", login: "remy_fluffy",
            password: "remyfluffy123", avatarImage: UIImage(named: "remy"), numberOfSubscribers: 582, numberOfSubscriptions: 124,
                name: "Рэми", description: "У меня лапки"),
            User(id: "2", login: "sportsman_noir_252",
            password: "sportIsMyLife", avatarImage: UIImage(named: "noir"), numberOfSubscribers: 1044, numberOfSubscriptions: 23,
                name: "Нуар", description: "Я спортсмен"),
            User(id: "3", login: "in_love232with_paris",
            password: "travellingIsMyLife", avatarImage: UIImage(named: "travelcat"), numberOfSubscribers: 2098, numberOfSubscriptions: 144,
                name: "Айми", description: "Люблю путешествовать")
        ]
    }

    private var users: [User] = []
    private let locker = NSLock()

    func syncSaveUser(_ user: User) {
        locker.lock()
        users.append(user)
        locker.unlock()
    }

    func asyncSaveUser(_ user: User) async {

        let queue = OperationQueue()

        let operation = BlockOperation { [weak self] in
            self?.syncSaveUser(user)
        }

        return await withCheckedContinuation { continuation in
            queue.addOperation(operation)
            continuation.resume()
        }
    }

    func syncGetUser(byLogin login: String, byPassword password: String) -> User? {

        locker.lock()
        let result = users.first { $0.login == login && $0.password == password }
        locker.unlock()
        return result
    }

    func asyncGetUser(byLogin login: String, byPassword password: String) async -> User? {

        let queue = OperationQueue()

        return await withCheckedContinuation { continuation in
            queue.addOperation {
                let result = self.syncGetUser(byLogin: login, byPassword: password)
                continuation.resume(returning: result)
            }
        }
    }

    func syncGetAllUsers() -> [User] {

        locker.lock()
        let result = users
        locker.unlock()
        return result
    }

    func asyncGetAllUsers() async -> [User] {

        let queue = OperationQueue()

        return await withCheckedContinuation { continuation in
            queue.addOperation {
                continuation.resume(returning: self.syncGetAllUsers())
            }
        }
    }

    func syncGetUser(byId id: String) -> User? {
        locker.lock()
        let result = users.first { $0.id == id }
        locker.unlock()
        return result
    }

    func asyncGetUser(byId id: String) async -> User? {

        let queue = OperationQueue()

        return await withCheckedContinuation { continuation in
            queue.addOperation {
                continuation.resume(returning: self.syncGetUser(byId: id))
            }
        }
    }
}
