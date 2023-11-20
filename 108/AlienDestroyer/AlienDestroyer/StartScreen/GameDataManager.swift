//
//  GameDataManager.swift
//  AlienDestroyer
//
//  Created by Кирилл Щёлоков on 17.11.2023.
//

import Foundation
import UIKit

class GameDataManager: GameViewDelegate {

    func minusHealth(for view: EntityProtocol, from weapon: WeaponProtocol) -> Int {
        var entityView = view
        entityView.health -= weapon.damage
        return entityView.health
    }

    func increaseScore(score: String) -> String {
        return "\((Int(score) ?? 0) + 1)"
    }

    func setBestScore(score: String) {
        if Int(getScore()) ?? 0 < Int(score) ?? 0 {
            UserDefaults.standard.set(score, forKey: "score")
        }
    }

    func getScore() -> String {
        return UserDefaults.standard.string(forKey: "score") ?? "0"
    }

    func getDiff(diffIndex: Int) -> (spawnSpeed: Double, enemyAttackSpeed: Double) {
        switch diffIndex {
        case 1:
            return (2.5, 1.5)
        case 2:
            return (2, 1.25)
        default:
            return (3, 2)
        }
    }
}
