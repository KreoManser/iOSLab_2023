//
//  Bullet.swift
//  MyGame
//
//  Created by Faki Doosuur Doris on 20.11.2023.
//

import Foundation

class Bullet {
    var position: CGPoint
    var power: Int

    init(position: CGPoint, power: Int) {
        self.position = position
        self.power = power
    }

    func move() {
        position.y -= 15
    }

}
