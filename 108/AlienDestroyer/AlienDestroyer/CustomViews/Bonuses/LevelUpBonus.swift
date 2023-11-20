//
//  LevelUpBonus.swift
//  AlienDestroyer
//
//  Created by Кирилл Щёлоков on 20.11.2023.
//

import UIKit

class LevelUpBonus: UIView, BonusProtocol {
    var atackSpeedScale: Double = 1.5
    var damageScale: Double = 1.5
    var healthScale: Double = 1

    private lazy var bonusImageView: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpAnimations()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        setUpBonusImageView()
    }

    private func setUpAnimations() {
        setUpBonusIdleAnimation()
    }

    private func setUpBonusImageView() {
        addSubview(bonusImageView)
        bonusImageView.image = UIImage(named: "LevelUpImage")
        bonusImageView.contentMode = .scaleAspectFill
        bonusImageView.clipsToBounds = true
        bonusImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            bonusImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            bonusImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            bonusImageView.heightAnchor.constraint(equalToConstant: 30),
            bonusImageView.widthAnchor.constraint(equalToConstant: 19)
        ])
    }

    private func setUpBonusIdleAnimation() {
        UIView.animate(withDuration: 1, delay: .zero, options: [.curveLinear, .autoreverse], animations: { [weak self] in
            self?.bonusImageView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        })
    }

}
