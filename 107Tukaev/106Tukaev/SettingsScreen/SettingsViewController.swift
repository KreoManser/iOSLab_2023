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
    private var dataManager = CoreDataManager.shared

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
        dataManager.exitUser()
        userDefaults.removeObject(forKey: loginKey)
        userDefaults.removeObject(forKey: passKey)
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window {
            window.rootViewController = AuthViewController()
            window.makeKeyAndVisible()
        }
    }
}
