//
//  LoginUserDataManager.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 03.11.2023.
//

import Foundation

class UserDataManager: NSObject, UserManaging {
    static let shared = UserDataManager()

    var users: [User] = [User(username: "Doosuur14", password: "456",
    interest: "Fashion", friends: ["Lovelycats__", "User1"]),User(username: "Lovelycats__", password: "123",
    interest: "Animals", friends: ["Doosuur14"]),
    User(username: "User1", password: "1234",
    interest: "Nature", friends: ["Doosuur14", "Lovelycats__"])
    ]

    var didTapLoginButton: (() -> Void)?

    override init() {
        super.init()
        if !users.isEmpty {
            print(users)
        }
    }

    func asyncRegisterUser(username: String, password: String, interest: String, friends: [String],

                           completion: @escaping (Result<User, UserError>) -> Void) {
            Task {
                do {
                    try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
                    if users.contains(where: { $0.username == username}) {
                        completion(.failure(UserError.usernameTaken))
                    } else {
                        let newUser = User(username: username, password: password, interest: interest, friends: friends)
                        users.append(newUser)
                        completion(.success(newUser))
                    }
                } catch {
                    completion(.failure(UserError.registrationFailed))
                }
            }
    }

    func asyncLogin(username: String, password: String, completion: @escaping (Result<User, UserError>) -> Void) {
        Task {
            do {
                if let user = users.first(where: { $0.username == username && $0.password == password }) {
                    print("User found!")
                    completion(.success(user))
                } else {
                    print("User not found")
                    completion(.failure(UserError.loginFailed))
              }
            }
        }
    }
    func asynRetrieveUser(username: String, completinon: @escaping (Result<User, UserError>) -> Void) {
        Task {
            do {
                try await Task.sleep(nanoseconds: 1 * 1000_000_000)
                let user = users.first(where: { $0.username == username})
                completinon(.success(user!))
            } catch {
                completinon(.failure(UserError.userNotFound))
            }
        }
    }

    func authenticateUser(username: String, password: String) -> User? {
        for user in users {
            if user.username == username && user.password == password {
                return user
            }
        }
        return nil
    }
}
