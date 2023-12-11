//
//  DarkThemeView.swift
//  homework_10
//
//  Created by Кирилл Щёлоков on 10.12.2023.
//

import UIKit

class DarkThemeView: UIView {

    lazy var darkThemeLabel: UILabel = UILabel()
    lazy var darkThemeSwitch: UISwitch = UISwitch()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpDarkThemeLabel()
        setUpDarkThemeSwitch()
    }

    private func setUpDarkThemeSwitch() {
        addSubview(darkThemeSwitch)
        darkThemeSwitch.isOn = false
        let switchAction = UIAction { [darkThemeSwitch] _ in
            if darkThemeSwitch.isOn {
                print("I'm ON")
            } else {
                print("I'm OFF")
            }
        }
        darkThemeSwitch.addAction(switchAction, for: .valueChanged)
        darkThemeSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            darkThemeSwitch.centerYAnchor.constraint(equalTo: darkThemeLabel.centerYAnchor),
            darkThemeSwitch.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50)
        ])
    }

    private func setUpDarkThemeLabel() {
        addSubview(darkThemeLabel)
        darkThemeLabel.text = "Тёмная тема"
        darkThemeLabel.font = UIFont.boldSystemFont(ofSize: 24)
        darkThemeLabel.translatesAutoresizingMaskIntoConstraints = false
        darkThemeLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            darkThemeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            darkThemeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
}
