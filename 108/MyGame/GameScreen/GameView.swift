//
//  AlienMasterView.swift
//  MyGame
//
//  Created by Faki Doosuur Doris on 16.11.2023.
//

import Foundation
import UIKit

class GameView: UIView {

    lazy var spaceShip: UIImageView = UIImageView()
    lazy var aliens: [UIImageView] = [UIImageView()]
    lazy var boss: UIImageView = UIImageView()
    var playerWeapons =  [Weapon()]
    var alienWeapons = [Weapon()]
    lazy var scoreLabel: UILabel = UILabel()
    lazy var liveCount: UILabel = UILabel()
    var animator: UIViewPropertyAnimator?
    var alienTimer: Timer?
    var collisionTimer: Timer?
    var alienCollision: Timer?
    var gamedataManager: GameDataManager?
    var delegate: CollisionDelegate?
    var score: Int = 0
    var lives: Int = 5
    var spaceshipCenterx: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSpaceship()
        setUpAliens()
        alienShoot()
        checkCollisontimer()
        setupScoreLabel()
        setUpLiveCount()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupSpaceship() {
        addSubview(spaceShip)
        spaceShip.image = UIImage(named: "spaceship")
        spaceShip.translatesAutoresizingMaskIntoConstraints = false
        spaceShip.isUserInteractionEnabled = true
        spaceShip.alpha = 0.0
        spaceshipCenterx = spaceShip.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        spaceshipCenterx?.isActive = true
        NSLayoutConstraint.activate([
            spaceShip.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            spaceShip.widthAnchor.constraint(equalToConstant: 40),
            spaceShip.heightAnchor.constraint(equalToConstant: 40)
        ])
        UIView.animate(withDuration: 2.0) {
            self.spaceShip.alpha = 2.0
        }
    }
     func setupSpaceshipWeapon() {
        let playerWeapon = Weapon()
            addSubview(playerWeapon.weapon)
            playerWeapon.weapon.translatesAutoresizingMaskIntoConstraints = false
            playerWeapon.weapon.isHidden = false
            playerWeapon.weapon.image = UIImage(named: "bullet2")
            playerWeapon.isPlayerBullet = true
            NSLayoutConstraint.activate([
                playerWeapon.weapon.centerXAnchor.constraint(equalTo: (spaceShip.centerXAnchor)),
                playerWeapon.weapon.widthAnchor.constraint(equalToConstant: 10),
                playerWeapon.weapon.heightAnchor.constraint(equalToConstant: 10)
            ])
         playerWeapons.append(playerWeapon)

        animator = UIViewPropertyAnimator(duration: 2.0, curve: .linear) {
            playerWeapon.weapon.center.y -= 800

        }
         animator?.addCompletion { [weak self] isFinished in
                guard isFinished == .end, let self = self  else {
                    print("no aliens found")
                    return
                }
                playerWeapon.weapon.removeFromSuperview()
                if let index = self.playerWeapons.firstIndex(of: playerWeapon) {
                    self.playerWeapons.remove(at: index)
                }
            }
         animator?.startAnimation()
     }

    @objc private func checkCollision() {
        for enemy in self.aliens {
            for playerWeapon in playerWeapons {
                if let bulletPresentationFrame = playerWeapon.weapon.layer.presentation()?.frame,
                   let alienPresentationFrame = enemy.layer.presentation()?.frame {
                    if bulletPresentationFrame.intersects(alienPresentationFrame) {
                        print("Collision detected!")
                        enemy.layer.removeAllAnimations()
                        playerWeapon.weapon.layer.removeAllAnimations()
                        self.handleCollision(enemy: enemy, weapon: playerWeapon.weapon)
                        break
                    } else {
                       print("No detection")
                }
            }
        }
    }
}
    private func checkCollisontimer() {
        collisionTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self,
                                              selector: #selector(checkCollision), userInfo: nil, repeats: true)

    }

