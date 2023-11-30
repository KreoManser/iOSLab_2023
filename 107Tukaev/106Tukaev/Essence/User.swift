//
//  User.swift
//  107Tukaev
//
//  Created by surexnx on 02.11.2023.
//
import Foundation
import UIKit

struct User {
    var id: Int
    var userLogin: String
    var userPassword: String
    var userName: String
    var userImage: UIImage?
    var userSubscription: [Int]
    var publicationsCount: Int
    var subcriptionCount: Int
    var subsribersCount: Int

    init(
        _ id: Int,
        _ userLogin: String,
        _ userPassword: String,
        _ userName: String,
        _ userSubscription: [Int],
        _ publicationsCount: Int,
        _ subcriptionCount: Int,
        _ subsribersCount: Int
    ) {
        self.id = id
        self.userLogin = userLogin
        self.userPassword = userPassword
        self.userName = userName
        self.userImage = UIImage(named: "user")
        self.userSubscription = userSubscription
        self.publicationsCount = publicationsCount
        self.subcriptionCount = subcriptionCount
        self.subsribersCount = subsribersCount
    }
    init() {
        self.id = 0
        self.userLogin = "userLogin"
        self.userPassword = "userPassword"
        self.userName = "userName"
        self.userImage = UIImage(named: "user")
        self.userSubscription = [0]
        self.publicationsCount = 0
        self.subcriptionCount = 0
        self.subsribersCount = 0
    }
}
