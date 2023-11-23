//
//  Plane.swift
//  108_Tukaev
//
//  Created by surexnx on 19.11.2023.
//

import Foundation
import UIKit

class Plane {
    var id: UUID
    var speed: CGFloat
    var planeHp: Int
    var damage: Int
    var lives: Int
    var view: UIImageView

    init(speed: CGFloat, damage: Int, lives: Int, imageName: String) {
        self.id = UUID()
        self.speed = speed
        self.planeHp = 10
        self.damage = damage
        self.lives = lives
        self.view = UIImageView(image: UIImage(named: imageName))
        view.frame = CGRect(x: 30, y: UIScreen.main.bounds.size.height - 100, width: 50, height: 50)
    }

    func takeDamage() {
        planeHp -= 10
        if planeHp <= 0 {
            view.removeFromSuperview()
        }
    }
}
