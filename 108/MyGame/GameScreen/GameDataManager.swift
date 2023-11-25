//
//  AlienMasterDataManager.swift
//  MyGame
//
//  Created by Faki Doosuur Doris on 16.11.2023.
//

import Foundation
import UIKit

protocol CollisionDelegate: AnyObject {
    func handleExplosion(at position: CGPoint, target: UIImageView)
}

class GameDataManager {
    static let shared = GameDataManager()
    var gameView: GameView?
    var weapon: Weapon?
    var delegate: CollisionDelegate?
    var alienTimer: Timer?
    var bulletTimer: Timer?
    var lives: Int = 5
    var score: Int = 0

    init () {
    }

//    for animator in alienAnimators {
//            animator.pause() // or .stopAnimation(true) if you want to stop immediately
//        }
    func handleSpacecollision(bullet: Weapon, target: UIImageView) {
        print("an alien was shot")
         if target == gameView?.spaceShip {
             score += 5
              gameView?.scoreLabel.text = "Score: \(score)"
             delegate?.handleExplosion(at: target.center, target: target)
             bullet.removeFromSuperview()
             target.removeFromSuperview()
         }
    }

    func handleAlienCollision(bullet: Weapon, target: UIImageView) {
        print("spaceship was attacked")
        lives -= 1
        gameView?.liveCount.text = "Player'sHealth: \(lives)"
       delegate?.handleExplosion(at: target.center, target: target)
       bullet.removeFromSuperview()
       target.removeFromSuperview()
    }
}
