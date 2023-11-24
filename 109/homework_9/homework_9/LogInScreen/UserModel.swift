//
//  LogInModel.swift
//  homework_7
//
//  Created by Кирилл Щёлоков on 05.11.2023.
//

import Foundation
import UIKit

struct User: Codable, Identifiable, Equatable {
    let id: UUID
    let login: String
    let password: String
    let avatarImage: Data?

    init(id: UUID, login: String, password: String, avatarImage: UIImage?) {
        self.id = id
        self.login = login
        self.password = password
        self.avatarImage = avatarImage?.pngData()
    }
}
