//
//  SettingsView.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 26.11.2023.
//

import UIKit

class SettingsView: UIView {
    // MARK: - UI elements
    private lazy var goBackButton: UIButton = {
        let button = UIButton(configuration: .plain())
        button.translatesAutoresizingMaskIntoConstraints = false

        let action = UIAction { [weak self] _ in
            self?.controller?.dismissController()
        }

        button.addAction(action, for: .touchDown)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        return button
    }()

    private lazy var changeThemeButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сменить тему", for: .normal)
        return button
    }()

    private lazy var logOutButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(
            UIImage(systemName: "door.left.hand.open"),
            for: .normal)
        button.setTitle("Выйти из аккаунта", for: .normal)

        let action = UIAction { [weak self] _ in
            self?.controller?.logOutUser()
        }

        button.addAction(action, for: .touchDown)

        return button
    }()

    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [changeThemeButton, logOutButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        return stackView
    }()

    // MARK: - Variables
    weak var controller: SettingsViewController?
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubviews(
            subviews: goBackButton, buttonStackView)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SettingsView {
    private func addSubviews(subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }

    private func configureUI() {
        NSLayoutConstraint.activate([
            goBackButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            goBackButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),

            buttonStackView.topAnchor.constraint(equalTo: goBackButton.bottomAnchor, constant: 20),
            buttonStackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}
