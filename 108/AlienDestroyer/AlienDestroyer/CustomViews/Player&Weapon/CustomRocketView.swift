//
//  CustomBulletView.swift
//  AlienDestroyer
//
//  Created by Кирилл Щёлоков on 17.11.2023.
//

import UIKit

class CustomRocketView: UIView, WeaponProtocol {
    var damage: Int = 1

    private lazy var rocketImageView: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpAnimations()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        setUpRocketImageView()
    }

    private func setUpAnimations() {
        setUpRocketIdleAnimation()
    }

    private func setUpRocketImageView() {
        addSubview(rocketImageView)
        rocketImageView.image = UIImage(named: "rocket0")
        rocketImageView.contentMode = .scaleAspectFill
        rocketImageView.clipsToBounds = true
        rocketImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            rocketImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            rocketImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            rocketImageView.heightAnchor.constraint(equalToConstant: 48),
            rocketImageView.widthAnchor.constraint(equalToConstant: 48)
        ])
    }

    private func setUpRocketIdleAnimation() {
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .linear) { [weak self] in
            self?.rocketImageView.image = UIImage(named: "rocket0")
        }
        animator.addCompletion { [weak self] _ in
            let animator2 = UIViewPropertyAnimator(duration: 0.3, curve: .linear) { [weak self] in
                self?.rocketImageView.image = UIImage(named: "rocket1")
            }
            animator2.addCompletion { [weak self] _ in
                let animator3 = UIViewPropertyAnimator(duration: 0.3, curve: .linear) { [weak self] in
                    self?.rocketImageView.image = UIImage(named: "rocket2")
                }
                animator3.addCompletion { [weak self] _ in
                    self?.setUpRocketIdleAnimation()
                }
                animator3.startAnimation()
            }
            animator2.startAnimation()
        }

        animator.startAnimation()
    }
}
