//
//  ProfileModel.swift
//  homework_6
//
//  Created by Кирилл Щёлоков on 29.10.2023.
//

import Foundation
import UIKit

struct Post: Equatable, Identifiable {
    let id: UUID
    let image: UIImage?
    let caption: String
    let date: String
    let isFavorite: Bool
}
