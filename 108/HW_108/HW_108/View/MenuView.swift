import UIKit

class MenuView: UIView {
    private lazy var startButon: UIButton = UIButton()
    private var buttonActionClosure: (() -> Void)?
    private var backgroundImageView: UIImageView = UIImageView()
    private var easyButtonActionClosure: (() -> Void)?
    private var middleButtonActionClosure: (() -> Void)?
    private var hardButtonActionClosure: (() -> Void)?
    private lazy var easyButton: UIButton = UIButton()
    private lazy var middleButton: UIButton = UIButton()
    private lazy var hardButton: UIButton = UIButton()
    @objc private func buttonTapped() {
        buttonActionClosure?()
    }
    @objc private func easyButtonTapped() {
        easyButton.backgroundColor = .systemPink
        middleButton.backgroundColor = .purple
        hardButton.backgroundColor = .purple
        easyButtonActionClosure?()
    }
    @objc private func middleButtonTapped() {
        easyButton.backgroundColor = .purple
        middleButton.backgroundColor = .systemPink
        hardButton.backgroundColor = .purple
        middleButtonActionClosure?()
    }
    @objc private func hardButtonTapped() {
        easyButton.backgroundColor = .purple
        middleButton.backgroundColor = .purple
        hardButton.backgroundColor = .systemPink
        hardButtonActionClosure?()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpAccountsButton()
        setUpEasyButton()
        setUpMiddleButton()
        setUpHardButton()
        setupBackground()
    }
    func setButtonActionClosure(_ closure: @escaping () -> Void) {
        buttonActionClosure = closure
    }
    func setEasyButtonActionClosure(_ closure: @escaping () -> Void) {
        easyButtonActionClosure = closure
    }
    func setMiddleButtonActionClosure(_ closure: @escaping () -> Void) {
        middleButtonActionClosure = closure
    }
    func setHardButtonActionClosure(_ closure: @escaping () -> Void) {
        hardButtonActionClosure = closure
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
        backgroundImageView.image = UIImage(named: "start.space")
        sendSubviewToBack(backgroundImageView)
    }
    func setUpAccountsButton() {
        addSubview(startButon)
        startButon.translatesAutoresizingMaskIntoConstraints = false
        startButon.titleLabel?.font = .boldSystemFont(ofSize: 26)
        startButon.setTitle("Start", for: .normal)
        startButon.setTitleColor(.white, for: .normal)
        startButon.layer.cornerRadius = 8
        startButon.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        startButon.backgroundColor = .purple
        NSLayoutConstraint.activate([
            startButon.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 600),
            startButon.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            startButon.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.1),
            startButon.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    func setUpEasyButton() {
        addSubview(easyButton)
        easyButton.translatesAutoresizingMaskIntoConstraints = false
        easyButton.setTitle("Easy", for: .normal)
        easyButton.titleLabel?.font = .boldSystemFont(ofSize: 26)
        easyButton.setTitleColor(.white, for: .normal)
        easyButton.addTarget(self, action: #selector(easyButtonTapped), for: .touchUpInside)
        easyButton.layer.cornerRadius = 8
        easyButton.backgroundColor = .purple
        NSLayoutConstraint.activate([
            easyButton.topAnchor.constraint(equalTo: startButon.bottomAnchor, constant: 40),
            easyButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.25),
            easyButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.1),
            easyButton.leadingAnchor.constraint(equalTo: startButon.leadingAnchor)
        ])
    }
    func setUpMiddleButton() {
        addSubview(middleButton)
        middleButton.setTitle("Middle", for: .normal)
        middleButton.setTitleColor(.white, for: .normal)
        middleButton.titleLabel?.font = .boldSystemFont(ofSize: 26)
        middleButton.addTarget(self, action: #selector(middleButtonTapped), for: .touchUpInside)
        middleButton.layer.cornerRadius = 8
        middleButton.backgroundColor = .purple
        middleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            middleButton.topAnchor.constraint(equalTo: startButon.bottomAnchor, constant: 40),
            middleButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.25),
            middleButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.1),
            middleButton.leadingAnchor.constraint(equalTo: easyButton.trailingAnchor, constant: 10)
        ])
    }
    func setUpHardButton() {
        addSubview(hardButton)
        hardButton.setTitle("Hard", for: .normal)
        hardButton.setTitleColor(.white, for: .normal)
        hardButton.titleLabel?.font = .boldSystemFont(ofSize: 26)
        hardButton.addTarget(self, action: #selector(hardButtonTapped), for: .touchUpInside)
        hardButton.layer.cornerRadius = 8
        hardButton.backgroundColor = .purple
        hardButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hardButton.topAnchor.constraint(equalTo: startButon.bottomAnchor, constant: 40),
            hardButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.25),
            hardButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.1),
            hardButton.leadingAnchor.constraint(equalTo: middleButton.trailingAnchor, constant: 10)
        ])
    }
}
