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

        settingsView?.darkThemeSwitch.isOn = settingsdataManager?.currentTheme == .dark

        settingsView?.logoutTapped = { [weak self] in
            let newController = LoginViewController()
            newController.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(newController, animated: true)
            self?.navigationController?.dismiss(animated: false, completion: nil)
            self?.view.subviews.forEach { $0.removeFromSuperview()}
        }
        settingsView?.logoutButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)

        settingsView?.didTapSegment1 = { [weak self] in
            self?.settingsView?.darkThemeSwitch.isOn = true
            self?.settingsdataManager?.toggleTheme()
            self?.settingsView?.darkThemeSwitch.isOn = self?.settingsdataManager?.currentTheme == .dark
        }

        self.settingsView?.darkThemeSwitch.addTarget(self, action: #selector(toggleThemeswitch), for: .touchUpInside)
    }

    private func setUpView() {
        settingsView = SettingsView(frame: view.bounds)
        view = settingsView
    }
    @objc private func loginTapped() {
        settingsView?.logoutTapped!()
        userdataManager?.userdefaults.removeObject(forKey: Keys.loggedUser)
        userdataManager?.userdefaults.removeObject(forKey: Keys.likedPosts)
        userdataManager?.userdefaults.set(false, forKey: Keys.isUserLoggedIn)
        print("user removed/loggedout")

    }

    @objc  func toggleThemeswitch() {
        settingsView?.didTapSegment1?()
        if self.settingsView?.darkThemeSwitch.isOn == true {
            self.settingsView?.onOffLabel.text = "ON"
            self.settingsView?.darkThemeSwitch.isOn = self.settingsdataManager?.currentTheme == .dark
            settingsdataManager?.applyTheme()
        } else {
            self.settingsView?.onOffLabel.text = "OFF"
          //  self.settingsdataManager?.currentTheme == .light
            settingsdataManager?.applyTheme()
        }

    }
}
