//
//  GameView.swift
//  HW_108
//
//  Created by Азат Зиганшин on 18.11.2023.
//

import UIKit

class GameView: UIView {

    let spaceshipImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "spaceship"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    var panHandler: ((UIPanGestureRecognizer) -> Void)?
    var aliens: [Alien] = []

    override func layoutSubviews() {
        super.layoutSubviews()

        setupBackground()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        spaceshipImageView.addGestureRecognizer(panGesture)
        spaceshipImageView.isUserInteractionEnabled = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GameView {

    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        panHandler?(gesture)
    }

    func setupBackground() {

        let backgroundImage = UIImageView(image: UIImage(named: "space"))
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.frame = bounds
        addSubview(backgroundImage)
        sendSubviewToBack(backgroundImage)
    }

    func setupLayout() {

        let alien1 = Alien(image: UIImage(named: "alien"))
        let alien2 = Alien(image: UIImage(named: "alien"))
        let alien3 = Alien(image: UIImage(named: "alien"))
        let alien4 = Alien(image: UIImage(named: "alien"))
        aliens.append(alien1)
        aliens.append(alien2)
        aliens.append(alien3)
        aliens.append(alien4)

        addSubview(alien1.view)
        addSubview(alien2.view)
        addSubview(alien3.view)
        addSubview(alien4.view)
        addSubview(spaceshipImageView)

        NSLayoutConstraint.activate([

            spaceshipImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            spaceshipImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            spaceshipImageView.widthAnchor.constraint(equalToConstant: 75),
            spaceshipImageView.heightAnchor.constraint(equalToConstant: 150),

            alien1.view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            alien2.view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            alien3.view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            alien4.view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),

            alien1.view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            alien2.view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 110),
            alien3.view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            alien4.view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -110)

        ])
    }
}
