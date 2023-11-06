//
//  PublicationTable.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 02.11.2023.
//

import Foundation
import UIKit

struct DetailPublication: Equatable {
    var logoImage: UIImage? = UIImage(named: "kot3")
    var accountName: String = "Славный_Котик"
    let id: UUID
    let postImage: UIImage?
    let caption: String
    let date: String
    let isFavorite: Bool
}
