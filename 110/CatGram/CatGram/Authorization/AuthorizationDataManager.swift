//
//  AuthorizationDataManager.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 09.11.2023.
//

import Foundation
import UIKit
import CoreData

class AuthorizationDataManager: NSObject, AuthorizationDataManagerProtocol {

    var authUser: UserDefaults = UserDefaults.standard

    private var users: [UserLogin] = [
        UserLogin(id: UUID(), login: "Славный_Котик", password: "111", avatar: UIImage(named: "kot3")),
        UserLogin(id: UUID(), login: "Bad_Cat", password: "222", avatar: UIImage(named: "badcat1")),
        UserLogin(id: UUID(), login: "Kitty", password: "333", avatar: UIImage(named: "k1"))
    ]

    func loginToAccount(userName: String, password: String, completion: @escaping ((UserLogin?) -> Void)) {
        Task {
            let user = await checkLoginAndPassword(userName: userName, password: password)
            authUser.setValue(user?.login, forKey: "user")
            completion(user)
        }
    }

    func checkLoginAndPassword(userName: String, password: String) async -> UserLogin? {
        if let credentials = fetchCredentials(userName, password) {
            let newUser = UserLogin(id: UUID(), login: credentials.userName, password: credentials.password, avatar: UIImage.iconProfile)
            guard self.users.contains(where: { user in
                user.login == newUser.login
            }) else { self.users.append(newUser); return newUser }
            return newUser
        }
        if let user = users.first(where: { $0.login == userName && $0.password == password }) {
            return user
        } else {
            return nil
        }
    }

    private func fetchCredentials(_ userName: String, _ password: String) -> RegistraitionEntity? {
        let context = RegistrationDataManager.shared.viewContext
        let fetchRequest: NSFetchRequest<RegistraitionEntity> = RegistraitionEntity.fetchRequest()
        do {
            let credentials = try context.fetch(fetchRequest)
            if credentials.first(where: { $0.userName == userName && $0.password == password }) != nil {
                return credentials.first(where: { $0.userName == userName && $0.password == password })
            }
        } catch {
            print("Нет таких данных")
        }
        return nil
    }

}
