//
//  CustomOptionItem.swift
//  homework_10
//
//  Created by Кирилл Щёлоков on 10.12.2023.
//

import UIKit

enum DescriptionStyle {
    case normal
    case red

    var textColor: UIColor {
        switch self {
        case .normal:
            return .black
        case .red:
            return .red
        }
    }
}

class CustomOptionItem: UIView {

    lazy var optionItemView: UIView = UIView()
    lazy var iconImageView: UIImageView = UIImageView()
    lazy var descriptionLabel: UILabel = UILabel()
    let style: DescriptionStyle

    var itemTapped: (() -> Void)?

    required init(frame: CGRect, iconImage: UIImage, description: String, style: DescriptionStyle) {
        self.style = style
        super.init(frame: frame)
        setUp(iconImage: iconImage, description: description)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp(iconImage: UIImage, description: String) {
        setUpOptionItemView()
        setUpIconImageView(image: iconImage)
        setUpDescriptionLabel(description: description)
    }

    private func setUpOptionItemView() {
        addSubview(optionItemView)
        optionItemView.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(itemTappedAction))
        optionItemView.addGestureRecognizer(tapGesture)
        optionItemView.isUserInteractionEnabled = true

        NSLayoutConstraint.activate([
            optionItemView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            optionItemView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            optionItemView.topAnchor.constraint(equalTo: topAnchor),
            optionItemView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setUpIconImageView(image: UIImage) {
        optionItemView.addSubview(iconImageView)
        iconImageView.image = image
        iconImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: optionItemView.leadingAnchor, constant: 10),
            iconImageView.topAnchor.constraint(equalTo: optionItemView.topAnchor, constant: 10),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            iconImageView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func setUpDescriptionLabel(description: String) {
        optionItemView.addSubview(descriptionLabel)
        descriptionLabel.text = description
        descriptionLabel.textColor = style.textColor
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: optionItemView.trailingAnchor, constant: -10),
            descriptionLabel.centerYAnchor.constraint(equalTo: optionItemView.centerYAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    @objc
    private func itemTappedAction(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            self.itemTapped?()
        }
    }
}
