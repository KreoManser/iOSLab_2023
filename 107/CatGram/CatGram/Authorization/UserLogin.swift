//
//  UserLogin.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 09.11.2023.
//

import Foundation
import UIKit
struct UserLogin: Identifiable {
    let id: UUID
    let login: String
    let password: String
    let avatar: UIImage?
}
