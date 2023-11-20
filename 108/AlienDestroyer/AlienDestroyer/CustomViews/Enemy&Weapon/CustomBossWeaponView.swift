//
//  CustomBossWeaponView.swift
//  AlienDestroyer
//
//  Created by Кирилл Щёлоков on 19.11.2023.
//

import UIKit

class CustomBossWeaponView: UIView, WeaponProtocol {
    var damage: Int = 2

    private lazy var weaponImageView: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpAnimations()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        setUpWeaponImageView()
    }

    private func setUpAnimations() {
        setUpWeaponIdleAnimation()
    }

    private func setUpWeaponImageView() {
        addSubview(weaponImageView)
        weaponImageView.image = UIImage(named: "BossWeapon1")
        weaponImageView.contentMode = .scaleAspectFill
        weaponImageView.clipsToBounds = true
        weaponImageView.translatesAutoresizingMaskIntoConstraints = false
        weaponImageView.transform = CGAffineTransform(rotationAngle: -.pi / 2)

        NSLayoutConstraint.activate([
            weaponImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            weaponImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            weaponImageView.heightAnchor.constraint(equalToConstant: 80),
            weaponImageView.widthAnchor.constraint(equalToConstant: 80)
        ])
    }

    private func setUpWeaponIdleAnimation() {

        let explosionImages = [
            "BossWeapon1",
            "BossWeapon2",
            "BossWeapon3",
            "BossWeapon4"
            ]

        let images = explosionImages.compactMap { UIImage(named: $0) }

        weaponImageView.animationImages = images
        weaponImageView.animationDuration = 0.5
        weaponImageView.animationRepeatCount = 0
        weaponImageView.startAnimating()
    }
}
