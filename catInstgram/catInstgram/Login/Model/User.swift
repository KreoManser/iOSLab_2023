//
//  User.swift
//  catInstgram
//
//  Created by marwa awwad mohamed awwad on 22/12/2023.
//

import Foundation

struct User {
    let username: String
    var fullName: String
    var avatar: String
    var posts: [Post] = []
    var story: Story = Story()
    var numberOfSubscribers: Int
    var profileDescription: String
    var subscriptions: [User] = []
    let password: String
}
