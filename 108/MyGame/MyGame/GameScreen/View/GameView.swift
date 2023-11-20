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

    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "Score: 0"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 22)

        return label
    }()

    private lazy var playButton: UIButton = {
        let button = UIButton(configuration: .tinted())
        button.translatesAutoresizingMaskIntoConstraints = false

        let action = UIAction { [weak self] _ in
            self?.setupGesture()
            self?.createTimers()
            self?.setupAnimators()

            button.isHidden = true
        }

        button.tintColor = .purple
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Play", for: .normal)
        button.addAction(action, for: .touchDown)

        return button
    }()

    private lazy var restartGameButton: UIButton = {
        let button = UIButton(configuration: .tinted())
        button.translatesAutoresizingMaskIntoConstraints = false

        let action = UIAction { [weak self] _ in
            self?.restartGame()
        }

        button.isHidden = true
        button.tintColor = .purple
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Restart", for: .normal)
        button.addAction(action, for: .touchDown)

        return button
    }()

    private lazy var loseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "You lose :("
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.isHidden = true
        return label
    }()

    private lazy var playerHitPount: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "heart.fill")?.withTintColor(.red))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    // MARK: - Variables
    private var spaceShipAnimator: UIViewPropertyAnimator?

    private var enemyAnimator: UIViewPropertyAnimator?

    private var playerHealthAnimator: UIViewPropertyAnimator?

    private var currentEnemy: UIImageView?

    private var enemyTimer: Timer?

    private var collisionTimer: Timer?

    var bulletLeadingAnchorConstant: CGFloat = 0.0
    var enemyLeadingAnchorConstant: CGFloat = 100

    weak var controller: GameViewController?
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(
            subviews: backgroundImageView,
            spaceShipImageView,
            spaceShipSlider,
            scoreLabel,
            playButton,
            restartGameButton,
            loseLabel,
            playerHitPount)

        configureUI()
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
            spaceShipSlider.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -37),

            scoreLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            scoreLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),

            playButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 150),
            playButton.heightAnchor.constraint(equalToConstant: 70),

            restartGameButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            restartGameButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            restartGameButton.widthAnchor.constraint(equalToConstant: 150),
            restartGameButton.heightAnchor.constraint(equalToConstant: 70),

            loseLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            loseLabel.bottomAnchor.constraint(equalTo: restartGameButton.topAnchor, constant: -30),

            playerHitPount.widthAnchor.constraint(equalToConstant: 40),
            playerHitPount.heightAnchor.constraint(equalToConstant: 40),
            playerHitPount.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            playerHitPount.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ])
    }

}

// MARK: - Animator / Create bullets / enemies / Timer
extension GameView {

    private func setupAnimators() {
        spaceShipSlider.value = 0.0

        spaceShipAnimator = UIViewPropertyAnimator(duration: 4.0, curve: .linear) {
            let moveTransform = CGAffineTransform(translationX: self.frame.width - 100, y: 0)
            self.spaceShipImageView.transform = moveTransform
        }

        playerHealthAnimator = UIViewPropertyAnimator(duration: 1.5, curve: .easeIn, animations: {
            let scaleTransform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            let moveTranform = CGAffineTransform(translationX: -50, y: 100)
            let rotationtranform = CGAffineTransform(rotationAngle: 0 - .pi)
            self.playerHitPount.transform = rotationtranform.concatenating(moveTranform).concatenating(scaleTransform)
        })
    }

    private func createTimers() {
        enemyTimer = Timer.scheduledTimer(
            timeInterval: 2.7,
            target: self,
            selector: #selector(createEnemy),
            userInfo: nil,
            repeats: true)

        collisionTimer = Timer.scheduledTimer(
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

        controller?.incrementEnemyCounter()

        enemyAnimator = UIViewPropertyAnimator(duration: 2.4, curve: .easeOut) {

            let moveTransform = CGAffineTransform(translationX: 0.0, y: self.frame.height)
            enemy.transform = moveTransform
        }

        enemyAnimator?.addCompletion({ _ in

            enemy.removeFromSuperview()
            self.controller?.checkScore()

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

        UIView.animate(withDuration: 0.2) {

            let moveTransform = CGAffineTransform(translationX: 0.0, y: -(self.frame.height - 50))
            bullet.transform = moveTransform

        } completion: { _ in

            bullet.removeFromSuperview()
            self.bulletLeadingAnchorConstant = -100
        }
    }

    @objc private func collisionHandler() {

        guard let controller = controller else { return }

        if bulletLeadingAnchorConstant > enemyLeadingAnchorConstant
            && bulletLeadingAnchorConstant < enemyLeadingAnchorConstant + (currentEnemy?.frame.size.width ?? 0.0) {
            controller.fixHit()
            if controller.enemyIsDeadChecker() {
                currentEnemy?.image = UIImage(named: "Fire")
                controller.addScore(label: scoreLabel)
                UIView.animate(withDuration: 0.1) {
                    self.currentEnemy?.frame.size = CGSize(width: 50, height: 50)
                }

                UIView.animate(withDuration: 2) {
                    let rotationtranform = CGAffineTransform(rotationAngle: 10 * .pi)
                    self.currentEnemy?.transform = rotationtranform
                }
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

extension GameView {
    func showLoseMenu() {

        loseLabel.isHidden = false
        enemyTimer?.invalidate()
        collisionTimer?.invalidate()
        spaceShipSlider.value = 0.0
        restartGameButton.isHidden = false
        spaceShipAnimator?.fractionComplete = 0.0
        playerHealthAnimator?.startAnimation()
    }

    func restartGame() {
        createTimers()
        restartGameButton.isHidden = true
        loseLabel.isHidden = true
        scoreLabel.text = "Score: 0"
        playerHealthAnimator?.fractionComplete = 0.0
    }
}
