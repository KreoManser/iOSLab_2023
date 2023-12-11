//
//  SettingsView.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 25.11.2023.
//

import UIKit

protocol SettingsViewProtocol: AnyObject {
    func exitToAuthorizationController()
}

class SettingsView: UIView {

    weak var delegate: SettingsViewProtocol?

    lazy var exitButton: UIButton = {
        let action = UIAction { _ in
            self.delegate?.exitToAuthorizationController()
        }
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemBlue
        config.title = "Выйти из аккаунта"
        config.background.cornerRadius = 20
        let exitButton = UIButton(configuration: config, primaryAction: action)
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        return exitButton
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpLayout() {
        backgroundColor = .white
        addSubview(exitButton)
        NSLayoutConstraint.activate([
            exitButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            exitButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            exitButton.widthAnchor.constraint(equalToConstant: 200),
            exitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}
