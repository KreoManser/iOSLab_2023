import UIKit

class GameView: UIView {
    private lazy var backgroundImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "background"))
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var playerImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Player"))
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "0"
        label.font = .systemFont(ofSize: 45, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var playButton: UIButton = {
        let button = UIButton(configuration: .tinted())
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            self.startTimers()
            self.setupGesture()
            button.isHidden = true
        }
        button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 23, weight: .medium)
            return outgoing
        }
        button.setTitle("Играть", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(action, for: .touchUpInside)
        return button
    }()

    private lazy var restartButton: UIButton = {
        let button = UIButton(configuration: .tinted())
        let action = UIAction { [weak self] _ in
            self?.restartGame()
            button.isHidden = true
        }
        button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 23, weight: .medium)
            return outgoing
        }
        button.setTitle("Переиграть", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 23, weight: .medium)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(action, for: .touchUpInside)
        return button
    }()

    private lazy var nextLevelButton: UIButton = {
        let button = UIButton(configuration: .tinted())
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            self.secondLevelTimers()
            button.isHidden = true
            self.passedLevelLabel.isHidden = true
        }
        button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 23, weight: .medium)
            return outgoing
        }
        button.isHidden = true
        button.setTitle("Перейти к следующему", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(action, for: .touchUpInside)
        return button
    }()

    private lazy var gameOverLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Игра завершена"
        label.contentMode = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.isHidden = true
        return label
    }()

    private lazy var passedLevelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Уровень пройден!"
        label.contentMode = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.isHidden = true
        return label
    }()

    weak var gameViewController: GameController?
    private var playerAnimator: UIViewPropertyAnimator?
    private var enemyAnimator: UIViewPropertyAnimator?
    private var bossAnimator: UIViewPropertyAnimator?
    private var playerShotTimer: Timer?
    private var bossTimer: Timer?
    private var enemyTimer: Timer?
    private var collisionTimer: Timer?
    private var lastTouch: CGPoint = .zero
    private var enemyPosition: [UIImageView: Int] = [:]
    private var playerBullet: UIImageView?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GameView {
    func showMenu() {
        gameOverLabel.isHidden = false
        restartButton.isHidden = false
        enemyTimer?.invalidate()
        bossTimer?.invalidate()
        collisionTimer?.invalidate()
        playerShotTimer?.invalidate()
        for enemy in enemyPosition.keys {
            enemy.removeFromSuperview()
        }
    }

    func restartGame() {
        startTimers()
        restartButton.isHidden = true
        gameOverLabel.isHidden = true
        nextLevelButton.isHidden = true
        passedLevelLabel.isHidden = true
        scoreLabel.text = "0"
    }

    func secondLevel() {
        nextLevelButton.isHidden = false
        passedLevelLabel.isHidden = false
        enemyTimer?.invalidate()
        bossTimer?.invalidate()
        collisionTimer?.invalidate()
        playerShotTimer?.invalidate()
        for enemy in enemyPosition.keys {
            enemy.removeFromSuperview()
        }

    }

    func startTimers() {
        playerShotTimer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(shot), userInfo: nil, repeats: true)
        enemyTimer = Timer.scheduledTimer(timeInterval: 2.4, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        bossTimer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(createBoss), userInfo: nil, repeats: false)
        collisionTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(handleCollision), userInfo: nil, repeats: true)
    }

    func secondLevelTimers() {
        playerShotTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(shot), userInfo: nil, repeats: true)
        enemyTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        bossTimer = Timer.scheduledTimer(timeInterval: 25, target: self, selector: #selector(createBoss), userInfo: nil, repeats: false)
        collisionTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(handleCollision), userInfo: nil, repeats: true)
    }
}

