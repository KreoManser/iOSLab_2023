//
//  UserDataManager.swift
//  HW_106
//
//  Created by Азат Зиганшин on 05.11.2023.
//

import Foundation
import UIKit

class UserDataManager: UserDataManagerProtocol {

    static let shares = UserDataManager()

    private init() {}

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
}
