//
//  SettingsView.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 26.11.2023.
//

import UIKit

class SettingsView: UIView {

    lazy var onOffLabel: UILabel = UILabel()
    lazy var darkThemeSwitch: UISwitch = UISwitch()
    lazy var logoutButton: UIButton = UIButton()
    var logoutTapped: (() -> Void)?
    var didTapSegment1: (() -> Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSwitch()
        setUpOffLabel()
        setUpLogout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupSwitch() {
        addSubview(darkThemeSwitch)
        darkThemeSwitch.translatesAutoresizingMaskIntoConstraints = false
        darkThemeSwitch.onTintColor = .systemPink
        darkThemeSwitch.isOn = false
        darkThemeSwitch.isEnabled = true
        darkThemeSwitch.tintColor = .black

        NSLayoutConstraint.activate([
            darkThemeSwitch.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            darkThemeSwitch .leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            darkThemeSwitch.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
    private func setUpOffLabel() {
        addSubview(onOffLabel)
        onOffLabel.translatesAutoresizingMaskIntoConstraints = false
        onOffLabel.text = "OFF"
        onOffLabel.font = UIFont.systemFont(ofSize: 15)
        NSLayoutConstraint.activate([
            onOffLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            onOffLabel.leadingAnchor.constraint(equalTo: darkThemeSwitch.trailingAnchor, constant: -50)

        ])

    }

    private func setUpLogout() {
        addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.isEnabled = true
        logoutButton.setTitleColor(UIColor.white, for: .normal)
        logoutButton.backgroundColor = .black
        logoutButton.layer.cornerRadius = 5
        logoutButton.clipsToBounds = true
        logoutButton.layer.borderWidth = 1

        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: darkThemeSwitch.bottomAnchor, constant: 20),
            logoutButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            logoutButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
}
