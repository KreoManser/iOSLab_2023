//
//  PublicationTable.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 02.11.2023.
//

import Foundation
import UIKit

struct DetailPublication: Identifiable {
    let id: UUID
    var avatarImage: UIImage?
    var accountName: String
    var postImage: UIImage?
    var caption: String
    let date: String
    let isLiked: Bool
}
extension DetailPublication: Equatable {
    static func == (lhs: DetailPublication, rhs: DetailPublication) -> Bool {
        return lhs.id == rhs.id
    }
}
