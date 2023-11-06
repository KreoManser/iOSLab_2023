//
//  AuthorizationManager.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 05.11.2023.
//

import Foundation
import UIKit

protocol AuthorizationManagerProtocol {
    func asyncCheckAthorizationData(login: String, password: String, users: [User]) async -> Bool
    func asyncGetCurrentUser() async -> User?

}
class AuthorizationManager: AuthorizationManagerProtocol {
    let dataBase: [User] = UserDataBase().getData()
    var currentUser: User?
    func asyncCheckAthorizationData(login: String, password: String, users: [User]) async -> Bool {
        return await withCheckedContinuation {continuation in
            DispatchQueue.global().asyncAfter(deadline: .now()) {
                var cheker: Bool = false
                for item in 0...users.count-1 where users[item].userLogin == login
                && users[item].userPassword == password {
                    cheker = true
                    self.currentUser = users[item]
                    break
                }
                continuation.resume(returning: cheker)
            }
        }
    }
    func asyncGetCurrentUser() async -> User? {
        return await withCheckedContinuation { continuation in
            continuation.resume(returning: self.currentUser)
        }
    }
}
