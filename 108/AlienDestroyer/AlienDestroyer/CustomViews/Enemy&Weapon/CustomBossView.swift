//
//  CustomBossView.swift
//  AlienDestroyer
//
//  Created by Кирилл Щёлоков on 19.11.2023.
//

import UIKit

class CustomBossView: UIView, EntityProtocol {
    var health: Int = 5
    var atackSpeed: Double = 1.5

    private lazy var bossImageView: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        setUpAlienImageView()
    }

    private func setUpAlienImageView() {
        addSubview(bossImageView)
        bossImageView.image = UIImage(named: "bossexp")
        bossImageView.contentMode = .scaleAspectFit
        bossImageView.clipsToBounds = true
        bossImageView.translatesAutoresizingMaskIntoConstraints = false
        bossImageView.transform = CGAffineTransform(rotationAngle: .pi / 2)

        NSLayoutConstraint.activate([
            bossImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            bossImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            bossImageView.heightAnchor.constraint(equalToConstant: 80),
            bossImageView.widthAnchor.constraint(equalToConstant: 128)
        ])
    }

}
