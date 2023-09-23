//
//  User.swift
//  Homework_2
//
//  Created by Камил Хайрутдинов on 16.09.2023.
//

import Foundation
import UIKit

class User {
    let name: String
    let login: String
    let password: String
    let phoneNumber: String
    let image: UIImage?
    
    init(name: String, login: String, password: String, phoneNumber: String, image: UIImage) {
        self.name = name
        self.login = login
        self.password = password
        self.phoneNumber = phoneNumber
        self.image = image
    }
}
