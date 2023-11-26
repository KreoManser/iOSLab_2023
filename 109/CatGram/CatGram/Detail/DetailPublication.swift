//
//  PublicationTable.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 02.11.2023.
//

import Foundation
import UIKit

struct DetailPublication: Equatable, Identifiable {
    let id: UUID
    var avatarImage: UIImage?
    var accountName: String
    let postImage: UIImage?
    let caption: String
    let date: String
    let isLiked: Bool
}
