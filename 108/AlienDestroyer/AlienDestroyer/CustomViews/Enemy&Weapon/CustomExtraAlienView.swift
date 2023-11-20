//
//  CustomExtraAlienView.swift
//  AlienDestroyer
//
//  Created by Кирилл Щёлоков on 20.11.2023.
//

import UIKit

class CustomExtraAlienView: UIView, EntityProtocol, WeaponProtocol {
    var health: Int = 2
    var atackSpeed: Double = 2
    var damage: Int = 1

    let explosionImages = [
        "ExplosionImage1",
        "ExplosionImage2",
        "ExplosionImage3",
        "ExplosionImage4",
        "ExplosionImage5",
        "ExplosionImage6",
        "ExplosionImage7"]

    private lazy var alienImageView: UIImageView = UIImageView()

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
        addSubview(alienImageView)
        alienImageView.image = UIImage(named: "AlienImage2")
        alienImageView.contentMode = .scaleAspectFill
        alienImageView.clipsToBounds = true
        alienImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            alienImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            alienImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            alienImageView.heightAnchor.constraint(equalToConstant: 40),
            alienImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }

    public func makeExplosion() {
        let images = explosionImages.compactMap { UIImage(named: $0) }
        createAnimation(imageView: alienImageView, images: images, duration: 0.4) { [weak self] in
            self?.removeFromSuperview()
        }
    }

    private func createAnimation(imageView: UIImageView, images: [UIImage], duration: TimeInterval, completion: (() -> Void)?) {
        imageView.animationImages = images
        imageView.animationDuration = duration
        imageView.animationRepeatCount = 1
        imageView.startAnimating()

        DispatchQueue.main.asyncAfter(deadline: .now() + duration - 0.1) {
            completion?()
        }
    }
}
