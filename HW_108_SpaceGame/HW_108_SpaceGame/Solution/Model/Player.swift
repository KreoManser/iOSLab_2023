//
//  Player.swift
//  HW_108_SpaceGame
//
//  Created by Артур Миннушин on 20.11.2023.
//

import Foundation
import UIKit

enum LevelPlayer {
    case level1
    case level2
    case level3
    case level4
}

class Player {
    static let sigelton = Player()
    var shipImageView: UIImageView = UIImageView()
    var damage: Int = 0
    var shipLevel: LevelPlayer = .level1
    var heatPoint: Int = 0
    var totalCredit: Int = 10000
    init() {
        switch shipLevel {
        case .level1:
            damage = 1
            heatPoint = 10
            shipImageView = UIImageView(image: UIImage(named: "StarShip1"))
        case .level2:
            damage = 15
            heatPoint = 2
            shipImageView = UIImageView(image: UIImage(named: "StarShip2"))
        case .level3:
            damage = 20
            heatPoint = 3
            shipImageView = UIImageView(image: UIImage(named: "StarShip3"))
        case .level4:
            damage = 25
            heatPoint = 4
            shipImageView = UIImageView(image: UIImage(named: "StarShip4"))
        }
    }
    func upgradePlayer(level: LevelPlayer) {
        shipLevel = level
        setupPlayer()
    }
    func getCredits() -> Int {
        return totalCredit
    }
    func setCredits(credits: Int) {
        totalCredit = credits
    }
    func setupPlayer() {
        switch shipLevel {
        case .level1:
            damage = 1
            heatPoint = 10
            shipImageView = UIImageView(image: UIImage(named: "StarShip1"))
        case .level2:
            damage = 15
            heatPoint = 2
            shipImageView = UIImageView(image: UIImage(named: "StarShip2"))
        case .level3:
            damage = 20
            heatPoint = 3
            shipImageView = UIImageView(image: UIImage(named: "StarShip3"))
        case .level4:
            damage = 25
            heatPoint = 4
            shipImageView = UIImageView(image: UIImage(named: "StarShip4"))
        }
    }
}
