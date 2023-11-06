//
//  LogInModel.swift
//  homework_7
//
//  Created by Кирилл Щёлоков on 05.11.2023.
//

import Foundation
import UIKit

struct User: Identifiable, Equatable {
    let id: UUID
    let login: String
    let password: String
    let avatarImage: UIImage?
}
