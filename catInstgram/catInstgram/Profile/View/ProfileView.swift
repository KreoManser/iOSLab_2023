//
//  ProfileView.swift
//  catInstgram
//
//  Created by marwa awwad mohamed awwad on 22/12/2023.
//

import UIKit

class ProfileView: UIView {

        // MARK: - UI elements
        private lazy var userNicknameLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 20)
            return label
        }()

        private lazy var addPostButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(systemName: "plus.app")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 24)), for: .normal)
            button.imageView?.tintColor = .white
            return button
        }()

        private lazy var userMenuButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(systemName: "line.horizontal.3.circle")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 24)), for: .normal)
            button.imageView?.tintColor = .white
            return button
        }()

        private lazy var userAvatarImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.masksToBounds = true
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 40
            return imageView
        }()

        private lazy var userNameLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Kamil Khairutdinov"
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 15)
            return label
        }()

        private lazy var userStatistickStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [userPublicationsStackview, userSubscribersStackview, userSubscriptionsStackview])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.distribution = .fillEqually
            return stackView
        }()

        private lazy var userPublicationsStackview: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [numberOfPublicationLabel, publicationLabel])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.alignment = .center
            return stackView
        }()

        private lazy var publicationLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Публикации"
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = .white
            return label
        }()

        private lazy var numberOfPublicationLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.boldSystemFont(ofSize: 14)
            label.textColor = .white
            return label
        }()

        private lazy var userSubscribersStackview: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [numberOfSubscribersLabel, subscribersLabel])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.distribution = .fill
            return stackView
        }()

        private lazy var subscribersLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Подписчики"
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = .white
            return label
        }()

        private lazy var numberOfSubscribersLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.boldSystemFont(ofSize: 14)
            label.textColor = .white
            return label
        }()

        private lazy var userSubscriptionsStackview: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [numberOfSubscriptionsLabel, subscriptionsLabel])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.distribution = .fill
            return stackView
        }()

        private lazy var subscriptionsLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Подписки"
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = .white
            return label
        }()

        private lazy var numberOfSubscriptionsLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.boldSystemFont(ofSize: 14)
            label.textColor = .white
            return label
        }()

        private lazy var editUserInfoButton: UIButton = {
            let button = UIButton(configuration: .gray())
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Редактировть профиль", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.setTitleColor(.lightGray, for: .highlighted)
            return button
        }()

        private lazy var postCollectionView: UICollectionView = {
            let layuot = UICollectionViewFlowLayout()
            layuot.minimumLineSpacing = 0
            layuot.minimumInteritemSpacing = 0

            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layuot)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.register(ProfilePostCollectionViewCell.self, forCellWithReuseIdentifier: ProfilePostCollectionViewCell.reuseIdentifier)
            collectionView.delegate = self
            collectionView.backgroundColor = .black
            return collectionView
        }()
        // MARK: - Variables
        weak var controller: ProfileViewController?

        var viewWigth: CGFloat = 0.0

        // MARK: - Init
        override init(frame: CGRect) {
            super.init(frame: frame)

            backgroundColor = .black
            addSubviews(subviews: userNicknameLabel, addPostButton, userMenuButton,
            userAvatarImageView, userNameLabel, userStatistickStackView, editUserInfoButton,
            postCollectionView)
            configureUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    }

    extension ProfileView {
        private func addSubviews(subviews: UIView...) {
            subviews.forEach { addSubview($0) }
        }

        func setupDataSourse(_ dataSource: UICollectionViewDataSource) {
            postCollectionView.dataSource = dataSource
        }

        func reloadData() {
            postCollectionView.reloadData()
        }

        private func configureUI() {
            NSLayoutConstraint.activate([
                userNicknameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
                userNicknameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),

                userAvatarImageView.topAnchor.constraint(equalTo: userNicknameLabel.bottomAnchor, constant: 20),
                userAvatarImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
                userAvatarImageView.heightAnchor.constraint(equalToConstant: 80),
                userAvatarImageView.widthAnchor.constraint(equalToConstant: 80),

                userMenuButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
                userMenuButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),

                addPostButton.trailingAnchor.constraint(equalTo: userMenuButton.leadingAnchor, constant: -10),
                addPostButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),

                userNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
                userNameLabel.topAnchor.constraint(equalTo: userAvatarImageView.bottomAnchor, constant: 20),

                userStatistickStackView.topAnchor.constraint(equalTo: userNicknameLabel.bottomAnchor, constant: 20),
                userStatistickStackView.leadingAnchor.constraint(equalTo: userAvatarImageView.trailingAnchor, constant: 20),
                userStatistickStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
                userStatistickStackView.heightAnchor.constraint(equalToConstant: 80),

                editUserInfoButton.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 20),
                editUserInfoButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
                editUserInfoButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),

                postCollectionView.topAnchor.constraint(equalTo: editUserInfoButton.bottomAnchor, constant: 20),
                postCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                postCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                postCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            ])
        }
    }

    extension ProfileView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        func collectionView(
            _ collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: frame.width / 3, height: frame.width / 3)
        }

        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            controller?.presentDetailScreen(indexPath)
        }
    }

    extension ProfileView {

        func configureProfile(with user: User) {

            userNicknameLabel.text = user.username
            userAvatarImageView.image = UIImage(named: user.avatar)
            userNameLabel.text = user.fullName
            numberOfPublicationLabel.text = String(user.posts.count)
            numberOfSubscriptionsLabel.text = String(user.subscriptions.count)
            numberOfSubscribersLabel.text = String(user.numberOfSubscribers)
        }

        func updateProfileData(with user: User) {
            numberOfPublicationLabel.text = String(user.posts.count)
            numberOfSubscriptionsLabel.text = String(user.subscriptions.count)
            numberOfSubscribersLabel.text = String(user.numberOfSubscribers)
        }

    }
