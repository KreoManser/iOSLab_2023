//
//  Difficulties.swift
//  MyGame(A Cat in space)
//
//  Created by Нияз Ризванов on 21.11.2023.
//


import UIKit

class Difficulties {
    static var shared = Difficulties()
    private init() {}
    func easyLevel(aliens: [CALayer], size: UIView) {
        var number = 200
        var number1 = 6
        for alien in aliens {
            number += 50
            number1 -= 1
            UIView.animate(withDuration: 2.0) {
                alien.position = CGPoint(x: Int(size.frame.width)/number1, y: Int(size.frame.height))
            }
        }
    }

}
