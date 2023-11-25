//
//  StartView.swift
//  MyGame
//
//  Created by Faki Doosuur Doris on 21.11.2023.
//

import UIKit

class StartView: UIView {
    lazy var backgroundImage: UIImageView = UIImageView(frame: UIScreen.main.bounds)
    lazy var welcomelabel: UILabel = UILabel()
    lazy var startButton: UIButton = UIButton()
    var startButtonTapped: (() -> Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpBackground()
      //  setupWelcomeLabel()
        setUpButton()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpBackground() {
        backgroundImage.image = UIImage(named: "spacebackground")
        backgroundImage.contentMode = .scaleAspectFill
        addSubview(backgroundImage)
    }
    private func setupWelcomeLabel() {
        welcomelabel.text = "WELCOME"
        welcomelabel.textColor = .black
        welcomelabel.textAlignment = .center
        welcomelabel.font = .systemFont(ofSize: 40)
        welcomelabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(welcomelabel)
        NSLayoutConstraint.activate([
            welcomelabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
            welcomelabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 100)
        ])
    }
    private func setUpButton() {
        startButton.setTitle("LEVELONE", for: .normal)
        startButton.tintColor = .black
        startButton.setTitleColor(.white, for: .normal)
        startButton.setImage(UIImage(named: "startbutton"), for: .normal)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            startButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            startButton.widthAnchor.constraint(equalToConstant: 300),
            startButton.heightAnchor.constraint(equalToConstant: 50)

        ])

    }
}
