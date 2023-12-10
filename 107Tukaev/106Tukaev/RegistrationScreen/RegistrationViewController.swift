//
//  RegistrationViewController.swift
//  107Tukaev
//
//  Created by surexnx on 07.12.2023.
//

import UIKit

class RegistrationViewController: UIViewController {

    private lazy var customview: RegistrationView = {
        return RegistrationView(frame: .zero)
    }()

    lazy var dataManager = CoreDataManager.shared

    override func loadView() {
        view = customview
        customview.delegate = self
        customview.authDelegate = self
        customview.contoller = self
    }

    func goToAuth() {
        let authController = AuthViewController()
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window {
            window.rootViewController = authController
            window.makeKeyAndVisible()
        }
    }

}
extension RegistrationViewController: RegistrationDelegate, AuthDelegate {
    func auth() {
        goToAuth()
    }

    func checkUser(login: String, password: String, name: String) {
        if !dataManager.checkUser(login: login, pass: password, name: name) {
            goToAuth()
        }
    }
}
