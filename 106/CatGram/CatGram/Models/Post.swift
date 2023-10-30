//
//  Post.swift
//  CatGram
//
//  Created by Mac on 2023-10-29.
//

import UIKit

struct Post: Hashable {
    let id: Int
    let author: User
    let photos: UIImage
    let dateOfPublication: Date
    var comments: [Comment]
    var amountOfLikes: Int
    var description: String
}
