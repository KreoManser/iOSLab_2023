//
//  SupportFunctions.swift
//  CatGram
//
//  Created by Mac on 2023-10-30.
//

import UIKit

class SupportFunctions {
    func createSV(_ elements: [UIView], axis: NSLayoutConstraint.Axis = .vertical, align: UIStackView.Alignment = .center) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: elements)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.alignment = align
        return stackView
    }
    func createAmountLabel(_ title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    func createDescriptionLabel(_ title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }
    func createButton(_ title: String) -> UIButton {
        let button = UIButton()
        var config = UIButton.Configuration.gray()
        let container = AttributeContainer([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)])
        let attribString = AttributedString(title, attributes: container)
        config.attributedTitle = attribString
        config.baseForegroundColor = .black
        config.cornerStyle = .medium
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    func createButtonWithImage(_ image: UIImage) -> UIButton {
        let button = UIButton()
        button.setImage(image.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
        button.imageView?.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    func formateDataToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMMM"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}
