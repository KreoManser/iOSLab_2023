//
//  AuthorizationManager.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 05.11.2023.
//

import Foundation
import UIKit

protocol AuthorizationManagerProtocol {
    func asyncCheckAthorizationData(login: String, password: String, users: [User]) async -> (cheker: Bool, item: User?)
}
class AuthorizationManager: AuthorizationManagerProtocol {
    var currentUser: User!
    func asyncCheckAthorizationData(login: String,
                                    password: String,
                                    users: [User]) async -> (cheker: Bool, item: User?) {
        return await withCheckedContinuation {continuation in
            DispatchQueue.global().asyncAfter(deadline: .now()) {
                var cheker: Bool = false
                for item in 0...users.count-1 where users[item].userLogin == login
                && users[item].userPassword == password {
                    cheker = true
                    self.currentUser = users[item]
                    break
                }
                continuation.resume(returning: (cheker, self.currentUser))
            }
        }
    }
}
