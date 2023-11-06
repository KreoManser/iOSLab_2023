//
//  User.swift
//  CatGram
//
//  Created by Mac on 2023-10-29.
//

import Foundation

class User {
    var iconUrl: URL?
    var nick: String
    var amountOfPosts: Int
    var amountOfSubscribers: Int
    var amountOfSubscribtions: Int
    var email: String?
    var number: String?
    var passwordHash: String
    var description: String
    var posts: [Post]

    init(iconUrl: URL?, nick: String, subers: Int, subtions: Int, email: String?, number: String?, passHash: String, posts: [Post], destion: String) {
        self.iconUrl = iconUrl
        self.nick = nick
        self.amountOfPosts = posts.count
        self.amountOfSubscribers = subers
        self.amountOfSubscribtions = subtions
        self.email = email
        self.number = number
        self.passwordHash = passHash
        self.posts = posts
        self.description = destion
    }

    init() {
        self.iconUrl = nil
        self.nick = ""
        self.amountOfPosts = 0
        self.amountOfSubscribers = 0
        self.amountOfSubscribtions = 0
        self.email = nil
        self.number = nil
        self.passwordHash = ""
        self.posts = []
        self.description = ""
    }
}
