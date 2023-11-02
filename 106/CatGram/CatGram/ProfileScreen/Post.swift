//
//  Post.swift
//  CatGram
//
//  Created by Аделя Миннехузина on 01.11.2023.
//

import Foundation
import UIKit

struct Post: Identifiable, Equatable {
    let id: UUID
    let image: UIImage?
    let caption: String
    let date: String
    let isFavorite: Bool
}
