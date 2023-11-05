//
//  LoginUserDataManager.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 03.11.2023.
//

import Foundation

class UserDataManager: NSObject, UserManaging {
    static let shared = UserDataManager()

    var users: [User] = [User(username: "Lovelycats__", password: "123", interest: "Animals"),
    User(username: "Doosuur14", password: "456", interest: "Fashion"),
    User(username: "User1", password: "1234", interest: "Nature")]

    var didTapLoginButton: (() -> Void)?

    override init() {
        super.init()
        if !users.isEmpty {
            print(users)
        }
    }

    func asyncRegisterUser(username: String, password: String, interest: String, completion: @escaping (Result<User, UserError>) -> Void) {
            Task {
                do {
                    try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
                    if users.contains(where: { $0.username == username}) {
                        completion(.failure(UserError.usernameTaken))
                    } else {
                        let newUser = User(username: username, password: password, interest: interest)
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
                // try await Task.sleep(nanoseconds: 1 * 1000_000_000)
                try await authenticateUser(username: username, password: password)
                if let user = users.first(where: { $0.username == username && $0.password == password }) {
                    print("User found!")
                    completion(.success(user))
                } else {
                    print("User not found")
                    completion(.failure(UserError.loginFailed))
              }
            } catch {
                completion(.failure(UserError.loginFailed))
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
