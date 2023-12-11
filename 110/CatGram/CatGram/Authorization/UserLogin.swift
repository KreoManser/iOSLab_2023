//
//  UserLogin.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 09.11.2023.
//

import Foundation
import UIKit
struct UserLogin: Identifiable {
    var id: UUID
    var login: String
    var password: String
    var avatar: UIImage?
}
