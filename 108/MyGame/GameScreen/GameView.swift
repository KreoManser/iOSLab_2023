//
//  AlienMasterView.swift
//  MyGame
//
//  Created by Faki Doosuur Doris on 16.11.2023.
//

import Foundation
import UIKit

class GameView: UIView, CollisionDelegate {

    lazy var spaceShip: UIImageView = UIImageView()
    lazy var aliens: [UIImageView] = [UIImageView()]
    lazy var boss: UIImageView = UIImageView()
    let playerWeapons =  [Weapon()]
    lazy var playerWeapon: UIImageView = UIImageView()
    var alienWeapons = [Weapon()]
    lazy var scoreLabel: UILabel = UILabel()
    lazy var liveCount: UILabel = UILabel()
    var animator: UIViewPropertyAnimator?
    var alienTimer: Timer?
    var gamedataManager: GameDataManager?
    var delegate: CollisionDelegate?
    var lives: Int = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
//        gamedataManager = GameDataManager.shared
//        gamedataManager?.delegate = self
        setupSpaceship()
        setupPlayerWeapon()
        setUpAliens()
        alienShoot()
        setupScoreLabel()
        setUpLiveCount()

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupSpaceship() {
        addSubview(spaceShip)
        spaceShip.image = UIImage(named: "spaceship")
        spaceShip.isUserInteractionEnabled = true
        spaceShip.alpha = 0.0
        spaceShip.frame = CGRect(x: (bounds.width - 100)/2, y: ( bounds.height - 100), width: 70, height: 40)
        UIView.animate(withDuration: 2.0) {
            self.spaceShip.alpha = 2.0
        }
    }

    private func setUpAliens() {
        let alienWidth: CGFloat = 40
        let alienHeight: CGFloat = 20
        let rows = 3
        let columns = 6

        for row in 0..<rows {
            for column in 0..<columns {
                let alien = UIImageView(image: UIImage(named: "alien"))
                addSubview(alien)
                alien.translatesAutoresizingMaskIntoConstraints = false

                NSLayoutConstraint.activate([
                    alien.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                               constant: CGFloat(row) * (alienHeight + 10) + 90),
                    alien.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                   constant: CGFloat(column) * (alienWidth + 30)),
                    alien.heightAnchor.constraint(equalToConstant: alienHeight),
                    alien.widthAnchor.constraint(equalToConstant: alienWidth)
                ])
                aliens.append(alien)
                UIView.animate(withDuration: 20.0, delay: .zero, options: .curveLinear) {
                    let initialMovement = CGAffineTransform(translationX: 0, y: 0)
                    let downMovement = CGAffineTransform(translationX: 20, y: 50)
                    let upMovement = CGAffineTransform(translationX: -20, y: 100)
                    alien.transform = initialMovement.concatenating(upMovement).concatenating(downMovement)
                }
            }
        }
    }

    @objc private func setUpAlienBullet() {
        let alienBullet = Weapon()
        if let randomAlien = aliens.randomElement() {
            addSubview(alienBullet.weapon)
            randomAlien.addSubview(alienBullet.weapon)
            alienBullet.weapon.translatesAutoresizingMaskIntoConstraints = false
            alienBullet.weapon.isHidden = false
            alienBullet.weapon.image = UIImage(named: "bullet1")
            let bottomConstraints = alienBullet.weapon.bottomAnchor.constraint(
                equalTo: randomAlien.bottomAnchor, constant: 0)
            let screenHeight = UIScreen.main.bounds.height
            let distanceToBottom = screenHeight - randomAlien.frame.maxY
            NSLayoutConstraint.activate([
                alienBullet.weapon.centerXAnchor.constraint(equalTo: randomAlien.centerXAnchor),
                bottomConstraints,
                alienBullet.weapon.widthAnchor.constraint(equalToConstant: 10),
                alienBullet.weapon.heightAnchor.constraint(equalToConstant: 10)
            ])
            alienWeapons.append(alienBullet)
            animator = UIViewPropertyAnimator(duration: 5.0, curve: .linear) {

            //    alienBullet.weapon.frame.origin.y += 100
                 bottomConstraints.constant += distanceToBottom
                 alienBullet.weapon.frame = CGRect(x: randomAlien.frame.origin.x,
                                                   y: randomAlien.frame.maxY + bottomConstraints.constant,
                                                                             width: 10, height: 10)
                let frameB = alienBullet.weapon.bounds
                print("Collision Check - SpaceShip Frame: \(self.spaceShip.frame)")
                print("Collision Check - AlienBullet Frame Origin: \(frameB.origin)")
                self.layoutIfNeeded()
                // method to check if the bullet and spaceship collide.
                if alienBullet.weapon.bounds.intersects(self.spaceShip.bounds) {
                      print("spaceship attacked")
                    // self.gamedataManager?.handleAlienCollision(bullet: alienBullet, target: self.spaceShip)
                    self.gamedataManager?.handleAlienCollision(bullet: alienBullet, target: self.spaceShip)

                } else {
                    print("sdkflsdfms;")
            }
        }
             //   animator?.startAnimation()
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    alienBullet.removeFromSuperview()
                    self.animator?.startAnimation()
            }

        }
    }

    private func alienShoot() {
        alienTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self,
                                          selector: #selector(setUpAlienBullet), userInfo: nil, repeats: true)
    }

    private func setupScoreLabel() {
        scoreLabel.text = "Score: 0"
        scoreLabel.textColor = .white
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scoreLabel)
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5),
            scoreLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ])
    }
    private func setUpLiveCount() {
        liveCount.text = "PlayerLives: 5"
        liveCount.textColor = .white
        liveCount.font = UIFont.boldSystemFont(ofSize: 18.0)
        liveCount.translatesAutoresizingMaskIntoConstraints = false
        addSubview(liveCount)
        NSLayoutConstraint.activate([
            liveCount.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 5),
            liveCount.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ])
    }
    private func setupPlayerWeapon() {
        playerWeapon.isHidden = true
    }

    func handleExplosion(at position: CGPoint, target: UIImageView) {
         target.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
         let explosionImageView = UIImageView(image: UIImage(named: "explosion"))
        explosionImageView.frame = CGRect(x: target.frame.origin.x, y: target.frame.origin.y, width: 5, height: 5)
         addSubview(explosionImageView)
        explosionImageView.transform = CGAffineTransform(translationX: 0.1, y: 0.1)
        explosionImageView.alpha = 0.7
         UIView.animate(withDuration: 1.0) {
         //    explosionImageView.transform = CGAffineTransform(translationX: 1.0, y: 1.0)
             explosionImageView.alpha = 0.0
    }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
       // target.removeFromSuperview()
        explosionImageView.removeFromSuperview()
        }
    }
//    }
//    private func randomPosition() -> CGPoint {
//        let randomX = CGFloat.random(in: 0...(bounds.width - 40))
//        let randomY = CGFloat.random(in: 0...(bounds.height - 60))
//        return CGPoint(x: randomX, y: randomY)
//    }
}
