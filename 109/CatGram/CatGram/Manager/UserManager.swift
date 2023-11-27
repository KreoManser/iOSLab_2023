//
//  UserManager.swift
//  CatGram
//
//  Created by Mac on 2023-11-02.
//

import UIKit

protocol UserManagerProtocol {
    func addUserAsync(_ user: User)
    func autoriseUserAsync(_ nick: String, _ password: String) async -> Bool
    func getAllUsersAsync()
    func deleteUserAsync(nick: String, email: String?, passwordHash: String)
}

class UserManager: UserManagerProtocol {
    private let support = SupportFunctions()
    var users: [User] = []
    lazy var loginedUser: User? = nil
    static let userManager = UserManager()
    private let userDefaults = UserDefaults.standard
    private let userKey = "log_user"

    private init() {
        if loginedUser == nil && userDefaults.bool(forKey: "is_log_user") {
            loginedUser = getUset()
        }
        createDefaultUsers()
        PostsManager.postsManager.delegateUser = self
        NewsManager.newsManager.delegate = self
    }

    func addUserAsync(_ user: User) {
        Task {
            users.append(user)
            loginedUser = user
        }
    }
    func autoriseUserAsync(_ nick: String, _ password: String) async -> Bool {
        for user in users {
            if user.nick == nick || user.email == nick || user.number == nick {
                if user.passwordHash == support.hashPassword(password) {
                    loginedUser = user
                    saveUser(user: user)
                    return true
                } else {
                    print("password wrong")
                }
            } else {
                print("login wrong")
            }
        }
        return false
    }
    func getAllUsersAsync() {
    }
    func deleteUserAsync(nick: String, email: String?, passwordHash: String) {
    }
}

extension UserManager {
    private func createDefaultUsers() {
        let defaultUsers = self.support.createDefaultUsers()
        self.users = defaultUsers
    }
    private func saveUser(user: User) {
        let encoder = JSONEncoder()
        let userData = try? encoder.encode(user)
        userDefaults.setValue(userData, forKey: userKey)
    }
    private func getUset() -> User {
        guard let userData = userDefaults.data(forKey: userKey) else { return User() }

        do {
            let decoder = JSONDecoder()
            let user = try decoder.decode(User.self, from: userData)
            return user
        } catch {
            print("fail in decode \(error)")
        }
        return User()
    }
}

extension UserManager: UpdateUserProtocol {
    func updateLike(posts: [Post]) {
        self.loginedUser?.posts = posts
        saveUser(user: loginedUser ?? User())
    }
    func updateUser(posts: [Post]) {
        self.loginedUser?.amountOfPosts -= 1
        self.loginedUser?.posts = posts
        saveUser(user: loginedUser ?? User())
    }
}

