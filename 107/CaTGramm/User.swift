//
//  User.swift
//  CaTGramm
//
//  Created by Rustem on 05.11.2023.
//

import Foundation

class User {
    var userName: String
    var avatar: String
    var password: String
    var profileDescription: String
    func getAllUserPosts() -> [PictureModel] {
        return DataManager.OurDataManager.dataSource.filter { $0.nickname == self.userName }
    }

    init(userName: String, avatar: String, password: String, profileDescription: String) {
        self.userName = userName
        self.avatar = avatar
        self.password = password
        self.profileDescription = profileDescription
    }
}
