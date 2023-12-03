//
//  LikesManager.swift
//  HW_106
//
//  Created by Азат Зиганшин on 27.11.2023.
//

import Foundation

class LikesManager {

    static let shared = LikesManager()

    private let likesUserDefaults = UserDefaults(suiteName: "likes")
    private let likesCountUserDefaults = UserDefaults(suiteName: "likesCount")

    func save(userId: String, publicationId: String) {

        if var likes = likesUserDefaults?.array(forKey: userId) as? [String] {
            likes.append(publicationId)
            likesUserDefaults?.setValue(likes, forKey: userId)
            addLikeToPublication(publicationId: publicationId)

        } else {
            likesUserDefaults?.setValue([publicationId], forKey: userId)
            addLikeToPublication(publicationId: publicationId)
        }
    }

    func remove(userId: String, publicationId: String) {

        guard var likes = likesUserDefaults?.array(forKey: userId) as? [String]
        else { return }

        if let index = likes.firstIndex(of: publicationId) {
            likes.remove(at: index)
            likesUserDefaults?.setValue(likes, forKey: userId)
            removeLikeFromPublication(publicationId: publicationId)
        }
    }

    func isLiked(userId: String, publicationId: String) -> Bool {

        guard let likes = likesUserDefaults?.array(forKey: userId) as? [String]
        else { return false }

        if likes.firstIndex(of: publicationId) != nil {
            return true
        } else { return false }
    }

    func getLikesCount(publicationId: String) -> Int {

        if let likesCount = likesCountUserDefaults?.integer(forKey: publicationId) {
            return likesCount
        } else {
            return 0
        }
    }

    private func addLikeToPublication(publicationId: String) {

        if var likesCount = likesCountUserDefaults?.integer(forKey: publicationId) {
            likesCount += 1
            likesCountUserDefaults?.setValue(likesCount, forKey: publicationId)
        } else {
            likesCountUserDefaults?.setValue(1, forKey: publicationId)
        }
    }

    private func removeLikeFromPublication(publicationId: String) {

        guard var likesCount = likesCountUserDefaults?.integer(forKey: publicationId) else { return }
        likesCount -= 1
        likesCountUserDefaults?.setValue(likesCount, forKey: publicationId)
    }
}
