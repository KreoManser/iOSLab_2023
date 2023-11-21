//
//  LoginHandlerProtocol.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 22.11.2023.
//

import Foundation

protocol LoginHandlerProtocol {
    func userVerification(_ login: String, _ password: String) async -> User?
}
