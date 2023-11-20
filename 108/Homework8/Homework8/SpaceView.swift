//
//  SpaceView.swift
//  Homework8
//
//  Created by kerik on 20.11.2023.
//

import UIKit

class SpaceView: UIView {
    var animator: UIViewPropertyAnimator?

    var aliens: [UIImageView] = []

    private lazy var spaceBackground: UIImageView = {
        let image = UIImageView(image: UIImage(named: "space1"))
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .clear
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var spaceshipView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "ship"))
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
        slider.isEnabled = false
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        return slider
    }()

    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var startButton: UIButton = {
        let action = UIAction { [weak self] _ in
            self?.setupAliens()
            self?.startButton.removeFromSuperview()
            self?.slider.isEnabled = true
        }
        let button = UIButton()
        button.addAction(action, for: .touchUpInside)
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        scoreLabel.text = "0"
        addSubviews(subviews: spaceBackground, slider, spaceshipView, scoreLabel, startButton)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func sliderValueChanged(_ slider: UISlider) {
        let newPositionX = CGFloat(slider.value) * (slider.frame.width - spaceshipView.frame.width)

        UIView.animate(withDuration: 0.1) {
            self.spaceshipView.frame.origin.x = newPositionX
        }
    }
}

extension SpaceView {
    private func addSubviews(subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            spaceBackground.topAnchor.constraint(equalTo: topAnchor),
            spaceBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            spaceBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            spaceBackground.bottomAnchor.constraint(equalTo: bottomAnchor),

            slider.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -70),
            slider.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            slider.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),

            spaceshipView.bottomAnchor.constraint(equalTo: slider.bottomAnchor, constant: 30),
            spaceshipView.centerXAnchor.constraint(equalTo: slider.centerXAnchor),
            spaceshipView.widthAnchor.constraint(equalToConstant: 100),
            spaceshipView.heightAnchor.constraint(equalToConstant: 100),

            scoreLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            scoreLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),

            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 100),
            startButton.heightAnchor.constraint(equalToConstant: 50)

        ])
    }
}

extension SpaceView {
    func setupAliens() {
        for i in 0..<5 {
            let alienImageView = UIImageView(image: UIImage(named: "alien1"))
            alienImageView.frame = CGRect(x: CGFloat(60 * i + 20), y: 100, width: 80, height: 80)
            addSubview(alienImageView)
            aliens.append(alienImageView)
        }
        animateAliens()
    }

    func animateAliens() {
        for (index, alien) in aliens.enumerated() {
            let delay = Double(index) * 0.5
            UIView.animate(withDuration: 2.0, delay: delay, options: [.repeat, .autoreverse], animations: {
                alien.frame.origin.y += 200
            }, completion: nil)
        }
    }
}
