//
//  BulletView.swift
//  MyGame
//
//  Created by Faki Doosuur Doris on 18.11.2023.
//

import UIKit

class BulletView: UIView {
    lazy var bullet: UIImageView = UIImageView()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpBullet()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpBullet() {
        bullet.image = UIImage(named: "bullet1")
        bullet.frame =  CGRect(x: 0, y: 0, width: 10, height: 20)
        bullet.isHidden = true
        addSubview(bullet)
    }

}
