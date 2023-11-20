//
//  SpaceshipView.swift
//  MyGame
//
//  Created by Faki Doosuur Doris on 18.11.2023.
//

import UIKit

class SpaceshipView: UIView {

    lazy var spaceShip: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSpaceShip()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpSpaceShip() {
        let spaceshipImage = UIImage(named: "spaceship4")
        spaceShip = UIImageView(image: spaceshipImage)
        spaceShip.frame = CGRect(x: (bounds.width - 100)/2, y: ( bounds.height - 100)/2, width: 150, height: 150)
        spaceShip.isUserInteractionEnabled = true
        addSubview(spaceShip)
    }
}
