//
//  User.swift
//  CosmoStars
//
//  Created by Mac on 2023-11-19.
//

import UIKit

enum UserArm: Int {
    case blaster = 2
    case fire = 10
    case galaxy = 26
}

class User: Hero {
    private var arm: UserArm = .blaster

    override init(_ type: HeroType) {
        super.init(type)
        image = UIImageView(image: UIImage(named: "user"))

        switch type {
        case .noob:
            arm = .blaster
        case .junior:
            arm = .blaster
        case .middle:
            arm = .fire
        case .senior:
            arm = .galaxy
        }
        damage *= arm.rawValue
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
    override func upgradeHero() {
        super.upgradeHero()
        if self.type == .senior {
            upgradeArm()
        }
    }
}
