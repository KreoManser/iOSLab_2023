import Foundation
import UIKit

protocol LoginDataManagerProtocol {
    func userExist(login: String, password: String, comeletion: @escaping (User?) -> Void)
}

class LoginDataManager: NSObject, LoginDataManagerProtocol, UITextFieldDelegate {
    static var curUser: String = ""
    private var users: [User] = [User(id: 1, login: "Timerglot", password: "Tim1", avatarImageName: "avatar1"),
    User(id: 2, login: "Giga_chad", password: "G1ga", avatarImageName: "avatar2"),
    User(id: 2, login: "The_benko", password: "Misha", avatarImageName: "avatar3")]

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
}
