//
//  User.swift
//  Homework6
//
//  Created by kerik on 05.11.2023.
//

import Foundation

struct User {
    var avatar: String
    let fullName: String
    let login: String
    let password: String
    var posts: [Post] = []
    var numberOfSubscribers: Int
}

