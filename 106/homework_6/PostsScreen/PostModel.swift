//
//  PostModel.swift
//  homework_6
//
//  Created by Кирилл Щёлоков on 29.10.2023.
//

import Foundation
import UIKit

struct PostModel: Equatable, Identifiable {
    var logoImage: UIImage? = UIImage(named: "logoImage")
    var accountName: String = "Pushinka.52NGG"
    let id: UUID
    let postImage: UIImage?
    let caption: String
    let date: String
    let isFavorite: Bool
}
