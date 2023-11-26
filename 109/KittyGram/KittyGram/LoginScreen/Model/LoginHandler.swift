//
//  LoginHandler.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 22.11.2023.
//

import Foundation

class LoginHandler: LoginHandlerProtocol {

    private let dataManager = DataManager.shared

    func userVerification(_ login: String, _ password: String) async -> User? {
        let users = await dataManager.asyncGetUsers()
        if let currentUser = users.first(where: { $0.nickname == login && $0.password == password }) {
            do {
                try dataManager.saveUser(user: currentUser)
                dataManager.userDefaults?.setValue(true, forKey: dataManager.loginBoolKey)
                return currentUser
            } catch {
                print(error)
            }
        }
        return nil
    }
}
