//
//  StartViewController.swift
//  StarShip
//
//  Created by Rustem on 21.11.2023.
//

import UIKit

class StartViewController: UIViewController {

    private let gameTitle: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Шахматы 3"
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor = .white
        return label
    }()

    private let backimage: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "space")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var startButton: UIButton = {
        var button = UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction { _ in
            self.navigationController?.pushViewController(ViewController(), animated: true)
        }, for: .touchUpInside)
        button.setTitle("Start game", for: .normal)
        button.backgroundColor = .black
        button.tintColor = .black
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(backimage)
        view.addSubview(startButton)
        view.addSubview(gameTitle)
        setupUI()
    }

    func setupUI() {
        NSLayoutConstraint.activate([
            backimage.widthAnchor.constraint(equalTo: view.widthAnchor),
            backimage.heightAnchor.constraint(equalTo: view.heightAnchor),

            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 300),
            startButton.heightAnchor.constraint(equalToConstant: 80),

            gameTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150)
        ])
    }
}
