import UIKit

class MenuView: UIView {
    private lazy var startButon: UIButton = UIButton()
    private var buttonActionClosure: (() -> Void)?
    private var backgroundImageView: UIImageView = UIImageView()

    @objc private func buttonTapped() {
        buttonActionClosure?()
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
        setupBackground()
    }

    func setButtonActionClosure(_ closure: @escaping () -> Void) {
        buttonActionClosure = closure
    }

    func setupBackground() {
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundImageView)
        backgroundColor = .red
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
}
