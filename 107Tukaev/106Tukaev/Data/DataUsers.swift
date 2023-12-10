//
//  DataUsers.swift
//  107Tukaev
//
//  Created by surexnx on 05.11.2023.
//

import Foundation
import UIKit

class DataUsers {

    private var users: [User]

    init() {
        users = [
            User(1, "admin", "123", "Aidar", [2, 3], 3, 10, 10),
            User(2, "neadmin", "123", "Oleg", [1, 3], 3, 10, 10),
            User(3, "adminchik", "123", "Alina", [1, 2], 3, 10, 10)
        ]
    }

    func getUsers() -> [User] {
        return users
    }
}
