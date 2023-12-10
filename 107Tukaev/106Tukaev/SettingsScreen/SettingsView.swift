//
//  SettingsView.swift
//  107Tukaev
//
//  Created by surexnx on 29.11.2023.
//

import UIKit
protocol ExitDelegate: AnyObject {
    func exit()
}

class SettingsView: UIView {
    weak var delegate: ExitDelegate?
    private let userDefaults = UserDefaults(suiteName: "theme")
    private let themeKey = "save_theme"

    private lazy var themeLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var themeSwitch: UISwitch = {
        var mySwitch = UISwitch()
        mySwitch.translatesAutoresizingMaskIntoConstraints = false
        mySwitch.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
        return mySwitch
    }()

    @objc func switchChanged(_ sender: UISwitch) {
        if sender.isOn {
            themeLabel.text = "Тема: темная"
            userDefaults?.setValue(true, forKey: themeKey)
        } else {
            themeLabel.text = "Тема: светлая"
            userDefaults?.setValue(false, forKey: themeKey)
        }

    }

    private lazy var exitButton: UIButton = {
        var action = UIAction {_ in
            self.delegate?.exit()
        }

        var button = UIButton(configuration: .tinted(), primaryAction: action)
        button.setTitle("Выйти", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
        setupSwitchChange()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupSwitchChange() {
        if let bool = userDefaults?.bool(forKey: themeKey) {
            if bool {
                themeSwitch.isOn = true
                themeLabel.text = "Тема: темная"
            } else {
                themeSwitch.isOn = false
                themeLabel.text = "Тема: светлая"
            }
        }
    }

    private func setupLayout() {
        addSubview(themeSwitch)
        addSubview(themeLabel)
        addSubview(exitButton)
        NSLayoutConstraint.activate([

            themeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            themeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),

            themeSwitch.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            themeSwitch.leadingAnchor.constraint(equalTo: themeLabel.trailingAnchor, constant: 10),

            exitButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
            exitButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)

        ])
    }
}
