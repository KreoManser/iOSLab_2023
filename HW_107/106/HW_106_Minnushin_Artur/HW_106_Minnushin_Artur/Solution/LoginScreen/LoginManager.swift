//
//  AuthorizationManager.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 05.11.2023.
//

import Foundation
import UIKit

protocol LoginManagerProtocol {
    func asyncCheckAthorizationData(login: String,
                                    password: String)
    async -> (cheker: Bool, item: User)
}
class LoginManager: LoginManagerProtocol {
    var coreDataManager = CoreDataManager.shared
    func asyncCheckAthorizationData(login: String,
                                    password: String)
    async -> (cheker: Bool, item: User) {
        return await withCheckedContinuation {continuation in
            DispatchQueue.global().asyncAfter(deadline: .now()) {
                let users = self.coreDataManager.obtaineSavedData()
                var cheker: Bool = false
                for item in 0...users.count - 1 where users[item].userLogin == login
                && users[item].userPassword == password {
                    cheker = true
                    continuation.resume(returning: (cheker, users[item]))
                    break
                }
            }
        }
    }
}
