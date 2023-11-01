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
struct Publications: Equatable {
    let avatar =  UIImage(named: "profile2.jpeg")
    let userName = String("lovelycats__")
    let id: UUID
    let caption: String
    let photo: UIImage?
    let date: String
    let isFav: Bool
}
