//
//  User.swift
//  CatGram
//
//  Created by Mac on 2023-10-29.
//

import Foundation

class User: Codable {
    var iconUrl: URL?
    var nick: String
    var amountOfPosts: Int
    var amountOfSubscribers: Int
    var amountOfSubscribtions: Int
    var email: String?
    var number: String?
    var passwordHash: String
    var description: String
    var link: String
    var posts: [Post]

    init(icon: URL?, nick: String, subr: Int, subt: Int, ema: String?, num: String?, pass: String, posts: [Post], des: String, link: String) {
        self.iconUrl = icon
        self.nick = nick
        self.amountOfPosts = posts.count
        self.amountOfSubscribers = subr
        self.amountOfSubscribtions = subt
        self.email = ema
        self.number = num
        self.passwordHash = pass
        self.posts = posts
        self.description = des
        self.link = link
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
        self.link = ""
    }
}
