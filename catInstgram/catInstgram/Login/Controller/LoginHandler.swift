//
//  LoginHandler.swift
//  catInstgram
//
//  Created by marwa awwad mohamed awwad on 22/12/2023.
//

import Foundation
protocol LoginHandlerProtocol {
    func userVerification(_ login: String, _ password: String) async -> User?
}

class LoginHandler: LoginHandlerProtocol {

    func userVerification(_ login: String, _ password: String) async -> User? {

        let users = await DataManager.shared.asyncGetUsers()

        return users.first(where: { $0.username == login && $0.password == password })
    }

}
