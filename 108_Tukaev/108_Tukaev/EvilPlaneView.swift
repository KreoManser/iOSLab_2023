//
//  EvilPlane.swift
//  108_Tukaev
//
//  Created by surexnx on 21.11.2023.
//

import UIKit

class EvilPlaneView: UIView {

    private var health = 1

    private let bangNameImages = ["bang1", "bang2", "bang3", "bang4", "bang5"]

    func getHealth() -> Int {
        return health
    }

    func setHealth(_ health: Int) {
        self.health = health
    }

    private lazy var image: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {
        addSubview(image)

        image.image = UIImage(named: "evilPlane1")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            image.heightAnchor.constraint(equalToConstant: 40),
            image.widthAnchor.constraint(equalToConstant: 40)
        ])
    }

    func animatiomBang() {
        let bangAnimation = bangNameImages.compactMap { UIImage(named: $0) }
        image.animationImages = bangAnimation
        image.animationDuration = 0.5
        image.animationRepeatCount = 1
        image.startAnimating()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 - 0.1) {
            self.removeFromSuperview()
            }
    }

}
