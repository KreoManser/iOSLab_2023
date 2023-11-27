import Foundation
import UIKit

protocol LoginDataManagerProtocol {
    func userExist(login: String, password: String, comeletion: @escaping (User?) -> Void)
    func getCurUser() async -> User
}

class LoginDataManager: NSObject, LoginDataManagerProtocol, UITextFieldDelegate {
    static var loginShared = LoginDataManager()
    static var curUser: String = ""
    private var users: [User] = [User(id: 1, login: "Timerglot", password: "Tim1", avatarImageName: "avatar1",
    description: "Timur Khairullin, Kazan📍", subsCount: "122", followsCount: "344"),
    User(id: 2, login: "Giga_chad", password: "G1ga", avatarImageName: "avatar2",
    description: "Mind giant", subsCount: "1232", followsCount: "33344"),
    User(id: 3, login: "The_benko", password: "Misha", avatarImageName: "avatar3",
    description: "Petrovich", subsCount: "42", followsCount: "4")]

    private func asyncCheckUser(login: String, password: String) async -> User? {
        guard let user = users.first(where: { $0.login == login && $0.password == password }) else { return nil }
        return user
    }

    func userExist(login: String, password: String, comeletion: @escaping (User?) -> Void) {
        Task {
            let user = await asyncCheckUser(login: login, password: password)
            LoginDataManager.curUser = user?.login ?? ""
            comeletion(user)
        }
    }

    func getCurUser() async -> User {
        return users.first(where: { $0.login == LoginDataManager.curUser }) ??
        User(id: 0, login: "", password: "", avatarImageName: "", description: "", subsCount: "", followsCount: "")
    }
    func getCurUserSync() -> User {
        return users.first(where: { $0.login == LoginDataManager.curUser }) ??
        User(id: 0, login: "", password: "", avatarImageName: "", description: "", subsCount: "", followsCount: "")
    }
    func getUsersName() -> [String] {
        return users.map { $0.login }
    }

    func getUsersAvatarImageName() -> [String] {
        return users.map { $0.avatarImageName }
    }
}
