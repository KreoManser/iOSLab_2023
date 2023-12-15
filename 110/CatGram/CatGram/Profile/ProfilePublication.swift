//
//  Publication.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 02.11.2023.
//

import Foundation
import UIKit
struct ProfilePublication {
    var id: UUID
    var image: UIImage?
    var caption: String
    var date: String
    var isLiked: Bool
    var userProfile: (userName: String, avatar: UIImage?)
}
