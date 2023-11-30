//
//  SettingsView.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 29.11.2023.
//

import UIKit

class SettingsView: UIView {
    var settingsVC: SettingsViewController?
    lazy var settingsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Настройки"
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    lazy var bgBlacThemeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Черная тема"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    lazy var bgBlackThemeSWitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.translatesAutoresizingMaskIntoConstraints = false
        return mySwitch
    }()
    lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выйти", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 20
        let action = UIAction { _ in
            self.settingsVC?.accountLogOut()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(settingsLabel)
        addSubview(bgBlacThemeLabel)
        addSubview(bgBlackThemeSWitch)
        addSubview(logOutButton)
        setupLayer()
        setupSwipeRecognizer()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayer() {
        NSLayoutConstraint.activate([
            settingsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            settingsLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            bgBlacThemeLabel.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 40),
            bgBlacThemeLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            bgBlackThemeSWitch.topAnchor.constraint(equalTo: bgBlacThemeLabel.topAnchor),
            bgBlackThemeSWitch.heightAnchor.constraint(equalTo: bgBlacThemeLabel.heightAnchor),
            bgBlackThemeSWitch.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            logOutButton.topAnchor.constraint(
                equalTo: bgBlacThemeLabel.bottomAnchor, constant: 20),
            logOutButton.centerXAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerXAnchor),
            logOutButton.widthAnchor.constraint(equalToConstant: 100),
            logOutButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func setupSwipeRecognizer() {
        let swipeRecognized = UISwipeGestureRecognizer(
            target: self, action: #selector(self.dismisControler))
        swipeRecognized.direction = .right
        addGestureRecognizer(swipeRecognized)
    }
    @objc func dismisControler(sender: UISwipeGestureRecognizer) {
        self.settingsVC?.dismisSettingsControler()
    }
}