extension GameView {
    @objc private func createBoss() {
        let boss = UIImageView(image: UIImage(named: "Boss"))
        boss.translatesAutoresizingMaskIntoConstraints = false
        boss.contentMode = .scaleAspectFill
        enemyPosition[boss] = 4
        addSubview(boss)
        NSLayoutConstraint.activate([
            boss.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: CGFloat.random(in: 60..<self.frame.width - 100)),
            boss.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -100)
        ])
        bossAnimator = UIViewPropertyAnimator(duration: 10, curve: .linear) {
            let moveTransform = CGAffineTransform(translationX: 0.0, y: self.frame.height + 50)
            boss.transform = moveTransform
        }
        bossAnimator?.addCompletion({ _ in
            if boss.layer.presentation()?.frame.minY ?? 0.0 >= self.frame.height {
                boss.removeFromSuperview()
                self.enemyPosition.removeValue(forKey: boss)
                self.showMenu()
                GameManager.shared.restartGame()
            } else {
                self.secondLevel()
                boss.removeFromSuperview()
                self.enemyPosition.removeValue(forKey: boss)
            }
        })
        bossAnimator?.startAnimation()
    }

    @objc private func createEnemy() {
        let enemy = UIImageView()
        gameViewController?.configureEnemy(enemyImageView: enemy)
        enemy.translatesAutoresizingMaskIntoConstraints = false
        enemy.contentMode = .scaleAspectFill

        let const = GameManager.shared.getRandXPosition(screenBounds: self.bounds)
        enemyPosition[enemy] = Int.random(in: 1...3)

        addSubview(enemy)
        NSLayoutConstraint.activate([
            enemy.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: const),
            enemy.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -100),
            enemy.heightAnchor.constraint(equalToConstant: 80),
            enemy.widthAnchor.constraint(equalToConstant: 40)
        ])
        enemyAnimator = UIViewPropertyAnimator(duration: 5, curve: .linear) {
            let moveTransform = CGAffineTransform(translationX: 0.0, y: self.frame.height + 50)
            enemy.transform = moveTransform
        }
        enemyAnimator?.addCompletion({ _ in
            enemy.removeFromSuperview()
            self.enemyPosition.removeValue(forKey: enemy)
            self.gameViewController?.checkGame()
        })
        enemyAnimator?.startAnimation()
    }

    @objc private func handleCollision() {
        for enemy in enemyPosition.keys {
            if enemy.layer.presentation()?.frame.minY ?? 0.0 >= self.frame.height {
                GameManager.shared.decreaseHealth()
                self.getBlinked(self.playerImageView)
                enemyPosition.removeValue(forKey: enemy)
            }
            if ((enemy.layer.presentation()?.frame.intersects(playerBullet?.layer.presentation()?.frame ?? .zero)) == true) {
                if var enemyHealth = enemyPosition[enemy] {
                    enemyHealth -= 1
                    enemyPosition[enemy] = enemyHealth
                    if enemyHealth <= 0 {
                        getExplosion(enemy)
                        gameViewController?.increaseScore(scoreLabel: scoreLabel)
                    } else {
                        getBlinked(enemy)
                        playerBullet?.removeFromSuperview()
                    }
                }
            }
        }
    }
}

extension GameView {
    func setupLayout() {
        addSubview(backgroundImageView)
        addSubview(playButton)
        addSubview(scoreLabel)
        addSubview(playerImageView)
        addSubview(gameOverLabel)
        addSubview(restartButton)
        addSubview(passedLevelLabel)
        addSubview(nextLevelButton)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),

            playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 100),
            playButton.heightAnchor.constraint(equalToConstant: 40),

            playerImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -100),
            playerImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            playerImageView.widthAnchor.constraint(equalToConstant: 50),
            playerImageView.heightAnchor.constraint(equalToConstant: 100),

            scoreLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),

            gameOverLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 300),
            gameOverLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            restartButton.topAnchor.constraint(equalTo: gameOverLabel.bottomAnchor, constant: 10),
            restartButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            restartButton.widthAnchor.constraint(equalToConstant: 170),
            restartButton.heightAnchor.constraint(equalToConstant: 40),

            passedLevelLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 300),
            passedLevelLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            nextLevelButton.topAnchor.constraint(equalTo: passedLevelLabel.bottomAnchor, constant: 10),
            nextLevelButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextLevelButton.widthAnchor.constraint(equalToConstant: 300),
            nextLevelButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension GameView {
    private func  setupGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        self.addGestureRecognizer(panGesture)
    }

    @objc func shot() { getPlayerBullet() }

    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        let curTouch = gesture.translation(in: self)
        if gesture.state == .began {
            lastTouch = playerImageView.center
        } else if gesture.state == .changed {
            let translation = CGAffineTransform(translationX: curTouch.x - lastTouch.x, y: curTouch.y - lastTouch.y)
            let transformedFrame = playerImageView.frame.applying(translation)

            if self.bounds.contains(transformedFrame) {
                playerImageView.transform = playerImageView.transform.concatenating(translation)
            }
            lastTouch = curTouch
        }
    }
}

extension GameView {
    func getBlinked(_ shipImageView: UIImageView) {
        UIView.animate(withDuration: 0.2, delay: .zero, options: .autoreverse) {
            shipImageView.alpha = 0.3
        } completion: { [weak shipImageView] _ in
            shipImageView?.alpha = 1
        }
    }

    func getExplosion(_ shipView: UIImageView) {
        UIView.animate(withDuration: 0.8) {
            shipView.frame = CGRect(x: shipView.frame.midX, y: shipView.frame.midY, width: 40, height: 60)
            shipView.image = UIImage(named: "Explosion")
            self.playerBullet?.removeFromSuperview()
            self.enemyPosition.removeValue(forKey: shipView)
        } completion: { _ in
            self.enemyPosition.removeValue(forKey: shipView)
            shipView.removeFromSuperview()
        }
    }

    func getPlayerBullet() {
        let bullet = UIImageView(image: UIImage(named: "Bullet"))
        bullet.frame = CGRect(x: playerImageView.frame.midX - 10, y: playerImageView.frame.midY - 25, width: 20, height: 20)
        bullet.contentMode = .scaleAspectFill
        playerBullet = bullet
        addSubview(bullet)
        UIView.animate(withDuration: 0.8, delay: 0.2) {
            let moveTransform = CGAffineTransform(translationX: 0.0, y: -(self.bounds.height + 50))
            bullet.transform = moveTransform
        } completion: { _ in
            bullet.removeFromSuperview()
        }
    }
}
