//
//  ProfileView.swift
//  New106
//
//  Created by Alina on 01.11.2023.
//

import UIKit

 class PublicationView: UIView, UICollectionViewDelegateFlowLayout {

     lazy var collectionView: UICollectionView = {
         let layout = UICollectionViewFlowLayout()

         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
         collectionView.translatesAutoresizingMaskIntoConstraints = false
         return collectionView
     }()

     lazy var usernameLabel: UILabel = {
         let label = UILabel()
         label.text = "radzhaaaCAT"
         label.font = UIFont.boldSystemFont(ofSize: 18)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
     
     lazy var settingsButton: UIButton = {
         let button = UIButton()
         button.translatesAutoresizingMaskIntoConstraints = false
         button.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
         button.tintColor = .black
         return button
     }()

     lazy var avatarImageView: UIImageView = {
         let image = UIImageView()
         image.translatesAutoresizingMaskIntoConstraints = false
         image.backgroundColor = .black
         image.image = UIImage(named: "7")
         image.layer.cornerRadius = 40
         image.clipsToBounds = true
         return image
     }()
     lazy var postsButton: UIButton = {
         let button = UIButton()
         button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
         button.setTitle("Публикации", for: .normal)
         button.setTitleColor(.black, for: .normal)
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
     }()
     lazy var postsCountLabel: UILabel = {
         let label = UILabel()
         label.text = "432"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()

     lazy var subscribersButton: UIButton = {
         let button = UIButton()
         button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
         button.setTitle("Подписчики", for: .normal)
         button.setTitleColor(.black, for: .normal)
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
     }()
     lazy var subscribersCountLabel: UILabel = {
         let label = UILabel()
         label.text = "102"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
     
     lazy var subscriptionsButton: UIButton = {
         let button = UIButton()
         button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
         button.setTitle("Подписки", for: .normal)
         button.setTitleColor(.black, for: .normal)
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
     }()
     lazy var subscriptionsCountLabel: UILabel = {
         let label = UILabel()
         label.text = "125"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()

     lazy var nameLabel: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.font = UIFont.boldSystemFont(ofSize: 14)
         label.text = "CATS"
         return label
     }()
     
     lazy var describeLabel: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.lineBreakMode = .byWordWrapping
         label.numberOfLines = 0
         label.text = "Добро пожаловать на самую милую страницу во всей кошачьей вселенной!🐾🐱"
         return label
     }()

     override init(frame: CGRect) {
         super.init(frame: frame)
         backgroundColor = .white
         setupLayout()
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

    

     private func setupLayout() {
         addSubview(usernameLabel)
         addSubview(avatarImageView)
         addSubview(settingsButton)
         addSubview(postsCountLabel)
         addSubview(subscribersCountLabel)
         addSubview(subscriptionsCountLabel)
         addSubview(postsButton)
         addSubview(subscribersButton)
         addSubview(subscriptionsButton)
         addSubview(nameLabel)
         addSubview(describeLabel)
         addSubview(collectionView)
         NSLayoutConstraint.activate([
            
            usernameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: -5),
            usernameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 10),
            
            avatarImageView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor,constant: 5),
            avatarImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 5),
            avatarImageView.bottomAnchor.constraint(equalTo: avatarImageView.topAnchor,constant: 80),
            avatarImageView.trailingAnchor.constraint(equalTo: avatarImageView.leadingAnchor,constant: 80),
            
            settingsButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: -5),
            settingsButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -10),
            
            postsCountLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 10),
            postsCountLabel.centerXAnchor.constraint(equalTo: postsButton.centerXAnchor),
            
            subscribersCountLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 10),
            subscribersCountLabel.centerXAnchor.constraint(equalTo: subscribersButton.centerXAnchor),
            
            subscriptionsCountLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 10),
            subscriptionsCountLabel.centerXAnchor.constraint(equalTo: subscriptionsButton.centerXAnchor),
            
            postsButton.topAnchor.constraint(equalTo: postsCountLabel.bottomAnchor),
            postsButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 135),
            
            subscribersButton.topAnchor.constraint(equalTo: subscribersCountLabel.bottomAnchor),
            subscribersButton.leadingAnchor.constraint(equalTo: postsCountLabel.trailingAnchor,constant: 35),
            
            subscriptionsButton.topAnchor.constraint(equalTo: subscriptionsCountLabel.bottomAnchor),
            subscriptionsButton.leadingAnchor.constraint(equalTo: subscribersCountLabel.trailingAnchor,constant: 35),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 10),
            
            describeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            describeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 10),
            describeLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor,constant: 20),
            
            collectionView.topAnchor.constraint(equalTo: collectionView.bottomAnchor,constant: -375),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        
         ])
     }
 }
