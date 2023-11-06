//
//  ProfileCollectionViewCell.swift
//  106Tukaev
//
//  Created by surexnx on 01.11.2023.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {

    lazy var userImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 40
        image.clipsToBounds = true
        return image
    }()

    lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var publicationLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    lazy var publicationNumLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    lazy var subscribersLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    lazy var subscribersNumLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    lazy var subscriptionsLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    lazy var subscriptionsNumLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    lazy var professionalPanelButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 5
        return button
    }()

    lazy var editProfileButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 5
        return button
    }()

    lazy var shareProfileButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 5
        return button
    }()

    lazy var publicationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [publicationNumLabel, publicationLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()

    lazy var subscribersStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [subscribersNumLabel, subscribersLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()

    lazy var subscribtionsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [subscriptionsNumLabel, subscriptionsLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()

    lazy var labelHorizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [publicationStackView, subscribersStackView, subscribtionsStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 3
        return stackView
    }()

    lazy var buttonHorizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [editProfileButton, shareProfileButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10

        return stackView
    }()

    lazy var buttonVerticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [professionalPanelButton, buttonHorizontalStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10

        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        configureProfile()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureProfile() {
        publicationLabel.text = "Публикации"
        publicationLabel.font = UIFont.systemFont(ofSize: 12)

        publicationNumLabel.font = UIFont.systemFont(ofSize: 17)
        subscribersNumLabel.font = UIFont.systemFont(ofSize: 17)
        subscriptionsNumLabel.font = UIFont.systemFont(ofSize: 17)

        subscribersLabel.text = "Подписчики"
        subscribersLabel.font = UIFont.systemFont(ofSize: 12)

        subscriptionsLabel.text = "Подписки"
        subscriptionsLabel.font = UIFont.systemFont(ofSize: 12)

        editProfileButton.setTitle("Редактировать профиль", for: .normal)

        shareProfileButton.setTitle("Поделиться профилем", for: .normal)

        professionalPanelButton.setTitle("Профессиональная Панель", for: .normal)

        userImage.image = UIImage(named: "user")
    }

    private func addSubviews(_ subview: UIView...) {
        subview.forEach { addSubview($0) }
    }
    func configureCell(with user: User) {
        self.publicationNumLabel.text = String(user.publicationsCount)
        self.subscribersNumLabel.text = String(user.subsribersCount)
        self.subscriptionsNumLabel.text = String(user.subcriptionCount)
        self.nameLabel.text = user.userName
    }

    private func setupLayout() {
        addSubviews(userImage, labelHorizontalStackView, nameLabel, buttonVerticalStackView)
        let content = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            userImage.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 20),
            userImage.topAnchor.constraint(equalTo: content.topAnchor, constant: 20),
            userImage.heightAnchor.constraint(equalToConstant: 80),
            userImage.widthAnchor.constraint(equalToConstant: 80),

            labelHorizontalStackView.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -20),
            labelHorizontalStackView.topAnchor.constraint(equalTo: content.topAnchor, constant: 40),

            nameLabel.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 20),

            buttonVerticalStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            buttonVerticalStackView.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -10),
            buttonVerticalStackView.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 10)
        ])
    }
}
extension ProfileCollectionViewCell {
    static var reuseIdentificator: String {
        return String(describing: self)
    }
}
