//
//  LoginDataManager.swift
//  homework_10
//
//  Created by Кирилл Щёлоков on 10.12.2023.
//

import Foundation
import UIKit

class LogInDataManager: NSObject, LogInDataManageProtocol, UITextFieldDelegate {

    let userDefaults = UserDefaults.standard
    var coreDataManager = CoreDataManager.shared

    func checkUserExists(username: String, password: String, completion: @escaping (User?) -> Void) {
        Task {
            let user = await fetchUser(username: username, password: password)
            completion(user)
        }
    }

    private func fetchUser(username: String, password: String) async -> User? {
        let users = coreDataManager.obtainAllUsers()
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
        userDefaults.set(user.id.uuidString, forKey: "loggedInUser")
        userDefaults.set(true, forKey: "isUserLogged")
    }

}
