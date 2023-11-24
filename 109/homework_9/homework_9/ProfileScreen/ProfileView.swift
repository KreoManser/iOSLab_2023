//
//  ProfileView.swift
//  homework_6
//
//  Created by Кирилл Щёлоков on 29.10.2023.
//

import UIKit

class ProfileView: UIView, UICollectionViewDelegateFlowLayout {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()

    lazy var storiesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()

    lazy var accountNameLabel: UILabel = UILabel()

    lazy var buttonsStackView: UIStackView = UIStackView()
    lazy var createButton: UIButton = UIButton()
    lazy var optionsButton: UIButton = UIButton()

    lazy var logoImageView: UIImageView = UIImageView()
    private var logoImage: UIImage?

    lazy var infoHorizontalStackView: UIStackView = UIStackView()

    lazy var postsVerticalStackView: UIStackView = UIStackView()
    lazy var postsLabel: UILabel = UILabel()
    lazy var postsCountLabel: UILabel = UILabel()

    lazy var subscribersVerticalStackView: UIStackView = UIStackView()
    lazy var subscribersLabel: UILabel = UILabel()
    lazy var subscribersCountLabel: UILabel = UILabel()

    lazy var subscriptionsVerticalStackView: UIStackView = UIStackView()
    lazy var subscriptionsLabel: UILabel = UILabel()
    lazy var subscriptionsCountLabel: UILabel = UILabel()

    lazy var nameLabel: UILabel = UILabel()

    var optionsTapped: (() -> Void)?
    var friendsTapped: (() -> Void)?

    init(frame: CGRect, logoImage: UIImage, accountName: String) {
        super.init(frame: frame)
        self.logoImage = logoImage
        backgroundColor = .white
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpAccountNameLabel()
        setUpButtonsStackView()
        setUpCreateButton()
        setUpOptionsButton()
        setUplogoImageView()
        setUpInfoHorizontalStackView()
        seUpPostsVerticalStackView()
        seUpSubscribersVerticalStackView()
        seUpSubscriptionsVerticalStackView()
        setUpNameLabel()
        setUpStoriesCollectionView()
        setUpCollectionView()
    }

    private func setUpAccountNameLabel() {
        addSubview(accountNameLabel)
        accountNameLabel.translatesAutoresizingMaskIntoConstraints = false
        accountNameLabel.text = ProfileDataManager.shared.getAuthUser()?.login ?? ""
        accountNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        NSLayoutConstraint.activate([
            accountNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            accountNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ])
    }

