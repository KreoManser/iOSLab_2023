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

    private let dataSource = SettingButtonsTableViewDataSource()

    // MARK: - Lifecycle
    override func loadView() {
        view = settingsView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.controller = self
        settingsView.setupDataSource(dataSource: dataSource)
    }

}

extension SettingsViewController {

    func logOutUser() {
//        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//            let window = windowScene.windows.first,
//            var rootViewController = window.rootViewController {
//
//            while let presentedViewController = rootViewController.presentedViewController {
//                rootViewController = presentedViewController
//            }
//
//            rootViewController.dismiss(animated: false, completion: nil)
//        }

        dataManager.logOutUser()
        let presentContoller = LoginViewController()
        presentContoller.modalPresentationStyle = .fullScreen
        present(presentContoller, animated: true)
    }
}
