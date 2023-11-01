//
//  User.swift
//  InstaCat
//
//  Created by Камил Хайрутдинов on 01.11.2023.
//

import Foundation

struct User {
    let userName: String
    let avatar: String
    var posts: [Post] = []
    var numberOfPosts: Int { return posts.count }
    var numberOfSubscriptions: Int
    var numberOfSubscribers: Int
    var profileDescription: String
}
