//
//  SettingsViewController.swift
//  107Tukaev
//
//  Created by surexnx on 29.11.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    private let userDefaults = UserDefaults.standard
    private let loginKey = "login_save"
    private let passKey = "pass_save"

    private lazy var customView: SettingsView = {
        return SettingsView(frame: .zero)
    }()

    override func loadView() {
        view = customView
        customView.delegate = self

    }
}
extension SettingsViewController: ExitDelegate {

    func exit() {
        userDefaults.removeObject(forKey: loginKey)
        userDefaults.removeObject(forKey: passKey)
        DataManagerPublication.shared.removeUser()
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window {
            window.rootViewController = AuthViewController()
            window.makeKeyAndVisible()
        }
    }
}
