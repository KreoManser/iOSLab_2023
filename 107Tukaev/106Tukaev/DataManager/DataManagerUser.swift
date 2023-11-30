//
//  DataManagerUser.swift
//  107Tukaev
//
//  Created by surexnx on 02.11.2023.
//

import Foundation

class DataManagerUser: DataManagerProtocol {

    private var users: [User] = DataUsers().getUsers()

    static let shared = DataManagerUser()

    private init() {}

    func setUsers(users: [User]) {
        self.users = users
    }

    func syncSet(_ essence: User) {
        users.append(essence)
    }

    func asyncSet(_ essence: User) async {
        await withCheckedContinuation { contituation in
            DispatchQueue.global().async {
                self.users.append(essence)
                contituation.resume()
            }
        }
    }

    func syncGetAll() -> [User] {
        return users
    }

    func asyncGetAll() async -> [User] {
        await withCheckedContinuation { continuation in
            DispatchQueue.global().async {
                continuation.resume(returning: self.users)
            }
        }
    }

    func syncSearch(by id: Int) -> User? {
        return users.first(where: { $0.id == id }) ?? nil
    }

    func asyncSearch(by id: Int) async -> User? {
        await withCheckedContinuation { continuation in
            DispatchQueue.global().async {
                continuation.resume(returning: self.users.first(where: { $0.id == id }) ?? nil)
            }
        }
    }

    func syncDelete(id: Int) {
        guard let index = users.firstIndex(where: { $0.id == id }) else { return }
        users.remove(at: index)
    }

    func asyncDelete(id: Int) async {
        await withCheckedContinuation { continuation in
            DispatchQueue.global().async {
                guard let index = self.users.firstIndex(where: { $0.id == id }) else { return }
                self.users.remove(at: index)
                continuation.resume()
            }
        }
    }

    func auth(login: String, password: String) async -> User? {
        await withCheckedContinuation { continuation in
            DispatchQueue.global().async {
                continuation.resume(returning: self.users.first(where: { $0.userLogin == login && $0.userPassword == password }))
            }
        }
    }

    func authSync(login: String, password: String) -> User? {
        return self.users.first(where: { $0.userLogin == login && $0.userPassword == password })
    }
}
