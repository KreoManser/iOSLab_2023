//
//  CustopEnemyWeapon.swift
//  AlienDestroyer
//
//  Created by Кирилл Щёлоков on 19.11.2023.
//

import UIKit

class CustomEnemyWeaponView: UIView, WeaponProtocol {
    var damage: Int = 1

    private lazy var weaponImageView: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        setUpRocketImageView()
    }

    private func setUpRocketImageView() {
        addSubview(weaponImageView)
        weaponImageView.image = UIImage(named: "EnemyWeapon")
        weaponImageView.contentMode = .scaleAspectFill
        weaponImageView.clipsToBounds = true
        weaponImageView.translatesAutoresizingMaskIntoConstraints = false
        weaponImageView.transform = CGAffineTransform(rotationAngle: .pi)

        NSLayoutConstraint.activate([
            weaponImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            weaponImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            weaponImageView.heightAnchor.constraint(equalToConstant: 20),
            weaponImageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
}
