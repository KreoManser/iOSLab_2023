//
//  Post.swift
//  HW_106
//
//  Created by Азат Зиганшин on 29.10.2023.
//

import Foundation
import UIKit

struct Publication {
    let id: UUID = UUID()
    let userId: String
    let photo: UIImage?
    let text: String
    let date: Date = Date()
}
