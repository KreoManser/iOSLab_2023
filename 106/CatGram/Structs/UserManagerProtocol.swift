//
//  File.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 03.11.2023.
//

import Foundation

protocol UserManaging {
    /// MARK: async methods to register user, login and retrieve user,
    func asyncRegisterUser(username: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func asyncLogin(username: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func asynRetrieveUser(username: String, completinon: @escaping (Result<User, Error>) -> Void)
}
