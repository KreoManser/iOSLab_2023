//
//  AlienMasterDataManager.swift
//  MyGame
//
//  Created by Faki Doosuur Doris on 16.11.2023.
//

import Foundation
import UIKit

class GameDataManager {
    static let shared = GameDataManager()
    var gameView: GameView?
    var spaceship: Spaceship
    var aliens: [Aliens] = []
    var bullets: [BulletView] = []
    var bulletTimer: Timer?
    var animator: UIViewPropertyAnimator?
    @objc var didTapSpaceship: ((_ alien: UIImageView) -> Void)?

    init() {
        self.spaceship = Spaceship(weaponPower: 5, liveCount: 5)
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] _  in
                self?.shootAtSpaceship()
        }
    }


    func shootBullets() {
        self.gameView?.bulletView.isHidden = false
        self.gameView?.bulletView.frame.origin = CGPoint(x: (gameView?.spaceshipView.frame.midX)! - (gameView?.bulletView.frame.width)!, y: (gameView?.spaceshipView.frame.minY)!)
        UIImageView.animate(withDuration: 1.0) {
            self.gameView?.bulletView.frame.origin.y -= 50
        } completion: { isFinished in
            guard isFinished else {return}
            self.gameView?.bulletView.isHidden = true
            self.gameView?.bulletView.frame.origin = CGPoint(x: 0, y: 0)
        }
    }

    func bulletHitTarget() -> Bool {
        guard let bullet = gameView?.bulletView, let aliens = gameView?.aliensView else { return false }
            if bullet.frame.intersects(aliens.frame) {
                return true
            }
        return false
    }
    
    func killAlien(_ alien: AliensView) {
        if bulletHitTarget() {
            UIImageView.animate(withDuration: 1.0) {
                alien.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                alien.alpha = 0.0
            } completion: { isFinished in
                guard isFinished else {return}
                alien.removeFromSuperview()
            }
        }
    }

    func dodgeBullets() {

    }
    func shootAtSpaceship() {
        gameView?.onCollision = { [weak self] in
            guard let self = self else { return }
            for bullet in self.bullets {
                if let spaceshipFrame = gameView?.spaceshipView.frame, bullet.frame.intersects(spaceshipFrame) {
                    self.spaceship.health -= 1
                    print("Spaceship attched! : \(spaceship.health)")
                }
            }
        }
    }
}
