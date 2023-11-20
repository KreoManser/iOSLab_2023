import UIKit

class CustomMenuView: UIView {

    private lazy var backgroundView: UIView = UIView()
    private lazy var menuLabel: UILabel = UILabel()
    private lazy var diffLabel: UILabel = UILabel()
    private lazy var scoreTitleLabel: UILabel = UILabel()
    private var scoreLabel: UILabel = UILabel()
    private lazy var startButton: UIButton = UIButton()
    private lazy var segmentControl: UISegmentedControl = UISegmentedControl(items: ["Легко", "Средне", "Сложно"])

    var startButtonTapped: ((_ diffIndex: Int) -> Void)?

    required init(frame: CGRect, score: String) {
        scoreLabel.text = score
        super.init(frame: frame)
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        setUpBackgroundView()
        setUpMenuLabel()
        setUpDiffLabel()
        setUpSegmentControl()
        setUpScoreTitleLabel()
        setUpScoreLabel()
        setUpStartButton()
    }

    private func setUpBackgroundView() {
        addSubview(backgroundView)
        backgroundView.backgroundColor = .menu
        backgroundView.layer.cornerRadius = 16
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.alpha = 0.9
        backgroundView.layer.borderWidth = 5
        backgroundView.layer.borderColor = UIColor.menuBorder.cgColor
        NSLayoutConstraint.activate([
            backgroundView.widthAnchor.constraint(equalToConstant: 350),
            backgroundView.heightAnchor.constraint(equalToConstant: 400),
            backgroundView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }

    private func setUpMenuLabel() {
        addSubview(menuLabel)
        menuLabel.text = "Меню"
        menuLabel.textColor = .white
        menuLabel.font = UIFont.boldSystemFont(ofSize: 20)
        menuLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            menuLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 16)
        ])
    }

    private func setUpDiffLabel() {
        backgroundView.addSubview(diffLabel)
        diffLabel.text = "Выберите сложность"
        diffLabel.font = UIFont.boldSystemFont(ofSize: 16)
        diffLabel.textColor = .white
        diffLabel.alpha = 0.7
        diffLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            diffLabel.topAnchor.constraint(equalTo: menuLabel.bottomAnchor, constant: 10),
            diffLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor)
        ])
    }

    private func setUpSegmentControl() {
        backgroundView.addSubview(segmentControl)
        segmentControl.backgroundColor = .white
        segmentControl.selectedSegmentTintColor = .menuBorder
        segmentControl.selectedSegmentIndex = 0

        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: diffLabel.bottomAnchor, constant: 20),
            segmentControl.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            segmentControl.widthAnchor.constraint(equalToConstant: 300)
        ])
    }

    private func setUpScoreTitleLabel() {
        backgroundView.addSubview(scoreTitleLabel)
        scoreTitleLabel.text = "Ваш лучший результат"
        scoreTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        scoreTitleLabel.textColor = .white
        scoreTitleLabel.alpha = 0.7
        scoreTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scoreTitleLabel.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 20),
            scoreTitleLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor)
        ])
    }

    private func setUpScoreLabel() {
        backgroundView.addSubview(scoreLabel)
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 80)
        scoreLabel.textColor = .white
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: scoreTitleLabel.bottomAnchor, constant: 10),
            scoreLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor)
        ])
    }

    private func setUpStartButton() {
        backgroundView.addSubview(startButton)
        startButton.setTitle("В БОЙ!", for: .normal)
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        startButton.backgroundColor = .menuBorder
        startButton.layer.cornerRadius = 16
        startButton.translatesAutoresizingMaskIntoConstraints = false

        let startGameAction: UIAction = UIAction { _ in
            UIView.animate(withDuration: 0.1, delay: .zero, options: [.curveLinear]) { [weak self] in
                self?.startButton.alpha = 0.5
            } completion: { [weak self] isFinished in
                guard isFinished else { return }
                self?.startButton.alpha = 1
                self?.startButtonTapped?(self?.segmentControl.selectedSegmentIndex ?? 0)
            }
        }

        startButton.addAction(startGameAction, for: .touchUpInside)

        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -30),
            startButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 60),
            startButton.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
}
