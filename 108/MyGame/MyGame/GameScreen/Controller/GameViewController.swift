//
//  GameViewController.swift
//  MyGame
//
//  Created by Камил Хайрутдинов on 18.11.2023.
//

import UIKit

class GameViewController: UIViewController {

    // MARK: - Variables
    private lazy var gameView = GameView(frame: .zero)

    private let gameManager = GameManager()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(gameView)
        configureUI()
        gameView.frame = view.frame
        gameView.controller = self
    }

}

extension GameViewController {
    private func configureUI() {
        NSLayoutConstraint.activate([
            gameView.topAnchor.constraint(equalTo: view.topAnchor),
            gameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gameView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setBulletXPosition(
        leadingAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>,
        gameView: GameView,
        sliderValue: Float) {

        let constant =  gameManager.getCurrentXCoordinate(
            startX: 40.0,
            endX: gameView.frame.width - 60,
            value: sliderValue)

            leadingAnchor.constraint(
                equalTo: gameView.safeAreaLayoutGuide.leadingAnchor,
                constant: constant).isActive = true

            gameView.bulletLeadingAnchorConstant = constant

        }

    func setRandomEnemyPosition(
        leadingAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>,
        gameView: GameView) {
            let constant = gameManager.getRandomXcoordinate(screenFrame: gameView.frame)

            leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: constant).isActive = true

            gameView.enemyLeadingAnchorConstant = constant
        }

    func configureEnemyImageView(imageView: UIImageView) {
        let randomImageWithFrame = gameManager.getRandomEnemy()
        imageView.image = UIImage(named: randomImageWithFrame.imageName) ?? UIImage()
        imageView.frame = randomImageWithFrame.frame
    }
}
