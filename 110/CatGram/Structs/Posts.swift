//
//  InstagramUser.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 29.10.2023.
//

import Foundation
import UIKit

/// for profile page
struct Post: Equatable {
    let id: UUID
    let caption: String
    let photo: UIImage?
    let date: String
    let isFav: Bool
}
