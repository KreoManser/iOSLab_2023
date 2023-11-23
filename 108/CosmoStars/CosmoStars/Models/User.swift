//
//  User.swift
//  CosmoStars
//
//  Created by Mac on 2023-11-19.
//

import UIKit

enum UserArm: Int {
    case blaster = 4
    case fire = 10
    case galaxy = 20
}

class User: Hero {
    var arm: UserArm = .blaster

    override init(_ type: HeroType) {
        super.init(type)
        switch type {
        case .noob:
            arm = .blaster
        case .junior:
            arm = .fire
        case .middle:
            arm = .galaxy
        case .senior:
            arm = .galaxy
        }
        health += 20
        image = UIImageView(image: UIImage(named: "user"))
        isUser = true
        damage *= arm.rawValue
    }

    override func upgradeHero() {
        super.upgradeHero()
        if self.type == .senior {
            upgradeArm()
        }
    }
    func upgradeArm() {
        switch self.arm {
        case .blaster:
            self.arm = .fire
        case .fire:
            self.arm = .galaxy
        case .galaxy:
            self.amountOfMissiles += 1
        }
        self.damage = self.amountOfMissiles * self.arm.rawValue
    }
}
