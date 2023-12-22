//
//  LoginModel.swift
//  catInstgram
//
//  Created by marwa awwad mohamed awwad on 22/12/2023.
//

import Foundation

protocol loginModelProtocol {
    func userVerification(_ login: String, _ password: String) async -> User?
}
