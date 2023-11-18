//
//  Projectile.swift
//  MyGame(A Cat in space)
//
//  Created by Нияз Ризванов on 16.11.2023.
//

import Foundation

struct Projectile {
    var position: CGPoint
    var speed: CGFloat
    var damage: Int

    init(position: CGPoint, speed: CGFloat, damage: Int) {
        self.position = position
        self.speed = speed
        self.damage = damage
    }

    // Дополнительные методы для управления снарядами
}
