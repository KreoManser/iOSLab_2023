//
//  UserManager.swift
//  CaTGramm
//
//  Created by Rustem on 05.11.2023.
//

import Foundation

class UserManager: UserManagerProtocol {

    private static var firstUser = User(userName: "ТоповыйКотэ", avatar: "myava", password: "Topcot", profileDescription: "я самый топовый кот города Казань")
    static var secondUser = User(userName: "InglishKot", avatar: "myava", password: "Engcot", profileDescription: "i am inglish cot london is capital of gret britan")
    static var thirdUser = User(userName: "UsualCat", avatar: "myava", password: "Usualcot", profileDescription: "just usual cat with no friends")

    var users = [firstUser, secondUser, thirdUser]

    func asyncAuthUsers(userName: String, password: String) async -> Bool {
        var flag = false
        let checkOperation = BlockOperation {
            print("async login started")
        }
        return await withCheckedContinuation { continuation in
            checkOperation.completionBlock = { [weak self] in
                if let i = self?.users.firstIndex(where: { $0.userName == userName }) {
                    if self?.users[i].password == password {
                        print("good pass!")
                        flag = true
                    }
                }
                continuation.resume(returning: flag)
            }

            OperationQueue().addOperation(checkOperation)
        }
    }

    func syncGetUserByName(username: String) -> User {
        if let i = self.users.firstIndex(where: { $0.userName == username }) {
            return users[i]
        }
        return users[0]
    }

    public static var shared = UserManager()
}
