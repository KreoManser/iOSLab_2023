import UIKit

class GameView: UIView {
    private lazy var backgroundImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Background"))
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var playerImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "PLayer"))
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

    private lazy var playerSlider: UISlider = {
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            self.playerAnimator?.fractionComplete = CGFloat(self.playerSlider.value)
        }

        let slider = UISlider()
        slider.minimumTrackTintColor = .clear
        slider.maximumTrackTintColor = .clear
        slider.thumbTintColor = .clear
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addAction(action, for: .valueChanged)
        return slider
    }()

    private lazy var playButton: UIButton = {
        let button = UIButton()
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            self.startTimers()
            self.setupAnimators()
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
    private var bossTimer: Timer?
    private var enemyTimer: Timer?
    private var collisionTimer: Timer?

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
        playerSlider.value = 0.5
    }

    func restartGame() {
        startTimers()
        restartButton.isHidden = true
        gameOverLabel.isHidden = true
        scoreLabel.text = "0"
    }

    func startTimers() {
        enemyTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        bossTimer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(createBoss), userInfo: nil, repeats: false)
        collisionTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(collision), userInfo: nil, repeats: true)
    }

    @objc private func createBoss() {

    }

    @objc private func createEnemy() {

    }

    @objc private func collision() {

    }

    private func  setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(shot(_:)))
        self.addGestureRecognizer(tapGesture)
    }

    @objc func shot(_ gesture: UITapGestureRecognizer) { getBullet() }

    func getBullet() {
        let bullet = UIImageView(image: UIImage(named: "Bullet"))
        bullet.contentMode = .scaleAspectFill
        bullet.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bullet)

        NSLayoutConstraint.activate([
            bullet.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            bullet.heightAnchor.constraint(equalToConstant: 30),
            bullet.widthAnchor.constraint(equalToConstant: 15)
        ])

        UIView.animate(withDuration: 0.2) {
            let moveTransform = CGAffineTransform(translationX: 0.0, y: -(self.frame.height - 50))
            bullet.transform = moveTransform
        } completion: { _ in
            bullet.removeFromSuperview()
        }
    }

    func setupAnimators(){

    }
}

extension GameView {
    func setupLayout() {
        addSubview(backgroundImageView)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
