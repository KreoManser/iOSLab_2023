//
//  UserDataManagerProtocol.swift
//  HW_106
//
//  Created by Азат Зиганшин on 05.11.2023.
//

import Foundation
import UIKit

protocol UserDataManagerProtocol {

    func syncSaveUser(_ user: User)
    func asyncSaveUser(_ user: User) async

    func syncGetUser(byLogin login: String, byPassword password: String) -> User?
    func asyncGetUser(byLogin login: String, byPassword password: String) async -> User?

    func syncGetAllUsers() -> [User]
    func asyncGetAllUsers() async -> [User]

}
