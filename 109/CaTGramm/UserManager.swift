//
//  UserManager.swift
//  CaTGramm
//
//  Created by Rustem on 05.11.2023.
//

import Foundation
import CoreData

class UserManager: UserManagerProtocol {

    var viewContext = CoreDataManager.shared.viewContext

    lazy var firstUser: User = {
        var firstUser = User(context: viewContext)
        firstUser.userName = "123"
        firstUser.avatar = "myava"
        firstUser.password = "123"
        firstUser.profileDescription = "descrip"
        return firstUser
    }()

    lazy var users: [User] = {
        var users: [User] = []
        users.append(contentsOf: getAllUsers())
        users.append(firstUser)
        return users
    }()

    private func getAllUsers() -> [User] {
        var allUsers: [User] = []
        allUsers.append(contentsOf: CoreDataManager.shared.obtainSavedUsers())
        return allUsers
    }

    func updateUsers() {
        var allUsers: [User] = []
        allUsers.append(contentsOf: CoreDataManager.shared.obtainSavedUsers())
        for user in allUsers {
            if !users.contains(where: {$0.userName == user.userName}) {
                users.append(user)
            }
        }
    }

    func syncAuthUsers(userName: String, password: String) -> Bool {
        var flag = false
        if let i = self.users.firstIndex(where: { $0.userName == userName }) {
            if self.users[i].password == password {
                print("good pass!")
                flag = true
            }
        }
        return flag
    }

    func syncGetUserByName(username: String) -> User {
        if let i = self.users.firstIndex(where: { $0.userName == username }) {
            return users[i]
        }
        return users[0]
    }

    public static var shared = UserManager()
}
