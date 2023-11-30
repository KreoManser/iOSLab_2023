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
    var likes: Int

    init(_ id: Int, _ userId: Int, _ description: String, _ images: [UIImage?], _ date: Date) {
        self.id = id
        self.userId = userId
        self.description = description
        self.images = images
        self.date = date
        self.likes = 0
    }

    mutating func addLike() {
        likes += 1
    }

    mutating func setLikes(likes: Int) {
        self.likes = likes
    }
}
