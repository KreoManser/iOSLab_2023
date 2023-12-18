//
//  ProfileScrollView.swift
//  106Tukaev
//
//  Created by surexnx on 30.10.2023.
//

import UIKit

class ProfileScrollView: UIScrollView, UICollectionViewDelegateFlowLayout {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.itemSize = CGSize(width: 0, height: 100) // Ширина будет установлена позже

        let colleсtionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colleсtionView.register(PublicationCollectionViewCell.self, forCellWithReuseIdentifier: PublicationCollectionViewCell.reuseIdentificator)
        colleсtionView.translatesAutoresizingMaskIntoConstraints = false
        colleсtionView.isScrollEnabled = false
        return colleсtionView
    }()

    lazy var userImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 50
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
        return label
    }()

    lazy var publicationNumLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var subscribersLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var subscribersNumLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var subscriptionsLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var subscriptionsNumLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var professionalPanelButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var editProfileButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var shareProfileButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var publicationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [publicationLabel, publicationNumLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()

    lazy var subscribersStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [subscribersLabel, subscribersNumLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()

    lazy var subscribtionsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [subscriptionsLabel, subscriptionsNumLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()

    lazy var labelHorizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [publicationStackView, subscribersStackView, subscribtionsStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        return stackView
    }()

    lazy var buttonHorizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [editProfileButton, shareProfileButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        return stackView
    }()

    lazy var buttonVerticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [professionalPanelButton, buttonHorizontalStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureUser()
        configureProfile()
        setupLayout()
        let collectionViewWidth = collectionView.bounds.width
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.itemSize = CGSize(width: collectionViewWidth / 3, height: 100)
            }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureProfile() {
        publicationLabel.text = "Пукликации"
        subscribersLabel.text = "Подписчики"
        subscriptionsLabel.text = "Подписки"
        editProfileButton.setTitle("Редактировать профиль", for: .normal)
        shareProfileButton.setTitle("Поделиться профилем", for: .normal)
        professionalPanelButton.setTitle("Профессиональная Панель", for: .normal)
        userImage.image = UIImage(systemName: "person.crop.circle")
    }

    private func configureUser() {
        publicationNumLabel.text = "10"
        subscribersNumLabel.text = "24"
        subscriptionsNumLabel.text = "55"
        nameLabel.text = "Айдар"
    }

    private func addSubviews(_ subview: UIView...) {
        subview.forEach { addSubview($0) }
    }

    private func setupLayout() {
        addSubviews(userImage, labelHorizontalStackView, nameLabel, buttonVerticalStackView, collectionView)

        NSLayoutConstraint.activate([
            userImage.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor, constant: 20),
            userImage.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor, constant: 20),
            userImage.heightAnchor.constraint(equalToConstant: 40),
            userImage.widthAnchor.constraint(equalToConstant: 40),

            labelHorizontalStackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor, constant: 0),
            labelHorizontalStackView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor, constant: 40),

            nameLabel.topAnchor.constraint(equalTo: userImage.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor, constant: 20),

            buttonVerticalStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            buttonVerticalStackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor, constant: 20),
            buttonVerticalStackView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor, constant: 20),

            collectionView.topAnchor.constraint(equalTo: buttonVerticalStackView.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor)
        ])
    }
}
