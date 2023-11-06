//
//  User.swift
//  InstaCat
//
//  Created by Камил Хайрутдинов on 01.11.2023.
//

import Foundation

struct User {
    let nickname: String
    var fullName: String
    var avatar: String
    var posts: [Post] = []
    var story: Story = Story()
    var numberOfSubscribers: Int
    var profileDescription: String
    var subscriptions: [User] = []
    let password: String
}
