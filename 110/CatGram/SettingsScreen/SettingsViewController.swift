//
//  SettingsViewController.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 26.11.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    var settingsView: SettingsView?
    var settingsdataManager: SettingsDataManager?
    var userdataManager: UserDataManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        settingsdataManager = SettingsDataManager.shared
        setUpView()

        settingsView?.logoutTapped = { [weak self] in
            let newController = LoginViewController()
            newController.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(newController, animated: true)
            self?.navigationController?.dismiss(animated: false, completion: nil)
            self?.view.subviews.forEach {$0.removeFromSuperview()}
        }
        settingsView?.logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)

        self.settingsView?.darkThemeSwitch.addTarget(self,
                                                     action: #selector(toggleThemeswitch(_ :)), for: .valueChanged)
    }

    private func setUpView() {
        settingsView = SettingsView(frame: view.bounds)
        view = settingsView
    }
    @objc private func logoutTapped() {
        settingsView?.logoutTapped!()
        userdataManager?.userdefaults.removeObject(forKey: Keys.loggedUser)
        userdataManager?.userdefaults.set(false, forKey: Keys.isUserLoggedIn)
        print("user removed/loggedout")
    }

    @objc  func toggleThemeswitch(_ sender: UISwitch) {
        self.settingsdataManager?.toggleTheme()
        if let isDarkMode = settingsdataManager?.isDarkMode {
                settingsView?.onOffLabel.text = isDarkMode ? "ON" : "OFF"
            }
    }
}
