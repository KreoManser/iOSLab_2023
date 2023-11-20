//
//  PlayerView.swift
//  AlienDestroyer
//
//  Created by Кирилл Щёлоков on 17.11.2023.
//

import UIKit

class CustomPlayerView: UIView, EntityProtocol {
    var health: Int = 4
    var atackSpeed: Double = 1.5

    let explosionImages = [
        "ExplosionImage1",
        "ExplosionImage2",
        "ExplosionImage3",
        "ExplosionImage4",
        "ExplosionImage5",
        "ExplosionImage6",
        "ExplosionImage7"]

    private lazy var playerImageView: UIImageView = UIImageView()
    private lazy var playerEngineImageView: UIImageView = UIImageView()

    enum PlayerHealthState {
        case full
        case medium
        case lowMedium
        case low
    }

    var playerHealthState: PlayerHealthState = .full

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpAnimations()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        setUpPlayerImageView()
        setUpPlayerEngineImageView()
    }

    private func setUpAnimations() {
        setUpEngineIdleAnimation()
    }

    private func setUpPlayerImageView() {
        addSubview(playerImageView)
        playerImageView.image = UIImage(named: "PlayerShip0")
        playerImageView.contentMode = .scaleAspectFill
        playerImageView.clipsToBounds = true
        playerImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            playerImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            playerImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            playerImageView.heightAnchor.constraint(equalToConstant: 64),
            playerImageView.widthAnchor.constraint(equalToConstant: 64)
        ])
    }

    private func setUpPlayerEngineImageView() {
        playerImageView.addSubview(playerEngineImageView)
        playerEngineImageView.image = UIImage(named: "EngineIdle0")
        playerEngineImageView.contentMode = .scaleAspectFill
        playerEngineImageView.clipsToBounds = true
        playerEngineImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            playerEngineImageView.centerXAnchor.constraint(equalTo: playerImageView.centerXAnchor),
            playerEngineImageView.topAnchor.constraint(equalTo: playerImageView.topAnchor),
            playerEngineImageView.heightAnchor.constraint(equalToConstant: 64),
            playerEngineImageView.widthAnchor.constraint(equalToConstant: 64)
        ])
    }

    private func setUpEngineIdleAnimation() {
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .linear) { [weak self] in
            self?.playerEngineImageView.image = UIImage(named: "EngineIdle0")
        }
        animator.addCompletion { [weak self] _ in
            let animator2 = UIViewPropertyAnimator(duration: 0.3, curve: .linear) { [weak self] in
                self?.playerEngineImageView.image = UIImage(named: "EngineIdle1")
            }
            animator2.addCompletion { [weak self] _ in
                let animator3 = UIViewPropertyAnimator(duration: 0.3, curve: .linear) { [weak self] in
                    self?.playerEngineImageView.image = UIImage(named: "EngineIdle2")
                }
                animator3.addCompletion { [weak self] _ in
                    self?.setUpEngineIdleAnimation()
                }
                animator3.startAnimation()
            }
            animator2.startAnimation()
        }

        animator.startAnimation()
    }

    public func makeExplosion() {
        let images = explosionImages.compactMap { UIImage(named: $0) }
        createAnimation(imageView: playerImageView, images: images, duration: 0.4) { [weak self] in
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

    public func updatePlayerHealthState() {
        switch health {
        case 4:
            playerHealthState = .full
        case 3:
            playerHealthState = .medium
        case 2:
            playerHealthState = .lowMedium
        case 1:
            playerHealthState = .low
        default:
            playerHealthState = .full
        }

        switch playerHealthState {
        case .full:
            playerImageView.image = UIImage(named: "PlayerShip0")
        case .medium:
            playerImageView.image = UIImage(named: "PlayerShip1")
        case .lowMedium:
            playerImageView.image = UIImage(named: "PlayerShip2")
        case .low:
            playerImageView.image = UIImage(named: "PlayerShip3")
        }
    }
}
