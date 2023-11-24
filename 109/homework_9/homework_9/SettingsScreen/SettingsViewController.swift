//
//  SettingsViewController.swift
//  homework_9
//
//  Created by Кирилл Щёлоков on 24.11.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    private var settingsView: SettingsView?
    private var settingsDataManager: SettingsDataManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSettingsDataManager()
        setUpSettingsView()
        setUpNavigationBar()
    }

    private func setUpSettingsView() {
        settingsView = SettingsView(frame: view.bounds)
        settingsView?.settingsTableView.delegate = settingsDataManager
        settingsView?.settingsTableView.dataSource = settingsDataManager
        settingsView?.settingsTableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.reuseIdentifier)
        view = settingsView
    }

    private func setUpSettingsDataManager() {
        settingsDataManager = SettingsDataManager()
        settingsDataManager?.cellTapped = { [weak self] viewController in
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
    }

    private func setUpNavigationBar() {
        navigationItem.title = "Настройки"
    }
}
