//
//  OptionsView.swift
//  homework_9
//
//  Created by Кирилл Щёлоков on 24.11.2023.
//

import UIKit

class OptionsView: UIView {

    private lazy var optionsStackView: UIStackView = UIStackView()

    lazy var optionItem: CustomOptionItem = CustomOptionItem(
        frame: bounds,
        iconImage: UIImage(systemName: "gearshape") ?? .question,
        description: "Настройки аккаунта", style: .normal)
    lazy var exitItem: CustomOptionItem = CustomOptionItem(
        frame: bounds,
        iconImage: UIImage(systemName: "person.crop.circle.badge.xmark") ?? .question,
        description: "Выйти из аккаунта", style: .red)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpOptionsStackView()
    }

    private func setUpOptionsStackView() {
        addSubview(optionsStackView)
        optionsStackView.addArrangedSubview(optionItem)
        optionsStackView.addArrangedSubview(exitItem)

        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        optionsStackView.axis = .vertical
        optionsStackView.distribution = .fillEqually
        optionsStackView.spacing = 10

        NSLayoutConstraint.activate([
            optionsStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            optionsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            optionsStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            optionsStackView.heightAnchor.constraint(equalToConstant: CGFloat(optionsStackView.arrangedSubviews.count) * 50)
        ])
    }
}
