//
//  MenuView.swift
//  MyGame(A Cat in space)
//
//  Created by Нияз Ризванов on 21.11.2023.
//

import UIKit

class MenuView: UIView {
    weak var menuController: MenuViewController?
    lazy var titleGame: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "A CAT IN SPACE"
        label.font = UIFont(name: "Helvetica-Bold", size: 30)
        //label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    lazy var titleLevel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Easy"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    lazy var playButton: UIButton = {
        let action = UIAction() { _ in
            self.menuController?.beganGame(level: self.titleLevel.text ?? "")
        }
        let button = UIButton(type: .custom, primaryAction: action)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Play", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    lazy var levelButton: UIButton = {
        let action = UIAction() { _ in
            self.titleLevel.text = self.menuController?.choiceLevel(defoultLevel: self.titleLevel.text ?? "")
        }
        let button = UIButton(type: .custom, primaryAction: action)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Level", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleGame)
        addSubview(playButton)
        addSubview(titleLevel)
        addSubview(levelButton)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        let backgroundImage = UIImageView(image: UIImage(named: "Space"))
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.frame = bounds
        insertSubview(backgroundImage, at: 0)
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            titleGame.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleGame.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 200),
            playButton.topAnchor.constraint(equalTo: titleGame.bottomAnchor, constant: 100),
            playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 150),
            playButton.heightAnchor.constraint(equalToConstant: 50),
            levelButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 30),
            levelButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            levelButton.widthAnchor.constraint(equalToConstant: 150),
            levelButton.heightAnchor.constraint(equalToConstant: 50),
            titleLevel.topAnchor.constraint(equalTo: levelButton.bottomAnchor, constant: 50),
            titleLevel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
