//
//  LoginUserDataManager.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 03.11.2023.
//

import Foundation

class UserDataManager: NSObject, UserManaging {
    static let shared = UserDataManager()
    var feedDataManager: FeedDataManager?

    var users: [User] = [User(username: "Doosuur14", password: "456",
    interest: "Fashion", friends: ["Lovelycats__", "User1"]), User(username: "Lovelycats__", password: "123",
    interest: "Animals", friends: ["Doosuur14"]),
    User(username: "User1", password: "1234",
    interest: "Nature", friends: ["Doosuur14", "Lovelycats__"])
    ]
    let userdefaults = UserDefaults.standard
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
                if var user = users.first(where: { $0.username == username && $0.password == password }) {
                    print("User found!")
                    completion(.success(user))
                    user = loadUser()!
                    saveUser(user)
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
                saveUser(user)
                return user
            }
        }
        return nil
    }
 func saveUser(_ user: User) {
        do {
            let encoder = JSONEncoder()
            let usersData = try encoder.encode(user)
            userdefaults.setValue(usersData, forKey: Keys.loggedUser)
            userdefaults.set(true, forKey: Keys.isUserLoggedIn)
            print("usersaved")
           } catch {
            print("saving error")
        }
    }

    func loadUser() -> User? {
        guard let usersData = userdefaults.data(forKey: Keys.loggedUser) else {return nil}
        do {
            let decoder = JSONDecoder()
            let user = try decoder.decode(User.self, from: usersData)
            print("userloaded")
            return user
           } catch {
            print("loading error")
            return nil
        }
    }
}
