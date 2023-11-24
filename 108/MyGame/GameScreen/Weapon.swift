//
//  PlayerWeapon.swift
//  MyGame
//
//  Created by Faki Doosuur Doris on 23.11.2023.
//

import UIKit

class Weapon: UIView {
    lazy var weapon: UIImageView = UIImageView()
    var isPlayerBullet: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpBullet()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpBullet() {
        weapon.isHidden = true
     //   weapon = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    }

}
