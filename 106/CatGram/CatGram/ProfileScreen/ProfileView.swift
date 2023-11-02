//
//  ProfileView.swift
//  CatGram
//
//  Created by Аделя Миннехузина on 31.10.2023.
//

import UIKit

class ProfileView: UIView {

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "description"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "cat's name"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 23)
        return label
    }()

    private lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 40
        image.image = UIImage(named: "profile")
        return image
    }()

    private lazy var numberOfPostsLabel: UILabel = {
        let label = UILabel()
        label.text = "6"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()

    private lazy var postsLabel: UILabel = {
        let label = UILabel()
        label.text = "Публикации"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()

    private lazy var postsStackview: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [numberOfPostsLabel, postsLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()

    private lazy var numberOfFollowersLabel: UILabel = {
        let label = UILabel()
        label.text = "600"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()

    private lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.text = "Подписчики"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()

    private lazy var followersStackview: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [numberOfFollowersLabel, followersLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var numberOfFollowingLabel: UILabel = {
        let label = UILabel()
        label.text = "6000"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()

    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.text = "Подписки"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()

    private lazy var followingStackview: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [numberOfFollowingLabel, followingLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var statistickStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [postsStackview, followersStackview, followingStackview])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var addPostButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "plus"), for: .normal)
        return button
    }()

    private lazy var editButton: UIButton = {
        let button = UIButton(configuration: .gray())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Редактировать профиль", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        return button
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.backgroundColor = .black
        return collectionView
    }()

    private func setupLayout() {
        NSLayoutConstraint.activate([

            descriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            descriptionLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),

            nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),

            profileImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            profileImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),

            addPostButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            addPostButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            addPostButton.widthAnchor.constraint(equalToConstant: 20),
            addPostButton.heightAnchor.constraint(equalToConstant: 20),

            statistickStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            statistickStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20),
            statistickStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            statistickStackView.heightAnchor.constraint(equalToConstant: 80),

            editButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            editButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            editButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),

            collectionView.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    weak var controller: ProfileViewController?

    var viewWigth: CGFloat = 0.0

    private func addSubviews(subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubviews(subviews: nameLabel, addPostButton,
        profileImageView, descriptionLabel, statistickStackView, editButton, collectionView)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupDataSourse(_ dataSource: UICollectionViewDataSource) {
        collectionView.dataSource = dataSource
    }

    func reloadData() {
        collectionView.reloadData()
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
