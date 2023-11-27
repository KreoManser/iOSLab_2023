//
//  SettingsView.swift
//  CatGram
//
//  Created by Mac on 2023-11-26.
//

import UIKit

class SettingsView: UIView {
    // MARK: - Declaration objects
    private let support = SupportFunctions()
    lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 48
        image.clipsToBounds = true
        image.image = UIImage(named: "cat1")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var changeIconButton: UIButton = {
        let button = support.createButton("Change icom")
        return button
    }()
    lazy var nameLabel: UILabel = {
        let label = support.createAmountLabel("Name")
        return label
    }()
    lazy var descriptionLabel: UILabel = {
        let label = support.createAmountLabel("About you")
        return label
    }()
    lazy var linkLabel: UILabel = {
        let label = support.createAmountLabel("Link")
        return label
    }()
    lazy var writeNameField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Change name"
        textField.textColor = .black
        textField.delegate = self
        return textField
    }()
    lazy var writeDescriptionField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Change info about you"
        textField.textColor = .black
        textField.delegate = self
        return textField
    }()
    lazy var writeLinkField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Change link"
        textField.textColor = .black
        textField.delegate = self
        return textField
    }()
    lazy var acceptButton: UIButton = {
        let button = support.createButton("Accept")
        return button
    }()

    // MARK: - Init
    init(frame: CGRect, user: User) {
        super.init(frame: frame)
        writeNameField.placeholder = user.nick
        writeDescriptionField.placeholder = user.description
        writeLinkField.placeholder = user.link
        support.setImageAsync(url: user.iconUrl, imageView: &iconImage)
        backgroundColor = .white
        setKeyboardAction()
        setupLayouts()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingsView {
    private func setupLayouts() {
        let labelsStackView = support.createSV([nameLabel, descriptionLabel, linkLabel], align: .leading)
        labelsStackView.spacing = 6
        let textFieldsStackView = support.createSV([writeNameField, writeDescriptionField, writeLinkField], align: .leading)
        textFieldsStackView.spacing = 11

        addSubview(iconImage)
        addSubview(changeIconButton)
        addSubview(labelsStackView)
        addSubview(textFieldsStackView)
        addSubview(acceptButton)

        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            iconImage.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            iconImage.widthAnchor.constraint(equalToConstant: 96),
            iconImage.heightAnchor.constraint(equalToConstant: 96),

            changeIconButton.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 10),
            changeIconButton.centerXAnchor.constraint(equalTo: iconImage.centerXAnchor),
            changeIconButton.widthAnchor.constraint(equalTo: iconImage.widthAnchor, multiplier: 1.5),

            labelsStackView.topAnchor.constraint(equalTo: changeIconButton.bottomAnchor, constant: 20),
            labelsStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            labelsStackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),

            textFieldsStackView.topAnchor.constraint(equalTo: labelsStackView.topAnchor),
            textFieldsStackView.leadingAnchor.constraint(equalTo: labelsStackView.trailingAnchor),
            textFieldsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),

            acceptButton.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: 20),
            acceptButton.centerXAnchor.constraint(equalTo: changeIconButton.centerXAnchor),
            acceptButton.widthAnchor.constraint(equalTo: changeIconButton.widthAnchor, multiplier: 1)
        ])
    }
}

extension SettingsView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    private func setKeyboardAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tapGesture)
    }
    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
}
