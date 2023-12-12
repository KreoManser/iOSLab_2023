//
//  User.swift
//  CaTGramm
//
//  Created by Rustem on 05.11.2023.
//

import Foundation

// class User {
//    var userName: String
//    var avatar: String
//    var password: String
//    var profileDescription: String
//    var likedPosts: [PictureModel]
//    func getAllUserPosts() -> [PictureModel] {
//        return DataManager.OurDataManager.dataSource.filter { $0.nickname == self.userName }
//    }
//
//    init(userName: String, avatar: String, password: String, profileDescription: String) {
//        let emptyArray: [PictureModel] = []
//        self.likedPosts = emptyArray
//        print(UserDefaults.standard.data(forKey: "liked"))
//        self.userName = userName
//        self.avatar = avatar
//        self.password = password
//        self.profileDescription = profileDescription
//        guard let userData = UserDefaults.standard.data(forKey: "liked") else { return }
//
//        do {
//            let decoder = JSONDecoder()
//            let posts = try decoder.decode([PictureModel].self, from: userData)
//            self.likedPosts = posts
//        } catch {
//            print("\(error)")
//        }
//    }
// }
