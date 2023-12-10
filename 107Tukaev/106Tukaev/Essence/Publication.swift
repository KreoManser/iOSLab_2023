//
//  Publication.swift
//  106Tukaev
//
//  Created by surexnx on 29.10.2023.
//
import UIKit
import Foundation

struct Publication: Hashable, Identifiable {
    let id: Int
    let userId: Int
    var description: String
    var images: [UIImage?]
    var date: Date
    var likesUsers: [Int]

    init(_ id: Int, _ userId: Int, _ description: String, _ images: [UIImage?], _ date: Date) {
        self.id = id
        self.userId = userId
        self.description = description
        self.images = images
        self.date = date
        self.likesUsers = []
    }

    mutating func addLikeUser(userId: Int) -> Int {
        if !likesUsers.contains(userId) {
            likesUsers.append(userId)
        } else {
            likesUsers.removeAll(where: { $0 == userId })
        }
        return likesUsers.count
    }

    func likeDisplay(userId: Int) -> Bool {
        if !likesUsers.contains(userId) {
            return true
        } else {
            return false
        }
    }

    mutating func setLikes(likes: [Int]) {
        self.likesUsers = likes
    }
}
