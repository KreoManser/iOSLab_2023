//
//  Follower.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 25.11.2023.
//

import Foundation
import UIKit

struct Follower: Identifiable {
    var id: UUID
    var avatar: UIImage?
    var userName: String
    var status: String
}
