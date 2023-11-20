//
//  CustomBulletView.swift
//  AlienDestroyer
//
//  Created by Кирилл Щёлоков on 20.11.2023.
//

import UIKit

class CustomBulletView: UIView, WeaponProtocol {
    var damage: Int = 1

    private lazy var bulletImageView: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpAnimations()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        setUpBulletImageView()
    }

    private func setUpAnimations() {
        setUpBulletIdleAnimation()
    }

    private func setUpBulletImageView() {
        addSubview(bulletImageView)
        bulletImageView.image = UIImage(named: "BulletImage1")
        bulletImageView.contentMode = .scaleAspectFill
        bulletImageView.clipsToBounds = true
        bulletImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            bulletImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            bulletImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            bulletImageView.heightAnchor.constraint(equalToConstant: 48),
            bulletImageView.widthAnchor.constraint(equalToConstant: 48)
        ])
    }

    private func setUpBulletIdleAnimation() {

        let explosionImages = [
            "BulletImage1",
            "BulletImage2",
            "BulletImage3",
            "BulletImage4"
            ]

        let images = explosionImages.compactMap { UIImage(named: $0) }

        bulletImageView.animationImages = images
        bulletImageView.animationDuration = 0.5
        bulletImageView.animationRepeatCount = 0
        bulletImageView.startAnimating()
    }

}
