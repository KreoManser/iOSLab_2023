//
//  AlienMasterView.swift
//  MyGame
//
//  Created by Faki Doosuur Doris on 16.11.2023.
//

import Foundation
import UIKit

class GameView: UIView {
    let spaceshipView = SpaceshipView()
    let aliensView = AliensView()
    var aliens = [Aliens]()
    let bulletView = BulletView()
    lazy var backgroundImage: UIImageView = UIImageView(frame: UIScreen.main.bounds)
    lazy var scoreLabel: UILabel = UILabel()
    lazy var liveCount: UILabel = UILabel()
    var onCollision: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpBackground()
        setupSpaceship()
        setupAliens()
        setupScoreLabel()
        setUpLiveCount()
        moveToSpaceship(spaceshipView)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupSpaceship() {
        addSubview(spaceshipView)
        spaceshipView.frame.origin = randomPosition()
        spaceshipView.alpha = 0.0
        spaceshipView.frame = CGRect(x: (bounds.width - 100)/2, y: ( bounds.height - 100)/2, width: 150, height: 150)
        spaceshipView.alpha = 2.0
        UIView.animate(withDuration: 1) {
        }
    }
    private func setupAliens() {
//        addSubview(aliensView)
//        aliensView.frame.origin = randomPosition()
//        aliensView.alpha = 0.0
//        UIView.animate(withDuration: 2) {
//            self.aliensView.alpha = 1.0
//        }
        for alien in 0 ..< 5 {
            let alien = Aliens(position: randomPosition(), speed: 5.0, attackPower: Int(2.0), lifeCount: 5)
            aliens.append(alien)
            let alienView = AliensView()
            addSubview(alienView)
            alienView.frame.origin = alien.position
            alienView.alpha = 0.0
            UIView.animate(withDuration: 5) {
                alienView.alpha
            }

        }
    }
    private func setupBullet() {
        addSubview(bulletView)
    }
    private func setUpBackground() {
        backgroundImage.image = UIImage(named: "spacebackground")
        backgroundImage.contentMode = .scaleAspectFill
        addSubview(backgroundImage)

    }

    private func setupScoreLabel() {
        scoreLabel.text = "Score: 0"
        scoreLabel.textColor = .white
        scoreLabel.font = UIFont.systemFont(ofSize: 15)
        scoreLabel.frame = CGRect(x: bounds.midX - scoreLabel.bounds.width / 2,
                                  y: 20, width: scoreLabel.bounds.width, height: scoreLabel.bounds.height)
        addSubview(scoreLabel)

    }
    private func setUpLiveCount() {
        liveCount.text = "Lives: 5"
        liveCount.textColor = .white
        liveCount.font = UIFont.systemFont(ofSize: 15)
        liveCount.frame = CGRect(x: 20, y: 20, width: liveCount.bounds.width, height: liveCount.bounds.height)
        addSubview(liveCount)
    }
    private func randomPosition() -> CGPoint {
        let randomX = CGFloat.random(in: 0...(bounds.width - 40))
        let randomY = CGFloat.random(in: 0...(bounds.height - 60))
        return CGPoint(x: randomX, y: randomY)
    }
    func moveToSpaceship(_ spaceship: SpaceshipView) {
        UIImageView.animate(withDuration: 3.0) {
            self.bulletView.frame.origin.y -= 50
        }
        if bulletView.frame.origin.y > UIScreen.main.bounds.height {
            bulletView.removeFromSuperview()
        }
    }
}
