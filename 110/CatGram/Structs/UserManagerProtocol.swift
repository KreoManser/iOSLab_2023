//
//  File.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 03.11.2023.
//

import Foundation

protocol UserManaging {
    // MARK: async methods to register user, login and retrieve user,
    func asyncRegisterUser(username: String, password: String, interest: String, email: String,
                           completion: @escaping (Result<User, UserError>) -> Void)
    func asyncLogin(username: String, password: String, completion: @escaping (Result<User, UserError>) -> Void)
//    func asynRetrieveUser(username: String, completinon: @escaping (Result<User, UserError>) -> Void)
}

enum UserError: Error {
    case usernameTaken
    case loginFailed
    case userNotFound
    case registrationFailed
}
