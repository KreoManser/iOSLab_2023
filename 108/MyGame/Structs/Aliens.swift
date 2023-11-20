//
//  Aliens.swift
//  MyGame
//
//  Created by Faki Doosuur Doris on 18.11.2023.
//

import Foundation

class Aliens {
    var position: CGPoint
    var speed: CGFloat
    var attackPower: Int
    var lifeCount: Int

    init(position: CGPoint, speed: CGFloat, attackPower: Int, lifeCount: Int) {
        self.position = position
        self.speed = speed
        self.attackPower = attackPower
        self.lifeCount = lifeCount
    }
    
}
