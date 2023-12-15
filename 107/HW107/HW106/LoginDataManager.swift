import Foundation
import UIKit

protocol LoginDataManagerProtocol {
    func userExist(login: String, password: String) async -> Bool
    func getCurUser() async -> User
    func getCountOfFriends() -> Int
    func getFriends() -> [User]
}

class LoginDataManager: NSObject, LoginDataManagerProtocol, UITextFieldDelegate {
    static var loginShared = LoginDataManager()
    static var curUser: String = ""
    private var users: [User] = CoreDataManager.shared.getAllUsers()

    private func asyncCheckUser(login: String, password: String) async -> User? {
        guard let user = users.first(where: { $0.login == login && $0.password == password }) else { return nil }
        return user
    }

    private func checkUser(login: String, password: String) -> User? {
        guard let user = users.first(where: { $0.login == login && $0.password == password }) else { return nil }
        return user
    }

    func userExist(login: String, password: String) async -> Bool {
        if let user = await asyncCheckUser(login: login, password: password) {
            do {
                try DataManager.shared.saveUser(user: user)
                DataManager.shared.userDefaults.setValue(true, forKey: DataManager.shared.loginBoolKey)
                return true
            } catch {
                print(error)
            }
        }
        return false
    }

    func userExistSync(login: String, password: String) -> Bool {
        if let user = checkUser(login: login, password: password) {
            do {
                try DataManager.shared.saveUser(user: user)
                DataManager.shared.userDefaults.setValue(true, forKey: DataManager.shared.loginBoolKey)
                return true
            } catch {
                print(error)
            }
        }
        return false
    }

    func getCurUser() async -> User {
        return users.first(where: { $0.login == LoginDataManager.curUser }) ?? User(context: CoreDataManager.shared.viewContext)
    }
    func getCurUserSync() -> User {
        return users.first(where: { $0.login == LoginDataManager.curUser }) ?? User(context: CoreDataManager.shared.viewContext)
    }
    func getUsersName() -> [String] {
        return users.map { $0.login }
    }

    func getUsersAvatarImageName() -> [String] {
        return users.map { $0.avatarImageName }
    }

    func getCountOfFriends() -> Int { users.count - 1 }

    func getFriends() -> [User] { users.filter { $0.login != LoginDataManager.curUser }}
}
