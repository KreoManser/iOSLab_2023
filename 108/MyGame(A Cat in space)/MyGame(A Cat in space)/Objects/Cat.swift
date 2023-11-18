//
//  Cat.swift
//  MyGame(A Cat in space)
//
//  Created by Нияз Ризванов on 16.11.2023.
//

import Foundation

struct Cat {
    var position: CGPoint
    var health: Int
    var damage: Int

    init(position: CGPoint, health: Int, damage: Int) {
        self.position = position
        self.health = health
        self.damage = damage
    }

    // Дополнительные методы для управления кошкой
}
