//
//  StartView.swift
//  HW_108
//
//  Created by Азат Зиганшин on 20.11.2023.
//

import UIKit

class StartView: UIView {

    lazy var startButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30.0)
        button.addAction(UIAction { _ in
            self.controller?.presentGame()
        }, for: .touchUpInside)
        return button
    }()

    var controller: StartViewController?

    override func layoutSubviews() {
        super.layoutSubviews()

        setupBackground()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StartView {

    func setupBackground() {

        let backgroundImage = UIImageView(image: UIImage(named: "space"))
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.frame = bounds
        addSubview(backgroundImage)
        sendSubviewToBack(backgroundImage)
    }

    func setupLayout() {

        addSubview(startButton)

        NSLayoutConstraint.activate([
            startButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            startButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            startButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100)
        ])
    }
}
