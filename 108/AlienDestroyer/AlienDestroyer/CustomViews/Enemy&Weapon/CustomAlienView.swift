//
//  CustomAlienView.swift
//  AlienDestroyer
//
//  Created by Кирилл Щёлоков on 18.11.2023.
//

import UIKit

class CustomAlienView: UIView, EntityProtocol {
    var health: Int = 2
    var atackSpeed: Double = 2

    private lazy var alienImageView: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        setUpAlienImageView()
    }

    private func setUpAlienImageView() {
        addSubview(alienImageView)
        alienImageView.image = UIImage(named: "AlienImage1")
        alienImageView.contentMode = .scaleAspectFill
        alienImageView.clipsToBounds = true
        alienImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            alienImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            alienImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            alienImageView.heightAnchor.constraint(equalToConstant: 40),
            alienImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}
