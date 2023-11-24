//
//  LogInDataManager.swift
//  homework_7
//
//  Created by Кирилл Щёлоков on 05.11.2023.
//

import Foundation
import UIKit

class LogInDataManager: NSObject, LogInDataManageProtocol, UITextFieldDelegate {

    let userDefaults = UserDefaults.standard

    private var users: [User] = [
        User(id: UUID(), login: "Pushinka.52NGG", password: "123", avatarImage: UIImage(named: "logoImage")),
        User(id: UUID(), login: "Admin", password: "admin", avatarImage: UIImage(named: "adminLogo")),
        User(id: UUID(), login: "dogLover", password: "dogLover", avatarImage: UIImage(named: "dogLogo"))
    ]

    func checkUserExists(username: String, password: String, completion: @escaping (User?) -> Void) {
        Task {
            let user = await fetchUser(username: username, password: password)
            completion(user)
        }
    }

    private func fetchUser(username: String, password: String) async -> User? {
        if let user = users.first(where: { $0.login == username && $0.password == password }) {
            saveLogInUser(user: user)
            return user
        } else {
            return nil
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    private func saveLogInUser(user: User) {
        do {
            let encodedData = try JSONEncoder().encode(user)
            userDefaults.set(encodedData, forKey: "loggedInUser")
            userDefaults.set(true, forKey: "isUserLogged")
        } catch {
            print("save data exeption \(error)")
        }
    }

}
