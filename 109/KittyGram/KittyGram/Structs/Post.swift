//
//  Post.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 22.11.2023.
//

import Foundation

struct Post: Codable {
    let id: Int
    let imageName: String
    let description: String
    var likes: Int
}
