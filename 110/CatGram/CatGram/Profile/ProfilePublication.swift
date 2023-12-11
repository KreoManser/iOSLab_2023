//
//  Publication.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 02.11.2023.
//

import Foundation
import UIKit
struct ProfilePublication {
    let id: UUID
    let image: UIImage?
    let caption: String
    let date: String
    let isLiked: Bool
    let userProfile: (userName: String, avatar: UIImage?)
}
