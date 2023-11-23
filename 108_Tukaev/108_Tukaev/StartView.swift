//
//  StartView.swift
//  108_Tukaev
//
//  Created by surexnx on 23.11.2023.
//

import UIKit
protocol StartDelegate: AnyObject {
    func startGame()
    func easyGame()
    func hardGame()
}

class StartView: UIView {

    private lazy var startButton: UIButton = {
        var action = UIAction {_ in
            self.delegate?.startGame()
        }
        var button = UIButton(primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Endless Game", for: .normal)
        return button
    }()

    private lazy var easyButton: UIButton = {
        var action = UIAction {_ in
            self.delegate?.easyGame()
        }
        var button = UIButton(primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Easy Game", for: .normal)
        return button
    }()

    private lazy var hardButton: UIButton = {
        var action = UIAction {_ in
            self.delegate?.hardGame()
        }
        var button = UIButton(primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Hard game", for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func clearView() {
        startButton.removeFromSuperview()
    }
    var delegate: StartDelegate?

    func setupLayout() {
        addSubview(startButton)
        addSubview(easyButton)
        addSubview(hardButton)

        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: centerYAnchor),

            easyButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            easyButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 10),

            hardButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            hardButton.topAnchor.constraint(equalTo: easyButton.bottomAnchor, constant: 10)
        ])
    }
}
