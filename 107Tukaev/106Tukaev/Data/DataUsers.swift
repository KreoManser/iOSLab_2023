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
            User(id: 1, userLogin: "admin", userPassword: "123", userName: "Aidar", userSubscription: [2, 3], publicationsCount: 3, subcriptionCount: 10, subsribersCount: 10),
            User(id: 2, userLogin: "neadmin", userPassword: "123", userName: "Oleg", userSubscription: [1, 3], publicationsCount: 3, subcriptionCount: 10, subsribersCount: 10),
            User(id: 3, userLogin: "adminchik", userPassword: "123", userName: "Alina", userSubscription: [1, 2], publicationsCount: 3, subcriptionCount: 10, subsribersCount: 10)
        ]
    }

    func getUsers() -> [User] {
        return users
    }
}
