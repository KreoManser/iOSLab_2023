//
//  UserManagerProtocol.swift
//  CaTGramm
//
//  Created by Rustem on 05.11.2023.
//

import Foundation
protocol UserManagerProtocol {
    var users: [User] { get set }
    func asyncAuthUsers(userName: String, password: String) async -> Bool
}
