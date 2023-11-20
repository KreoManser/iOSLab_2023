//
//  StartView.swift
//  AlienDestroyer
//
//  Created by Кирилл Щёлоков on 17.11.2023.
//

import UIKit

class StartView: UIView {

    private lazy var backgroundImageView: UIImageView = UIImageView()
    private lazy var logoImageView: UIImageView = UIImageView()
    private lazy var pressToStartLabel: UILabel = UILabel()
    private lazy var tapToStartRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToStartHandle))
    private var score: String
    private lazy var menuView: CustomMenuView = CustomMenuView(frame: bounds, score: score)

    var startButtonTapped: ((_ diffIndex: Int) -> Void)?

    required init(frame: CGRect, score: String) {
        self.score = score
        super.init(frame: frame)
        addGestureRecognizer(tapToStartRecognizer)
        setUpViews()
        setUpAnimations()
        menuView.startButtonTapped = { [weak self] diffIndex in
            self?.darkenScreen(diffIndex: diffIndex)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        setUpBackgroundImageView()
        setUpPressToStartLabel()
        setUpLogoImageView()
        setUpMenuView()
    }

    private func setUpAnimations() {
        setUpBackgroundAnimation()
        setUpPressToStartAnimation()
    }

    // MARK: Set Up Views

    private func setUpPressToStartLabel() {
        addSubview(pressToStartLabel)
        pressToStartLabel.text = "Нажми в любом месте, чтобы начать"
        pressToStartLabel.numberOfLines = 0
        pressToStartLabel.font = UIFont.boldSystemFont(ofSize: 25)
        pressToStartLabel.textColor = .white
        pressToStartLabel.translatesAutoresizingMaskIntoConstraints = false
        pressToStartLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            pressToStartLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40),
            pressToStartLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
            pressToStartLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -70)
        ])
    }

    private func setUpBackgroundImageView() {
        addSubview(backgroundImageView)
        backgroundImageView.image = UIImage(named: "BackgroundImage")
        backgroundImageView.frame = CGRect(x: -frame.width - 1120, y: -frame.height - 1700, width: bounds.width * 5, height: bounds.height * 4)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
    }

    private func setUpLogoImageView() {
        addSubview(logoImageView)
        logoImageView.image = UIImage(named: "LogoImage")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            logoImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            logoImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }

    private func setUpMenuView() {
        menuView.isHidden = true
        addSubview(menuView)
        menuView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            menuView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            menuView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: -40),
            menuView.heightAnchor.constraint(equalToConstant: 400),
            menuView.widthAnchor.constraint(equalToConstant: 350)
        ])
    }

    // MARK: Set Up Animations

    private func setUpBackgroundAnimation() {
        let duration: TimeInterval = 120
        let distance: CGFloat = 2550

        UIView.animate(withDuration: duration, delay: 0, options: [.curveLinear, .repeat], animations: { [weak self] in
            self?.backgroundImageView.transform = CGAffineTransform(translationX: 0, y: distance)
        })
    }

    private func setUpPressToStartAnimation() {
        let duration: TimeInterval = 1

        UIView.animate(withDuration: duration, delay: 0, options: [.curveLinear, .autoreverse, .repeat], animations: { [weak self] in
            self?.pressToStartLabel.alpha = 0.3
        })
    }

    // MARK: Handling functions

    @objc
    private func tapToStartHandle(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            menuView.isHidden = false
            pressToStartLabel.isHidden = true
            logoImageView.isHidden = true
            gesture.isEnabled = false
        }
    }

    // MARK: Helping functions

    private func darkenScreen(diffIndex: Int) {
        let darkView = UIView(frame: bounds)
        darkView.tag = 999
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0)
        addSubview(darkView)

        UIView.animate(withDuration: 1.5, delay: .zero, options: [.curveLinear], animations: {
            darkView.backgroundColor = UIColor.black.withAlphaComponent(1)
        }, completion: { [weak self] isFinished in
            guard isFinished else { return }
            self?.startButtonTapped?(diffIndex)
            UIView.animate(withDuration: 1.5, delay: .zero, options: [.curveLinear], animations: {
                darkView.backgroundColor = UIColor.black.withAlphaComponent(0)
            }, completion: { isFinished in
                guard isFinished else { return }
                darkView.removeFromSuperview()
            })
        })
    }
}
