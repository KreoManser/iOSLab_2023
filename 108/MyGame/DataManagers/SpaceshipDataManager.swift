//
//  SpaceshipDataManager.swift
//  MyGame
//
//  Created by Faki Doosuur Doris on 20.11.2023.
//

import Foundation

class SpaceshipDataManager {
    static let shared = SpaceshipDataManager()
    var gameView: GameView?
    var spacehsip: Spaceship?

    func moveleft() {

    }
    func moveRight() {

    }
    func shoot() -> Bullet {
     let bullet = Bullet(position: <#T##CGPoint#>, power: 2)
        SpaceshipView.animate(withDuration: 1.0) {
            let bullet2 = Bullet(position: <#T##CGPoint#>, power: 5)
        }
    }
    func isAlive() -> Bool {
        return spacehsip!.liveCount < 0
    }
}
