//
//  Alien.swift
//  MyGame(A Cat in space)
//
//  Created by Нияз Ризванов on 16.11.2023.
//

import UIKit

struct Alien {
    var health: Int
    var damage: Int
    var layer: CALayer = CALayer()

    init(position: CGPoint, health: Int, damage: Int, image: UIImage?, size: CGRect) {
        self.health = health
        self.damage = damage
        self.layer.contents = image?.cgImage
        self.layer.position = position
        self.layer.bounds = size
    }

    // Дополнительные методы для управления пришельцами
}
