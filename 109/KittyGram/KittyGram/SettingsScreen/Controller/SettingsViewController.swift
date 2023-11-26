//
//  SettingsViewController.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 26.11.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - Variables
    private let settingsView = SettingsView(frame: .zero)

    private let dataManager = DataManager.shared

    // MARK: - Lifecycle
    override func loadView() {
        view = settingsView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.controller = self
    }

}

extension SettingsViewController {

    func dismissController() {
        dismiss(animated: true)
    }

    func logOutUser() {
        dataManager.logOutUser()
        let presentContoller = LoginViewController()
        presentContoller.modalPresentationStyle = .fullScreen
        present(presentContoller, animated: true)
    }
}
