//
//  MainView.swift
//  CosmoStars
//
//  Created by Mac on 2023-11-19.
//

import UIKit

class MainView: UIView {
    // MARK: - Declaration objects
    private lazy var alienShipsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var userShipView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "user"))
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .clear
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        slider.value = 0.5
        slider.minimumTrackTintColor = UIColor.clear
        slider.maximumTrackTintColor = UIColor.clear
        slider.thumbTintColor = UIColor.clear
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        return slider
    }()
    private lazy var userShipLayer = CALayer()
    private lazy var alienShipsLayer = CALayer()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayouts()
        self.setupAlienShipsView(1)

        let backgroundImage = UIImageView(image: UIImage(named: "back"))
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false

        addSubview(backgroundImage)
        sendSubviewToBack(backgroundImage)

        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func sliderValueChanged(_ slider: UISlider) {
        let newPositionX = CGFloat(slider.value) * (slider.frame.width - userShipView.frame.width)

        UIView.animate(withDuration: 0.1) {
            self.userShipView.frame.origin.x = newPositionX
        }
    }
}

extension MainView {
    private func setupLayouts() {
        addSubview(alienShipsView)
        addSubview(userShipView)
        addSubview(slider)

        NSLayoutConstraint.activate([
            alienShipsView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            alienShipsView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            alienShipsView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            alienShipsView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.75),

            slider.topAnchor.constraint(equalTo: alienShipsView.bottomAnchor),
            slider.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            slider.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),

            userShipView.topAnchor.constraint(equalTo: slider.topAnchor, constant: -50),
            userShipView.widthAnchor.constraint(equalToConstant: 100),
            userShipView.heightAnchor.constraint(equalToConstant: 100),
            userShipView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    func setupAlienShipsView(_ level: Int) {
        let alienShipsLayer = CALayer()
        alienShipsLayer.bounds = alienShipsView.bounds
        alienShipsLayer.position = alienShipsView.center

        let aliens = Alien(.noob).createAmountOfAliens(type: .noob, amount: 5)
        var yConst = 50
        var xConst = 35

        for alien in aliens {
            let alienLayer = CALayer()
            alienLayer.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
            alienLayer.position = CGPoint(x: xConst + Int.random(in: -20...60), y: yConst)
            alienLayer.contents = alien.image.image?.cgImage
            alienShipsLayer.addSublayer(alienLayer)
            yConst += 60
            xConst += 50
        }

        alienShipsView.layer.addSublayer(alienShipsLayer)
    }
}

extension MainView {
    func animateAlienShipsMovement(view: UIView, to position: CGPoint, duration: TimeInterval = 5) {
        UIView.animate(withDuration: duration) {
            view.center = position
        }
    }

    func moveAlienShipsToNewPositions() {
        for subview in alienShipsView.subviews {
            if let alienShipView = subview as? UIImageView {
                let newPosition = getNewPositions(view: alienShipView)
                animateAlienShipsMovement(view: alienShipView, to: newPosition)
            }
        }
    }

    func getNewPositions(view: UIView) -> CGPoint {
        var newPosition: CGPoint
        let const = Int.random(in: -5...20)
        let newX = view.center.x + CGFloat(const)
        let newY = view.center.y
        newPosition = CGPoint(x: newX, y: newY)
        return newPosition
    }
}
