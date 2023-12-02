//
//  Publications.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 31.10.2023.
//

import Foundation
import UIKit

/// for publication page to view posts as a scrolling list
///  setting the avatar and userName to avoid repetition when creating array of posts in datamanager.
struct Publications: Equatable, Codable {
    var avatar =  UIImage(named: "profile2.jpeg")
    var userName = String("lovelycats__")
    let id: UUID
    let caption: String
    let photo: UIImage?
    let date: String
    var isFav: Bool
    var likeCount: Int = 0
}

extension Publications {
    enum CodingKeys: String, CodingKey {
        case id, avatar, userName, caption, photo, date, isLiked
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        avatar = try container.decodeIfPresent(Data.self, forKey: .avatar).flatMap { UIImage(data: $0) }
        userName = try container.decode(String.self, forKey: .userName)
        caption = try container.decode(String.self, forKey: .caption)
        photo = try container.decodeIfPresent(Data.self, forKey: .photo).flatMap { UIImage(data: $0) }
        date = try container.decode(String.self, forKey: .date)
        isFav = try container.decode(Bool.self, forKey: .isLiked)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(avatar.flatMap { $0.pngData() }, forKey: .avatar)
        try container.encode(userName, forKey: .userName)
        try container.encode(caption, forKey: .caption)
        try container.encodeIfPresent(photo.flatMap { $0.pngData() }, forKey: .photo)
        try container.encode(date, forKey: .date)
        try container.encode(isFav, forKey: .isLiked)
    }
}
