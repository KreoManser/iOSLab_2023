//
//  ProfileView.swift
//  HW_106
//
//  Created by Азат Зиганшин on 30.10.2023.
//

import UIKit

class ProfileView: UIView {

    private lazy var avatarImageView: UIImageView = {
        let imageView = RoundImageView()
        imageView.image = UIImage(named: "remy")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var publicationsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Публикации"
        return label
    }()

    lazy var publicationsNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    private lazy var subscribersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Подписчиков"
        return label
    }()

    private lazy var subscribersNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "582"
        return label
    }()

    private lazy var subscriptionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Подписки"
        return label
    }()

    private lazy var subscriptionsNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "124"
        return label
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Рэми"
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "У меня лапки"
        return label
    }()

    private lazy var editButton: UIButton = {
        var button = UIButton()
        button.setTitle("Редактировать профиль", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 239 / 255, green: 239 / 255, blue: 239 / 255, alpha: 1.0)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        return button
    }()

    lazy var photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let table = UICollectionView(frame: .zero, collectionViewLayout: layout)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier)
        return table
    }()

    weak var controller: ProfileViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        let postsViewController = PostsViewController(indexPath)
        controller?.navigationController?.pushViewController(postsViewController, animated: true)

    }

    func setupDataSourse(_ dataSource: UICollectionViewDataSource) {
        photoCollectionView.dataSource = dataSource
    }

    func setupLayout() {

        let publicationsStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [publicationsNumberLabel, publicationsLabel])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.spacing = 5
            stackView.alignment = .center
            return stackView
        }()

        let subscribersStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [subscribersNumberLabel, subscribersLabel])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.spacing = 5
            stackView.alignment = .center
            return stackView
        }()

        let subscriptionsStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [subscriptionsNumberLabel, subscriptionsLabel])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.spacing = 5
            stackView.alignment = .center
            return stackView
        }()

        let profileStat: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [publicationsStackView, subscribersStackView, subscriptionsStackView])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.spacing = 5
            stackView.distribution = .fillEqually
            return stackView
        }()

        addSubview(avatarImageView)
        addSubview(profileStat)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(editButton)
        addSubview(photoCollectionView)

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor),

            profileStat.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            profileStat.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            profileStat.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),

            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 5),

            descriptionLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),

            editButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            editButton.centerXAnchor.constraint(equalTo: centerXAnchor),

            photoCollectionView.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 10),
            photoCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)

        ])
    }
}
