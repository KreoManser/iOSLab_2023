//
//  GameView.swift
//  HW_108_SpaceGame
//
//  Created by Артур Миннушин on 19.11.2023.
//

import UIKit

class StartGameView: UIView {
    var credits: Int?
    var gameManager: GameManager?
    var gameController: StartGameViewController?
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Space"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var battelLabel1: UILabel = {
        let label = UILabel()
        label.text = "Space"
        label.textColor = .systemMint
        label.font = UIFont.systemFont(ofSize: 60)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var battelLabel2: UILabel = {
        let label = UILabel()
        label.text = "Battle"
        label.textColor = .systemMint
        label.font = UIFont.systemFont(ofSize: 60)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var totalCreditsLabel: UILabel = {
        let label = UILabel()
        label.text = "TotalCredits: \(String(describing: credits))"
        label.textColor = .systemMint
        label.font = UIFont.systemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var startPlayButton: UIButton = {
        let button = UIButton()
        let action = UIAction {[weak self] _ in
            self?.startGame()
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Начать игру", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.setTitleColor(.systemMint, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 20
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    lazy var shopButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Магазин", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.setTitleColor(.systemMint, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 20
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(backgroundImageView)
        addSubview(battelLabel1)
        addSubview(battelLabel2)
        addSubview(totalCreditsLabel)
        addSubview(startPlayButton)
        addSubview(shopButton)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StartGameView {
    func setupCreditsTotalCount(credits: Int) {
        self.credits = credits
        setupLayout()
    }
    func startGame() {
        gameController?.startGameFunc()
    }
    func setupLayout() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(
                equalTo: topAnchor, constant: 0),
            backgroundImageView.bottomAnchor.constraint(
                equalTo: bottomAnchor, constant: 10),
            backgroundImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor, constant: 0),
            backgroundImageView.trailingAnchor.constraint(
                equalTo: trailingAnchor, constant: 0),
            battelLabel1.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor, constant: 60),
            battelLabel1.centerXAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerXAnchor),
            battelLabel2.topAnchor.constraint(
                equalTo: battelLabel1.bottomAnchor, constant: 5),
            battelLabel2.centerXAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerXAnchor),
            totalCreditsLabel.centerYAnchor.constraint(
                equalTo: centerYAnchor),
            totalCreditsLabel.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            startPlayButton.topAnchor.constraint(
                equalTo: totalCreditsLabel.bottomAnchor, constant: 70),
            startPlayButton.heightAnchor.constraint(
                equalToConstant: 50),
            startPlayButton.widthAnchor.constraint(
                equalToConstant: 200),
            startPlayButton.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            shopButton.topAnchor.constraint(
                equalTo: startPlayButton.bottomAnchor, constant: 10),
            shopButton.heightAnchor.constraint(
                equalToConstant: 50),
            shopButton.widthAnchor.constraint(
                equalToConstant: 200),
            shopButton.centerXAnchor.constraint(
                equalTo: centerXAnchor)
        ])
        totalCreditsLabel.text = "TotalCredits: \(credits ?? 10)"
    }
}
