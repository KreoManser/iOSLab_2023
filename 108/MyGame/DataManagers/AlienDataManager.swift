//
//  AlienDataManager.swift
//  MyGame
//
//  Created by Faki Doosuur Doris on 20.11.2023.
//

import Foundation
class AlienDataManager {
    static let shared = AlienDataManager()
    var aliens: Aliens?
    var gameView: GameView?

    func shootAtSpaceship() {

    }
    func move() {
        aliens?.position.y += aliens!.speed
    }
    func attackSpaceship() -> Bullet {
        let bullet = Bullet(position: aliens!.position , power: aliens!.attackPower)
        return bullet
    }
}
