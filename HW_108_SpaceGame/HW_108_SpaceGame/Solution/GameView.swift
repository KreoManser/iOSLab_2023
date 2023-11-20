//
//  GameView.swift
//  HW_108_SpaceGame
//
//  Created by Артур Миннушин on 20.11.2023.
//

import UIKit

class GameView: UIView {
    var gameCredits: Int = 0
    var player: Player?
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Space"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var creditsLbael: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Credits: \(gameCredits)"
        label.textColor = .systemMint
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    lazy var playerImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundImageView)
        addSubview(creditsLbael)
        addSubview(playerImageView)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GameView {
    func setupPlayer(player: Player) {
        self.player = player
        setupPlayerShip()
    }
    func setupPlayerShip() {
        playerImageView.image = player?.shipImageView.image
        NSLayoutConstraint.activate([
            playerImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            playerImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            playerImageView.widthAnchor.constraint(equalToConstant: 80),
            playerImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    func setupLayout() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(
                equalTo: topAnchor, constant: 0),
            backgroundImageView.bottomAnchor.constraint(
                equalTo: bottomAnchor, constant: 10),
            backgroundImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor, constant: 0),
            backgroundImageView.trailingAnchor.constraint(
                equalTo: trailingAnchor, constant: 0),
            creditsLbael.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            creditsLbael.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ])
    }
}
