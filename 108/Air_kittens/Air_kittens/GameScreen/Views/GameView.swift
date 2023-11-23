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
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var playButton: UIButton = {
        let button = UIButton()
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            self.startTimers()
            self.setupGesture()
            button.isHidden = true
        }
        button.setTitle("Играть", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = UIColor(red: 44 / 255, green: 40 / 255, blue: 107 / 255, alpha: 1)
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
        button.setTitle("Переиграть", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = UIColor(red: 44 / 255, green: 40 / 255, blue: 107 / 255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(action, for: .touchUpInside)
        return button
    }()

    private lazy var gameOverLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Игра завершена."
        label.font = UIFont.boldSystemFont(ofSize: 25)
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
    private var enemyPosition: [UIView: Int] = [:]
    private var playerBullet: UIView?

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
        playerAnimator?.fractionComplete = 0.5
        enemyTimer?.invalidate()
        bossTimer?.invalidate()
        collisionTimer?.invalidate()
    }

    func restartGame() {
        startTimers()
        restartButton.isHidden = true
        gameOverLabel.isHidden = true
        scoreLabel.text = "0"
    }

    func startTimers() {
        playerShotTimer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(shot), userInfo: nil, repeats: true)
        enemyTimer = Timer.scheduledTimer(timeInterval: 2.4, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        bossTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(createBoss), userInfo: nil, repeats: false)
        collisionTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(handleCollision), userInfo: nil, repeats: true)
    }

    @objc private func createBoss() {
        let boss = UIImageView(image: UIImage(named: "Boss"))
        boss.translatesAutoresizingMaskIntoConstraints = false
        boss.contentMode = .scaleAspectFill
        enemyPosition[boss] = 3
        addSubview(boss)
        NSLayoutConstraint.activate([
            boss.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: GameManager.shared.getRandXPosition(screenBounds: self.bounds)),
            boss.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -100)
        ])
        bossAnimator = UIViewPropertyAnimator(duration: 10, curve: .linear) {
            let moveTransform = CGAffineTransform(translationX: 0.0, y: self.frame.height + 50)
            boss.transform = moveTransform
        }
        bossAnimator?.addCompletion({ _ in
            boss.removeFromSuperview()
            self.enemyPosition.removeValue(forKey: boss)
            self.gameViewController?.checkGame()
        })
        bossAnimator?.startAnimation()
    }

    @objc private func createEnemy() {
        let enemy = UIImageView()
        gameViewController?.configureEnemy(enemyImageView: enemy)
        enemy.translatesAutoresizingMaskIntoConstraints = false
        enemy.contentMode = .scaleAspectFill

        let const = GameManager.shared.getRandXPosition(screenBounds: self.bounds)
        enemyPosition[enemy] = 1

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
        for enemy in enemyPosition.keys  where
        ((enemy.layer.presentation()?.frame.intersects(playerBullet?.layer.presentation()?.frame ?? .zero)) == true) {
            getExplosion(enemy)
        }
    }

    func getExplosion(_ shipView: UIView) {
        let explosion = UIImageView(image: UIImage(named: "Explosion"))
        shipView.frame = CGRect(x: shipView.frame.midX, y: shipView.frame.midY, width: 40, height: 60)
        print(explosion.frame)
        explosion.contentMode = .scaleAspectFill
        addSubview(explosion)
        UIView.animate(withDuration: 0.8) {
            shipView.removeFromSuperview()
            self.playerBullet?.removeFromSuperview()
            self.enemyPosition.removeValue(forKey: shipView)
        } completion: { _ in
            explosion.removeFromSuperview()
        }
    }

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

extension GameView {
    func setupLayout() {
        addSubview(backgroundImageView)
        addSubview(playButton)
        addSubview(playerImageView)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),

            playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 150),
            playButton.heightAnchor.constraint(equalToConstant: 75),

            playerImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -80),
            playerImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            playerImageView.widthAnchor.constraint(equalToConstant: 50),
            playerImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
