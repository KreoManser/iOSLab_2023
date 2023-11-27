//
//  SettingsViewController.swift
//  CatGram
//
//  Created by Mac on 2023-11-26.
//

import UIKit

class SettingsViewController: UIViewController {
    private var settingsView: SettingsView

    // MARK: - Init
    init(user: User) {
        settingsView = SettingsView(frame: CGRect(), user: user)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Load view
    override func loadView() {
        view = settingsView
    }
}
