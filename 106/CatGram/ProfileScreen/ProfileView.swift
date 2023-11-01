//
//  ProfileView.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 29.10.2023.
//

import UIKit

class ProfileView: UIView, UICollectionViewDelegateFlowLayout {

    private lazy var profilePhoto: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "profile2.jpeg")
        image.layer.cornerRadius = 50
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.black.cgColor
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "lovelycats__"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray6
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var shareProfileButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray6
        button.setTitle("Share Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var collectionView: UICollectionView = {
         let layout = UICollectionViewFlowLayout()
         let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    private lazy var numberOfPosts: UILabel = {
        let label = UILabel()
        label.text = "3"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var postCountButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Posts", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var numberOfFollowers: UILabel = {
        let label = UILabel()
        label.text = "459"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var followersButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Followers", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var numberOfFollowing: UILabel = {
        let label = UILabel()
        label.text = "300"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var followingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Following", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let postStackView = UIStackView()
    let followersStackView = UIStackView()
    let followingStackView = UIStackView()
    let labelButtonStackView = UIStackView()


    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profilePhoto)
        addSubview(userNameLabel)
        addSubview(editButton)
        addSubview(shareProfileButton)
        addSubview(collectionView)
        addSubview(numberOfPosts)
        addSubview(postCountButton)
        addSubview(numberOfFollowers)
        addSubview(followersButton)
        addSubview(numberOfFollowing)
        addSubview(followingButton)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func  setupLayout() {

        NSLayoutConstraint.activate([
            profilePhoto.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
            profilePhoto.widthAnchor.constraint(equalToConstant: 100),
            profilePhoto.heightAnchor.constraint(equalToConstant: 100),
            profilePhoto.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            userNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            userNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5),
            editButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            editButton.topAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: 32),
            editButton.widthAnchor.constraint(equalToConstant: 150),

            shareProfileButton.leadingAnchor.constraint(equalTo: editButton.trailingAnchor, constant: 24),
            shareProfileButton.topAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: 32),
            shareProfileButton.widthAnchor.constraint(equalToConstant: 150),

            collectionView.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 60),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        setUpHorizontalStackView()
        setUpPostStackView()
        setUpFollowersStackView()
        setUpFollowingStackView()

    }

    private func setUpHorizontalStackView() {

        labelButtonStackView.axis = .horizontal
        labelButtonStackView.spacing = 6
        labelButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelButtonStackView)

        labelButtonStackView.addArrangedSubview(postStackView)
        labelButtonStackView.addArrangedSubview(followersStackView)
        labelButtonStackView.addArrangedSubview(followingStackView)

        NSLayoutConstraint.activate([
            labelButtonStackView.leadingAnchor.constraint(equalTo: profilePhoto.trailingAnchor, constant: 30),
            labelButtonStackView.topAnchor.constraint(equalTo: shareProfileButton.topAnchor, constant: -100),
            labelButtonStackView.heightAnchor.constraint(equalToConstant: 40),
            labelButtonStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }

    private func setUpPostStackView() {
        postStackView.axis = .vertical
        postStackView.alignment = .center
        postStackView.spacing = 1
        postStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(postStackView)

        NSLayoutConstraint.activate([
            postStackView.leadingAnchor.constraint(equalTo: labelButtonStackView.leadingAnchor),
            postStackView.topAnchor.constraint(equalTo: labelButtonStackView.topAnchor),
            postStackView.heightAnchor.constraint(equalToConstant: 40),
            postStackView.widthAnchor.constraint(equalToConstant: 72)
        ])

        postStackView.addArrangedSubview(numberOfPosts)
        postStackView.addArrangedSubview(postCountButton)
    }

    private func setUpFollowersStackView() {
        followersStackView.axis = .vertical
        followersStackView.alignment = .center
        followersStackView.spacing = 1
        followersStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(followersStackView)

        followersStackView.addArrangedSubview(numberOfFollowers)
        followersStackView.addArrangedSubview(followersButton)

        NSLayoutConstraint.activate([
            followersStackView.leadingAnchor.constraint(equalTo: postStackView.trailingAnchor, constant: -4),
            followersStackView.topAnchor.constraint(equalTo: labelButtonStackView.topAnchor),
            followersStackView.heightAnchor.constraint(equalToConstant: 40),
            followersStackView.widthAnchor.constraint(equalToConstant: 72)
        ])
    }
    private func setUpFollowingStackView() {
        followingStackView.axis = .vertical
        followingStackView.alignment = .center
        followingStackView.spacing = 1
        followingStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(followingStackView)

        followingStackView.addArrangedSubview(numberOfFollowing)
        followingStackView.addArrangedSubview(followingButton)

        NSLayoutConstraint.activate([
           // followingStackView.trailingAnchor.constraint(equalTo: labelButtonStackView.trailingAnchor),
            followingStackView.leadingAnchor.constraint(equalTo: followersStackView.trailingAnchor, constant: -4),
            followingStackView.topAnchor.constraint(equalTo: labelButtonStackView.topAnchor),
            followingStackView.heightAnchor.constraint(equalToConstant: 40),
            followingStackView.widthAnchor.constraint(equalToConstant: 72)
        ])
    }
}
