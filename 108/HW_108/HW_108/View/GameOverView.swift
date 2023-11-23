import UIKit
class GameOverView: UIView {
    let gameOverImage: UIImageView = UIImageView()
    private var exitButtonActionClosure: (() -> Void)?
    private var backgroundImageView: UIImageView = UIImageView()
    let exitButton: UIButton = UIButton()
    var victory = false
    init(victory: Bool) {
        self.victory = victory
        super.init(frame: .zero)
        backgroundColor = .black
        setupBackground()
        setupGameOverImage()
        setUpExitButton()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc private func exitButtonTapped() {
        exitButtonActionClosure?()
    }
    func setupBackground() {
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        backgroundImageView.image = UIImage(named: "space.2")
        sendSubviewToBack(backgroundImageView)
    }
    func setExitButtonActionClosure(_ closure: @escaping () -> Void) {
        exitButtonActionClosure = closure
    }
    func setupGameOverImage() {
        gameOverImage.contentMode = .scaleAspectFill
        gameOverImage.clipsToBounds = true
        gameOverImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gameOverImage)
        NSLayoutConstraint.activate([
            gameOverImage.topAnchor.constraint(equalTo: topAnchor, constant: 300),
            gameOverImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            gameOverImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            gameOverImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
        ])
        if victory {
            gameOverImage.image = UIImage(named: "win")
        } else {
            gameOverImage.image = UIImage(named: "gameover")
        }

    }
    func setUpExitButton() {
        addSubview(exitButton)
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.setTitle("EXIT", for: .normal)
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        exitButton.titleLabel?.font = .boldSystemFont(ofSize: 26)
        exitButton.setTitleColor(.white, for: .normal)
        exitButton.layer.cornerRadius = 8
        exitButton.backgroundColor = .purple
        addSubview(exitButton)
        NSLayoutConstraint.activate([
            exitButton.topAnchor.constraint(equalTo: gameOverImage.bottomAnchor, constant: 40),
            exitButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            exitButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            exitButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1)
        ])
    }
}
