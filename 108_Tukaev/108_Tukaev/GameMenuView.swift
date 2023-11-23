//
//  LoseMenuView.swift
//  108_Tukaev
//
//  Created by surexnx on 21.11.2023.
//

import UIKit

protocol ButtonMenuDelegate: AnyObject {
    func restartButton()
    func backButton()
}

class GameMenuView: UIView {

    private lazy var winLoseLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    private lazy var scoreLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    private lazy var restartButton: UIButton = {
        var action = UIAction {_ in
            self.delegate?.restartButton()

        }

        var button = UIButton(type: .system, primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Restart", for: .normal)
        return button
    }()

    private lazy var backButton: UIButton = {
        var action = UIAction {_ in
            self.delegate?.backButton()
        }

        var button = UIButton(type: .system, primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Back", for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    weak var delegate: ButtonMenuDelegate?
    var controller: GameMenuViewController?

    func setupMenu(score: Int, winLose: String) {
        scoreLabel.text = "Score: " + String(score)
        winLoseLabel.text = "You " + winLose
    }

    private func setupLayout() {
        addSubview(scoreLabel)
        addSubview(winLoseLabel)
        let stackView = UIStackView(arrangedSubviews: [backButton, restartButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        NSLayoutConstraint.activate([
            scoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -40),

            winLoseLabel.bottomAnchor.constraint(equalTo: scoreLabel.topAnchor),
            winLoseLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            winLoseLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            stackView.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)

        ])
    }

}
