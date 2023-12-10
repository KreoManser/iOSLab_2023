//
//  AuthViewController.swift
//  107Tukaev
//
//  Created by surexnx on 02.11.2023.
//

import UIKit

class AuthViewController: UIViewController {

    private let userDefaults = UserDefaults.standard
    private let loginKey = "login_save"
    private let passKey = "pass_save"

    private lazy var customview: AuthView = {
        return AuthView(frame: .zero)
    }()

    lazy var dataManager = CoreDataManager.shared

    override func loadView() {
        view = customview
        customview.contoller = self
        customview.delegate = self
        customview.regisDelegate = self
    }
}

extension AuthViewController: CheckAuthDelegate, RegisDelegate {
    func goToRegis() {
        let regisController = RegistrationViewController()
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window {
            window.rootViewController = regisController
            window.makeKeyAndVisible()
        }
    }

    func checkAuth(login: String, password: String) {
        self.userDefaults.setValue(login, forKey: loginKey)
        self.userDefaults.setValue(password, forKey: passKey)
        if dataManager.authCheck(login: login, pass: password) {
            let tapbarController = TapBarController()
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window {
                window.rootViewController = tapbarController
                window.makeKeyAndVisible()
            }
        }
    }
}