    private func setUpButtonsStackView() {
        addSubview(buttonsStackView)
        buttonsStackView.axis = .horizontal
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.spacing = 20
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.alignment = .fill

        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            buttonsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 25),
            buttonsStackView.widthAnchor.constraint(equalToConstant: 70)
        ])
    }

    private func setUpCreateButton() {
        buttonsStackView.addSubview(createButton)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.setImage(UIImage(named: "plusIcon"), for: .normal)

        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: buttonsStackView.topAnchor),
            createButton.leadingAnchor.constraint(equalTo: buttonsStackView.leadingAnchor),
            createButton.widthAnchor.constraint(equalToConstant: 25),
            createButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }

    private func setUpOptionsButton() {
        buttonsStackView.addSubview(optionsButton)
        optionsButton.translatesAutoresizingMaskIntoConstraints = false
        optionsButton.setImage(UIImage(named: "optionsIcon"), for: .normal)

        NSLayoutConstraint.activate([
            optionsButton.topAnchor.constraint(equalTo: buttonsStackView.topAnchor),
            optionsButton.trailingAnchor.constraint(equalTo: buttonsStackView.trailingAnchor),
            optionsButton.widthAnchor.constraint(equalToConstant: 25),
            optionsButton.heightAnchor.constraint(equalToConstant: 25)
        ])

        let optionAction = UIAction { [weak self] _ in
            self?.optionsTapped?()
        }

        optionsButton.addAction(optionAction, for: .touchUpInside)
    }

    private func setUplogoImageView() {
        addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = logoImage
        logoImageView.layer.cornerRadius = 40
        logoImageView.clipsToBounds = true
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: accountNameLabel.bottomAnchor, constant: 10),
            logoImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            logoImageView.widthAnchor.constraint(equalToConstant: 80),
            logoImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    private func setUpInfoHorizontalStackView() {
        addSubview(infoHorizontalStackView)
        infoHorizontalStackView.axis = .horizontal
        infoHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        infoHorizontalStackView.distribution = .fillEqually
        infoHorizontalStackView.alignment = .fill

        NSLayoutConstraint.activate([
            infoHorizontalStackView.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            infoHorizontalStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            infoHorizontalStackView.heightAnchor.constraint(equalToConstant: 40),
            infoHorizontalStackView.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 30)
        ])
    }

    private func seUpPostsVerticalStackView() {
        infoHorizontalStackView.addSubview(postsVerticalStackView)
        postsVerticalStackView.axis = .vertical
        postsVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        postsVerticalStackView.spacing = 5
        postsVerticalStackView.distribution = .fillEqually
        postsVerticalStackView.alignment = .center

        NSLayoutConstraint.activate([
            postsVerticalStackView.topAnchor.constraint(equalTo: infoHorizontalStackView.topAnchor),
            postsVerticalStackView.leadingAnchor.constraint(equalTo: infoHorizontalStackView.leadingAnchor),
            postsVerticalStackView.heightAnchor.constraint(equalToConstant: 40),
            postsVerticalStackView.widthAnchor.constraint(equalToConstant: 72)
        ])
        setUpPostsCountLabel()
        setUpPostsLabel()
    }

    private func seUpSubscribersVerticalStackView() {
        infoHorizontalStackView.addSubview(subscribersVerticalStackView)
        subscribersVerticalStackView.axis = .vertical
        subscribersVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        subscribersVerticalStackView.spacing = 5
        subscribersVerticalStackView.distribution = .fillEqually
        subscribersVerticalStackView.alignment = .center

        NSLayoutConstraint.activate([
            subscribersVerticalStackView.topAnchor.constraint(equalTo: infoHorizontalStackView.topAnchor),
            subscribersVerticalStackView.leadingAnchor.constraint(equalTo: postsVerticalStackView.trailingAnchor, constant: 4),
            subscribersVerticalStackView.heightAnchor.constraint(equalToConstant: 40),
            subscribersVerticalStackView.widthAnchor.constraint(equalToConstant: 72)
        ])
        setUpSubscribersCountLabel()
        setUpSubscribersLabel()
    }

    private func seUpSubscriptionsVerticalStackView() {
        infoHorizontalStackView.addSubview(subscriptionsVerticalStackView)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(friendsShowAction))
        subscriptionsVerticalStackView.addGestureRecognizer(tapRecognizer)
        subscriptionsVerticalStackView.axis = .vertical
        subscriptionsVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        subscriptionsVerticalStackView.spacing = 5
        subscriptionsVerticalStackView.distribution = .fillEqually
        subscriptionsVerticalStackView.alignment = .center

        NSLayoutConstraint.activate([
            subscriptionsVerticalStackView.topAnchor.constraint(equalTo: infoHorizontalStackView.topAnchor),
            subscriptionsVerticalStackView.trailingAnchor.constraint(equalTo: infoHorizontalStackView.trailingAnchor),
            subscriptionsVerticalStackView.heightAnchor.constraint(equalToConstant: 40),
            subscriptionsVerticalStackView.widthAnchor.constraint(equalToConstant: 72)
        ])
        setUpSubscriptionsCountLabel()
        setUpSubscriptionsLabel()
    }

    private func setUpPostsCountLabel() {
        postsVerticalStackView.addArrangedSubview(postsCountLabel)
        postsCountLabel.text = "11"
    }

    private func setUpPostsLabel() {
        postsVerticalStackView.addArrangedSubview(postsLabel)
        postsLabel.font = UIFont.systemFont(ofSize: 11)
        postsLabel.text = "Публикации"
    }

    private func setUpSubscribersCountLabel() {
        subscribersVerticalStackView.addArrangedSubview(subscribersCountLabel)
        subscribersCountLabel.text = "100"
    }

    private func setUpSubscribersLabel() {
        subscribersVerticalStackView.addArrangedSubview(subscribersLabel)
        subscribersLabel.font = UIFont.systemFont(ofSize: 11)
        subscribersLabel.text = "Подписчики"
    }

    private func setUpSubscriptionsCountLabel() {
        subscriptionsVerticalStackView.addArrangedSubview(subscriptionsCountLabel)
        subscriptionsCountLabel.text = "3"
    }

    private func setUpSubscriptionsLabel() {
        subscriptionsVerticalStackView.addArrangedSubview(subscriptionsLabel)
        subscriptionsLabel.font = UIFont.systemFont(ofSize: 11)
        subscriptionsLabel.text = "Подписки"
    }

    private func setUpNameLabel() {
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel.text = ProfileDataManager.shared.getAuthUser()?.login.lowercased()
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: logoImageView.leadingAnchor)
        ])
    }

    private func setUpStoriesCollectionView() {
        addSubview(storiesCollectionView)
        storiesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        storiesCollectionView.showsHorizontalScrollIndicator = false
        NSLayoutConstraint.activate([
            storiesCollectionView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            storiesCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 2),
            storiesCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -2),
            storiesCollectionView.heightAnchor.constraint(equalToConstant: 65)
        ])
    }

    private func setUpCollectionView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 80),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 2),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -2),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc
    private func friendsShowAction() {
        friendsTapped?()
    }
}
