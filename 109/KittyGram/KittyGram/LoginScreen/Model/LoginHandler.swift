//
//  LoginHandler.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 22.11.2023.
//

import Foundation

class LoginHandler: LoginHandlerProtocol {

    func userVerification(_ login: String, _ password: String) async -> User? {

        let users = await DataManager.shared.asyncGetUsers()

        return users.first(where: { $0.nickname == login && $0.password == password })
    }

}
