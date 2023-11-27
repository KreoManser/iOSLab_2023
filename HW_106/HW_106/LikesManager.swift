//
//  LikesManager.swift
//  HW_106
//
//  Created by Азат Зиганшин on 27.11.2023.
//

import Foundation

class LikesManager {

    static let shared = LikesManager()

    private let userDefaults = UserDefaults(suiteName: "likes")

    func save(userId: String, publicationId: String) {

        if var likes = userDefaults?.array(forKey: userId) as? [String] {
            likes.append(publicationId)
            userDefaults?.setValue(likes, forKey: userId)

        } else {
            userDefaults?.setValue([publicationId], forKey: userId)
        }
    }

    func remove(userId: String, publicationId: String) {

        guard var likes = userDefaults?.array(forKey: userId) as? [String]
        else { return }

        if let index = likes.firstIndex(of: publicationId) {
            likes.remove(at: index)
            userDefaults?.setValue(likes, forKey: userId)
        }
    }

    func isLiked(userId: String, publicationId: String) -> Bool {

        guard let likes = userDefaults?.array(forKey: userId) as? [String]
        else { return false }

        if likes.firstIndex(of: publicationId) != nil {
            return true
        } else { return false }
    }
}
