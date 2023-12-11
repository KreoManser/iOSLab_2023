//
//  SettingsView.swift
//  homework_10
//
//  Created by Кирилл Щёлоков on 10.12.2023.
//

import UIKit

class SettingsView: UIView {

    lazy var settingsTableView: UITableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpSettingsTableView()
    }

    private func setUpSettingsTableView() {
        addSubview(settingsTableView)
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            settingsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            settingsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            settingsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
