//
//  AuthorizationDataManager.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 09.11.2023.
//

import Foundation
import UIKit

class AuthorizationDataManager: NSObject, AuthorizationDataManagerProtocol {

    static var authUser: String = ""

    private var users: [UserLogin] = [
        UserLogin(id: UUID(), login: "Славный_Котик", password: "111", avatar: UIImage(named: "kot3")),
        UserLogin(id: UUID(), login: "Bad_Cat", password: "222", avatar: UIImage(named: "badcat1")),
        UserLogin(id: UUID(), login: "Kitty", password: "333", avatar: UIImage(named: "k1"))
    ]

    func loginToAccount(userName: String, password: String, completion: @escaping ((UserLogin?) -> Void)) {
        Task {
            let user = await checkLoginAndPassword(userName: userName, password: password)
            AuthorizationDataManager.authUser = user?.login ?? ""
            completion(user)
        }
    }

    func checkLoginAndPassword(userName: String, password: String) async -> UserLogin? {
        if let user = users.first(where: {$0.login == userName && $0.password == password}) {
            return user
        } else {
            return nil
        }
    }
}
