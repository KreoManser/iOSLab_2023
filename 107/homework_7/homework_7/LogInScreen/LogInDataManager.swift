//
//  LogInDataManager.swift
//  homework_7
//
//  Created by Кирилл Щёлоков on 05.11.2023.
//

import Foundation
import UIKit

class LogInDataManager: NSObject, LogInDataManageProtocol, UITextFieldDelegate {

    static var authUser: String = ""

    private var users: [User] = [
        User(id: UUID(), login: "Pushinka.52NGG", password: "123", avatarImage: UIImage(named: "logoImage")),
        User(id: UUID(), login: "Admin", password: "admin", avatarImage: UIImage(named: "adminLogo")),
        User(id: UUID(), login: "dogLover", password: "dogLover", avatarImage: UIImage(named: "dogLogo"))
    ]

    func checkUserExists(username: String, password: String, completion: @escaping (User?) -> Void) {
        Task {
            let user = await fetchUser(username: username, password: password)
            LogInDataManager.authUser = user?.login ?? ""
            completion(user)
        }
    }

    private func fetchUser(username: String, password: String) async -> User? {
        if let user = users.first(where: { $0.login == username && $0.password == password }) {
            return user
        } else {
            return nil
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
