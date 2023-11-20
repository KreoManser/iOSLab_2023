//
//  CustomWinLoseMenu.swift
//  AlienDestroyer
//
//  Created by Кирилл Щёлоков on 19.11.2023.
//

import UIKit

class CustomWinLoseMenu: UIView {

    private lazy var backgroundView: UIView = UIView()
    lazy var menuLabel: UILabel = UILabel()
    private lazy var scoreTitleLabel: UILabel = UILabel()
    lazy var scoreLabel: UILabel = UILabel()
    private lazy var homeButton: UIButton = UIButton()

    var homeButtonTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        setUpBackgroundView()
        setUpMenuLabel()
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

    private func setUpScoreTitleLabel() {
        backgroundView.addSubview(scoreTitleLabel)
        scoreTitleLabel.text = "Ваш результат"
        scoreTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        scoreTitleLabel.textColor = .white
        scoreTitleLabel.alpha = 0.7
        scoreTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scoreTitleLabel.topAnchor.constraint(equalTo: menuLabel.bottomAnchor, constant: 20),
            scoreTitleLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor)
        ])
    }

    private func setUpScoreLabel() {
        backgroundView.addSubview(scoreLabel)
        scoreLabel.text = "0"
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 80)
        scoreLabel.textColor = .white
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: scoreTitleLabel.bottomAnchor, constant: 10),
            scoreLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor)
        ])
    }

    private func setUpStartButton() {
        backgroundView.addSubview(homeButton)
        homeButton.setTitle("На Базу!", for: .normal)
        homeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        homeButton.backgroundColor = .menuBorder
        homeButton.layer.cornerRadius = 16
        homeButton.translatesAutoresizingMaskIntoConstraints = false

        let homeAction: UIAction = UIAction { _ in
            UIView.animate(withDuration: 0.1, delay: .zero, options: [.curveLinear]) { [weak self] in
                self?.homeButton.alpha = 0.5
            } completion: { [weak self] isFinished in
                guard isFinished else { return }
                self?.homeButton.alpha = 1
                self?.homeButtonTapped?()
            }
        }

        homeButton.addAction(homeAction, for: .touchUpInside)

        NSLayoutConstraint.activate([
            homeButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -30),
            homeButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            homeButton.heightAnchor.constraint(equalToConstant: 60),
            homeButton.widthAnchor.constraint(equalToConstant: 300)
        ])
    }

}
