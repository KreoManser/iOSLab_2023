//
//  SettingsView.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 26.11.2023.
//

import UIKit

class SettingsView: UIView {
    // MARK: - UI elements
    private lazy var settingButtonsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            SettingButtonTableViewCell.self,
            forCellReuseIdentifier: SettingButtonTableViewCell.reuseIdentifier)
        tableView.backgroundColor = UIColor.customBlack
        tableView.estimatedRowHeight = 40
        tableView.isScrollEnabled = false
        return tableView
    }()

    // MARK: - Variables
    weak var controller: SettingsViewController?
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.customBlack
        addSubviews(subviews: settingButtonsTableView)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupDataSource(dataSource: UITableViewDataSource) {
        settingButtonsTableView.dataSource = dataSource
    }

}

extension SettingsView {
    private func addSubviews(subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }

    private func configureUI() {
        NSLayoutConstraint.activate([
            settingButtonsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            settingButtonsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            settingButtonsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            settingButtonsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
