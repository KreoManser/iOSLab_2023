//
//  File.swift
//  CosmoStars
//
//  Created by Mac on 2023-11-19.
//

import UIKit

enum HeroType {
    case noob
    case junior
    case middle
    case senior
}

class Hero {
    var health: Double
    var image: UIImageView = UIImageView()
    var amountOfMissiles: Int
    var type: HeroType
    var damage: Int

    init(_ type: HeroType) {
        switch type {
        case .noob:
            health = 10
            amountOfMissiles = 1
        case .junior:
            health = 20
            amountOfMissiles = 3
        case .middle:
            health = 50
            amountOfMissiles = 1
        case .senior:
            health = 250
            amountOfMissiles = 1
        }

        self.type = type
        damage = amountOfMissiles
    }

    func upgradeHealth() {
        self.health *= 1.5
    }
    func upgradeHero() {
        switch self.type {
        case .noob:
            self.type = .junior
        case .junior:
            self.type = .middle
        case .middle:
            self.type = .senior
        case .senior:
            self.upgradeHealth()
        }
    }
}
