//
//  Alien.swift
//  CosmoStars
//
//  Created by Mac on 2023-11-19.
//

import UIKit

enum AlienArm: Int {
    case blaster = 3
    case fire = 7
    case meteorite = 30
}

class Alien: Hero {
    var arm: AlienArm = .blaster
    var alienObject: UIView?

    override init(_ type: HeroType) {
        super.init(type)

        isUser = false
        switch type {
        case .noob:
            arm = AlienArm.blaster
            image = UIImageView(image: UIImage(named: "noob"))
        case .junior:
            arm = AlienArm.blaster
            image = UIImageView(image: UIImage(named: "junior"))
        case .middle:
            arm = AlienArm.fire
            image = UIImageView(image: UIImage(named: "middle"))
        case .senior:
            arm = AlienArm.meteorite
            image = UIImageView(image: UIImage(named: "boss"))
        }
        damage *= arm.rawValue
        alienObject = image
    }
    func createAmountOfAliens(type: HeroType, amount: Int) -> [Alien] {
        var aliens: [Alien] = []
        for _ in 1...amount {
            let alien = Alien(type)
            aliens.append(alien)
        }
        return aliens
    }
    func upgradeArm() {
        switch self.arm {
        case .blaster:
            self.arm = .fire
        case .fire:
            self.arm = .meteorite
        case .meteorite:
            self.amountOfMissiles += 1
        }
        self.damage = self.amountOfMissiles * self.arm.rawValue
    }
    override func upgradeHero() {
        super.upgradeHero()
        if self.type == .senior {
            upgradeArm()
        }
    }
}
