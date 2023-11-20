//
//  ViewController.swift
//  HW_108
//
//  Created by Азат Зиганшин on 18.11.2023.
//

import UIKit

class GameViewController: UIViewController {

    let gameView = GameView()
    var bulletTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(gameView)
        gameView.frame = view.bounds
        gameView.panHandler = handlePan

        bulletTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(shoot), userInfo: nil, repeats: true)

    }

    func handlePan(_ gesture: UIPanGestureRecognizer) {

        let translation = gesture.translation(in: view)

        UIView.animate(withDuration: 0.1) {
            self.gameView.spaceshipImageView.center.x += translation.x
        }

        gesture.setTranslation(.zero, in: view)

        let minX = gameView.spaceshipImageView.bounds.width / 2
        let maxX = view.bounds.width - minX

        UIView.animate(withDuration: 0.3) {
            self.gameView.spaceshipImageView.center.x = max(minX, min(maxX, self.gameView.spaceshipImageView.center.x))
        }
    }

    @objc func shoot() {

        let spaceshipCenterX = gameView.spaceshipImageView.center.x

        let bulletImageView = UIImageView(image: UIImage(named: "bullet"))
        // bulletImageView.backgroundColor = .purple
        bulletImageView.frame = CGRect(x: spaceshipCenterX - 10, y: gameView.spaceshipImageView.frame.minY - 70, width: 20, height: 70)
        view.addSubview(bulletImageView)

        UIView.animate(withDuration: 1) {

            bulletImageView.frame.origin.y = 0
        } completion: { isFinished in
            guard isFinished else { return }

            self.checkCollisions(bullet: bulletImageView)
            bulletImageView.removeFromSuperview()
        }
    }

    func checkCollisions(bullet: UIView) {
        for alien in gameView.aliens {
            if alien.isAlive && bullet.frame.intersects(alien.view.frame) {

                UIView.animate(withDuration: 0.5) {

                    let transformAngle = CGAffineTransform(rotationAngle: .pi)
                    let transformSize = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    let transform = transformAngle.concatenating(transformSize)
                    alien.view.transform = transform

                } completion: { isFinished in
                    guard isFinished else { return }

                    alien.isAlive = false
                    alien.view.isHidden = true
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.respawnAlien(alien: alien)
                }
            }
        }
    }

    func respawnAlien(alien: Alien) {

        UIView.animate(withDuration: 0.3) {
            alien.view.transform = .identity

        }
        alien.isAlive = true
        alien.view.isHidden = false
    }
}

