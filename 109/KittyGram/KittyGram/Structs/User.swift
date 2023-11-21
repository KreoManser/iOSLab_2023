//
//  User.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 22.11.2023.
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
