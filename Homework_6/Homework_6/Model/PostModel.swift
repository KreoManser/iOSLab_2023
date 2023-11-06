//
//  InstagramModel.swift
//  Homework_6
//
//  Created by err on 29.10.2023.
//

import UIKit

struct PostModel: Equatable, Identifiable {
    var logoImage: UIImage? = UIImage(named: "photo-1")
    var accountName: String = "CatGram"
    let id: UUID
    let postImage: UIImage?
    let description: String
    let date: String
}
