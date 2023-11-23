//
//  Rocket.swift
//  108_Tukaev
//
//  Created by surexnx on 20.11.2023.
//

import Foundation
import UIKit

class Rocket: UIView {

    lazy var image: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setImage(_ name: String) {
        image.image = UIImage(named: name)
    }

    func setupLayout() {
        addSubview(image)
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            image.heightAnchor.constraint(equalToConstant: 48),
            image.widthAnchor.constraint(equalToConstant: 48)
        ])
    }
}
