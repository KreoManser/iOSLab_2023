//
//  Post.swift
//  HW_106
//
//  Created by Азат Зиганшин on 29.10.2023.
//

import Foundation
import UIKit

struct Publication {
    let id: String
    let userId: String
    let photo: UIImage?
    let text: String
    let date: Date = Date()

    func getLikesCount() -> Int {
        return LikesManager.shared.getLikesCount(publicationId: self.id)
    }
}
