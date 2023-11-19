//
//  GameView.swift
//  MyGame
//
//  Created by Камил Хайрутдинов on 18.11.2023.
//

import UIKit

class GameView: UIView {
    // MARK: - UI elements
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "SpaceBackground"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var spaceShipImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "SpaceShip"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    private lazy var spaceShipSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false

        slider.minimumTrackTintColor = .clear
        slider.maximumTrackTintColor = .clear
        slider.thumbTintColor = .clear
        let action = UIAction { [weak self] _ in
            self?.spaceShipAnimator?.fractionComplete = CGFloat(self?.spaceShipSlider.value ?? 0.0)
        }
        slider.addAction(action, for: .valueChanged)
        return slider
    }()

    // MARK: - Variables
    private var spaceShipAnimator: UIViewPropertyAnimator?

    private var enemyAnimator: UIViewPropertyAnimator?

    private var currentEnemy: UIImageView?

    var bulletLeadingAnchorConstant: CGFloat = 0.0
    var enemyLeadingAnchorConstant: CGFloat = 100

    weak var controller: GameViewController?
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(
            subviews: backgroundImageView,
            spaceShipImageView,
            spaceShipSlider)

        configureUI()
        setupGesture()
        createTimers()
        setupAnimators()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - UI extension
extension GameView {

    private func addSubviews(subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }

    private func configureUI() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),

            spaceShipImageView.widthAnchor.constraint(equalToConstant: 60),
            spaceShipImageView.heightAnchor.constraint(equalToConstant: 100),
            spaceShipImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            spaceShipImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),

            spaceShipSlider.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -65),
            spaceShipSlider.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 37),
            spaceShipSlider.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -37)
        ])
    }

}

// MARK: - Animator / Create bullets / Timer
extension GameView {

    private func setupAnimators() {
        spaceShipAnimator = UIViewPropertyAnimator(duration: 4.0, curve: .linear) {
            let moveTransform = CGAffineTransform(translationX: self.frame.width - 100, y: 0)
            self.spaceShipImageView.transform = moveTransform
        }
    }

    private func createTimers() {
        var enemyTimer = Timer.scheduledTimer(
            timeInterval: 2,
            target: self,
            selector: #selector(createEnemy),
            userInfo: nil,
            repeats: true)

        var hitTimer = Timer.scheduledTimer(
            timeInterval: 0.2,
            target: self,
            selector: #selector(collisionHandler),
            userInfo: nil,
            repeats: true)
    }

    @objc private func createEnemy() {

        let enemy = UIImageView()
        controller?.configureEnemyImageView(imageView: enemy)
        enemy.translatesAutoresizingMaskIntoConstraints = false
        enemy.contentMode = .scaleAspectFill

        self.addSubview(enemy)

        controller?.setRandomEnemyPosition(
            leadingAnchor: enemy.leadingAnchor,
            gameView: self)

        enemy.topAnchor.constraint(
            equalTo: topAnchor,
            constant: -50).isActive = true

        currentEnemy = enemy

        enemyAnimator = UIViewPropertyAnimator(duration: 2.4, curve: .easeOut) {

            let moveTransform = CGAffineTransform(translationX: 0.0, y: self.frame.height)
            enemy.transform = moveTransform
        }

        enemyAnimator?.addCompletion({ position in

            if position == .end {

                enemy.image = UIImage()

            }
        })

        enemyAnimator?.startAnimation()

    }

    private func createBullet() {

        let bullet = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        bullet.image = UIImage(named: "Bullet")
        bullet.translatesAutoresizingMaskIntoConstraints = false
        bullet.contentMode = .scaleAspectFill
        bullet.widthAnchor.constraint(equalToConstant: 20).isActive = true
        bullet.heightAnchor.constraint(equalToConstant: 40).isActive = true

        self.addSubview(bullet)
        bullet.bottomAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.bottomAnchor,
            constant: -130).isActive = true

        controller?.setBulletXPosition(
            leadingAnchor: bullet.leadingAnchor,
            gameView: self,
            sliderValue: spaceShipSlider.value)

        UIView.animate(withDuration: 0.3) {

            let moveTransform = CGAffineTransform(translationX: 0.0, y: -(self.frame.height - 150))
            bullet.transform = moveTransform

        } completion: { _ in

            bullet.removeFromSuperview()
            self.bulletLeadingAnchorConstant = -100
        }
    }

    @objc private func collisionHandler() {

        if bulletLeadingAnchorConstant > enemyLeadingAnchorConstant
            && bulletLeadingAnchorConstant < enemyLeadingAnchorConstant + (currentEnemy?.frame.size.width ?? 0.0) {
            currentEnemy?.image = UIImage(named: "Fire")

            UIView.animate(withDuration: 1) {
                let rotationtranform = CGAffineTransform(rotationAngle: 3 * .pi)
                self.currentEnemy?.transform = rotationtranform
            }
        }
    }

}

extension GameView {
   private func  setupGesture() {

       let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fire(_:)))

       tapGesture.numberOfTapsRequired = 1

       self.addGestureRecognizer(tapGesture)

   }

    @objc func fire(_ gesture: UITapGestureRecognizer) {

        createBullet()

    }
}
