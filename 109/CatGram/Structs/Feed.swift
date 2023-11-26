//
//  Feed.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 05.11.2023.
//

import Foundation
import UIKit

struct Feed: Codable {
    let id: UUID
    let avatar: UIImage?
    let userName: String
    let caption: String
    let photo: UIImage?
    let date: String
    let category: String
    var isLiked: Bool = false
}
extension Feed {
    enum CodingKeys: String, CodingKey {
        case id, avatar, userName, caption, photo, date, category, isLiked
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        avatar = try container.decodeIfPresent(Data.self, forKey: .avatar).flatMap { UIImage(data: $0) }
        userName = try container.decode(String.self, forKey: .userName)
        caption = try container.decode(String.self, forKey: .caption)
        photo = try container.decodeIfPresent(Data.self, forKey: .photo).flatMap { UIImage(data: $0) }
        date = try container.decode(String.self, forKey: .date)
        category = try container.decode(String.self, forKey: .category)
        isLiked = try container.decode(Bool.self, forKey: .isLiked)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(avatar.flatMap { $0.pngData() }, forKey: .avatar)
        try container.encode(userName, forKey: .userName)
        try container.encode(caption, forKey: .caption)
        try container.encodeIfPresent(photo.flatMap { $0.pngData() }, forKey: .photo)
        try container.encode(date, forKey: .date)
        try container.encode(category, forKey: .category)
        try container.encode(isLiked, forKey: .isLiked)
    }
}
