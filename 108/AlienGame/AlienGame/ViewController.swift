//
//  ViewController.swift
//  AlienGame
//
//  Created by Аделя Миннехузина on 02.12.2023.
//

import UIKit

class ViewController: UIViewController {

    private lazy var gameView = GameView(frame: .zero)
    private var playersScore = 0
    private var playersHealth = 3
    private var enemies = ["Enemy1", "Enemy2", "Enemy3"]

    override func loadView() {
        view = gameView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        gameView.gameViewController = self
    }

    func getRandomXPosition(screenBounds: CGRect) -> CGFloat {
        CGFloat.random(in: 40..<screenBounds.width - 50)
    }

    func getRandomEnemy() -> String {
        let index = Int.random(in: 0..<enemies.count)
        return enemies[index]
    }

    func increaseScore() -> Int {
        playersScore += 1
        return getCurScore()
    }

    func increaseScore(scoreLabel: UILabel) {
        scoreLabel.text = "\(increaseScore())"
    }

    func decreaseHealth() {
        playersHealth -= 1
    }

    func getCurScore() -> Int {
        playersScore
    }

    func getCurHealth() -> Int {
        playersHealth
    }

    func configureEnemy(enemyImageView: UIImageView) {
        let enemy = getRandomEnemy()
        enemyImageView.image = UIImage(named: enemy) ?? UIImage()
    }

    func checkGame() {
        if getCurHealth() <= 0 {
            gameView.showMenu()
            restartGame()
        }
    }

    func restartGame() {
        playersScore = 0
        playersHealth = 3
    }

}

