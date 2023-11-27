//
//  Comment.swift
//  CatGram
//
//  Created by Mac on 2023-10-29.
//

import Foundation

struct Comment: Codable {
    let author: User
    let dateOfPublication: Date
    var body: String
    var amountOfLikes: Int
}
