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
        // imageView.backgroundColor = .red
        return imageView
    }()

    var scoreLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 60)
        label.textColor = .white
        label.alpha = 0.75
        return label
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

    func incrementString() {
        guard let scoreText = scoreLabel.text else { return }
        let scoreNumber = (Int(scoreText) ?? 0) + 1
        scoreLabel.text = String(scoreNumber)
    }

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
        // addSubview(scoreLabel)

        NSLayoutConstraint.activate([

//            scoreLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
//            scoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            spaceshipImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            spaceshipImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            spaceshipImageView.widthAnchor.constraint(equalToConstant: 50),
            spaceshipImageView.heightAnchor.constraint(equalToConstant: 125),

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
