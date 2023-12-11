//
//  SettingsViewController.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 25.11.2023.
//

import UIKit

class SettingsViewController: UIViewController, SettingsViewProtocol {

    private var settingsView: SettingsView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setUp()
    }

    func exitToAuthorizationController() {
        UserDefaults.standard.removeObject(forKey: "avatarData")
        UserDefaults.standard.removeObject(forKey: "user")
        UserDefaults.standard.removeObject(forKey: "login")
        UserDefaults.standard.removeObject(forKey: "like")
        if let firstContoller = navigationController?.viewControllers.first {
            firstContoller.tabBarController?.tabBar.isHidden = true
            firstContoller.navigationController?.setNavigationBarHidden(true, animated: false)
            navigationController?.setViewControllers([AuthorizationViewController()], animated: false)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            self.navigationController?.tabBarController?.tabBar.isHidden = false
        }
    }

    private func setupNavigationBar() {
        navigationItem.title = "Настройки"
        navigationController?.navigationBar.backgroundColor = .white
    }

    private func setUp() {
        settingsView = SettingsView(frame: .zero)
        view = settingsView
        settingsView?.delegate = self
    }

}