    private func setUpAliens() {
        let alienWidth: CGFloat = 40
        let alienHeight: CGFloat = 20
        let rows = 3
        let columns = 5

        for row in 0..<rows {
            for column in 0..<columns {
                let alien = UIImageView(image: UIImage(named: "alien"))
                addSubview(alien)
                alien.translatesAutoresizingMaskIntoConstraints = false

                NSLayoutConstraint.activate([
                    alien.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                               constant: CGFloat(row) * (alienHeight + 10) + 70),
                    alien.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                   constant: CGFloat(column) * (alienWidth + 20) + 50),
                    alien.heightAnchor.constraint(equalToConstant: alienHeight),
                    alien.widthAnchor.constraint(equalToConstant: alienWidth)
                ])
                aliens.append(alien)
                UIView.animate(withDuration: 20.0, delay: .zero, options: [.repeat, .autoreverse]) {
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
            if alienBullet.weapon.superview == nil {
                alienBullet.weapon.translatesAutoresizingMaskIntoConstraints = false
                alienBullet.weapon.isHidden = false
                alienBullet.weapon.image = UIImage(named: "bullet1")
                if let firingAlien = aliens.randomElement() {
                    firingAlien.addSubview(alienBullet.weapon)
                    NSLayoutConstraint.activate([
                      alienBullet.weapon.centerXAnchor.constraint(equalTo: firingAlien.centerXAnchor),
                      alienBullet.weapon.widthAnchor.constraint(equalToConstant: 10),
                      alienBullet.weapon.heightAnchor.constraint(equalToConstant: 10)
                ])
                    alienWeapons.append(alienBullet)

                    UIView.animate(withDuration: 2.0) {
                        alienBullet.weapon.transform = CGAffineTransform(translationX: 0, y: 800)
                        self.layoutIfNeeded()
                    } completion: { isfinished in
                        guard isfinished else { return }

                        alienBullet.weapon.removeFromSuperview()
                        if let index = self.alienWeapons.firstIndex(of: alienBullet) {
                            self.alienWeapons.remove(at: index)
                        }
                    }
                }
            }
    }

    private func alienShoot() {
        alienTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                          selector: #selector(setUpAlienBullet), userInfo: nil, repeats: true)
        checkAlienCollisiontimer()
    }
    @objc private func checkAlienCollision() {
        DispatchQueue.main.async {
                if let spaceshipFrame = self.spaceShip.layer.presentation()?.frame {
                    for weapon in self.alienWeapons {
                        if let bulletFrame = weapon.weapon.layer.presentation()?.frame {
                            if bulletFrame.intersects(spaceshipFrame) {
                                weapon.weapon.layer.removeAllAnimations()
                                self.handleCollision2(enemy: self.spaceShip, weapon: weapon.weapon)
                                if let index = self.alienWeapons.firstIndex(of: weapon) {
                                    self.alienWeapons.remove(at: index)
                                }
                            }
                        }
                    }
                }
            }
    }
    private func checkAlienCollisiontimer() {
        alienCollision = Timer.scheduledTimer(timeInterval: 0.2, target: self,
                                              selector: #selector(checkAlienCollision), userInfo: nil, repeats: true)
        print("Collision timer started")
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

    private func handleCollision(enemy: UIImageView, weapon: UIImageView) {
        self.score += 5
        self.scoreLabel.text = "Score: \(self.score)"
        if let index = self.aliens.firstIndex(of: enemy) {
            self.aliens.remove(at: index)
        }
        UIView.animate(withDuration: 0.5) {
            enemy.image = UIImage(named: "explosion")
            enemy.alpha = 0.0
        } completion: { isFinished in
            guard isFinished else {return}
            enemy.removeFromSuperview()
        }
        weapon.removeFromSuperview()
    }
    private func handleCollision2(enemy: UIImageView, weapon: UIImageView) {
        self.lives -= 1
        self.liveCount.text = "PlayerLives: \(self.lives)"
        if let index = self.aliens.firstIndex(of: enemy) {
            self.aliens.remove(at: index)
        }
        UIView.animate(withDuration: 0.5, animations: {
            enemy.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
    }) { _ in 
        }
        weapon.removeFromSuperview()
    }
}
