//
//  InstargramProfileView.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 02.11.2023.
//

import UIKit

class ProfileView: UIView {
    weak var profileViewController: ProfileViewController?
    let dataManager = DataManager.sigelton
    let coreDataManger = CoreDataManager.shared
    let user: User
    lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 45
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "gear"), for: .normal)
        let action = UIAction { _ in
            self.profileViewController?.settingsViewControllerPresent()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    lazy var countPostLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    lazy var countFollowersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    lazy var countFollowingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    lazy var postLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Посты"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    lazy var followersLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Подписано"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    lazy var followingLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Подписаны"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 23)
        return label
    }()
    lazy var subTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    lazy var photoCollectionImageView: UIImageView = {
        var imageView = UIImageView(image: UIImage(named: "photoCollecion"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var underliningLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        return label
    }()
    lazy var imageCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collection
    }()
    func configureCollection(dataSource: ProfileCollectionDataSource) {
        imageCollection.dataSource = dataSource
    }
    func reloadData() {
        imageCollection.reloadData()
    }
    func configureUserProfile() {
        avatarImage.image = UIImage(named: "\(user.userAvatarImageName)")
        countPostLabel.text = "\(String(describing: user.userCountPosts))"
        countFollowersLabel.text = "\(String(describing: user.userCountFolowers))"
        countFollowingLabel.text = "\(String(describing: user.userCountFolowing))"
        nameLabel.text = "\(String(describing: user.userName))"
        subTitle.text = "\(String(describing: user.userDescription))"
    }
    override init(frame: CGRect) {
        user = coreDataManger.getAuthorizationUser()
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(avatarImage)
        addSubview(settingsButton)
        addSubview(countPostLabel)
        addSubview(countFollowersLabel)
        addSubview(countFollowingLabel)
        addSubview(postLable)
        addSubview(followersLable)
        addSubview(followingLable)
        addSubview(nameLabel)
        addSubview(subTitle)
        addSubview(photoCollectionImageView)
        addSubview(underliningLabel)
        addSubview(imageCollection)
        configureUserProfile()
        setUpLayout()
    }
    func setUpLayout() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 65),
            nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            settingsButton.topAnchor.constraint(equalTo: topAnchor, constant: 70),
            settingsButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            settingsButton.widthAnchor.constraint(equalToConstant: 20),
            settingsButton.heightAnchor.constraint(equalToConstant: 20),
            avatarImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            avatarImage.heightAnchor.constraint(equalToConstant: 90),
            avatarImage.widthAnchor.constraint(equalToConstant: 90),
            avatarImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                                  constant: 110),
            countPostLabel.topAnchor.constraint(equalTo: avatarImage.topAnchor, constant: 20),
            countPostLabel.centerXAnchor.constraint(equalTo: postLable.centerXAnchor),
            countFollowersLabel.topAnchor.constraint(equalTo: avatarImage.topAnchor, constant: 20),
            countFollowersLabel.centerXAnchor.constraint(equalTo: followersLable.centerXAnchor),
            countFollowingLabel.topAnchor.constraint(equalTo: avatarImage.topAnchor, constant: 20),
            countFollowingLabel.centerXAnchor.constraint(equalTo: followingLable.centerXAnchor),
            postLable.topAnchor.constraint(equalTo: countPostLabel.topAnchor, constant: 35),
            postLable.trailingAnchor.constraint(equalTo: avatarImage.leadingAnchor, constant: 160),
            followersLable.topAnchor.constraint(equalTo: countFollowersLabel.topAnchor, constant: 35),
            followersLable.trailingAnchor.constraint(equalTo: postLable.leadingAnchor, constant: 135),
            followingLable.topAnchor.constraint(equalTo: countFollowingLabel.topAnchor, constant: 35),
            followingLable.trailingAnchor.constraint(equalTo: followersLable.leadingAnchor, constant: 155),
            subTitle.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 15),
            subTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            subTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            photoCollectionImageView.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 20),
            photoCollectionImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            photoCollectionImageView.widthAnchor.constraint(equalToConstant: 30),
            photoCollectionImageView.heightAnchor.constraint(equalToConstant: 30),
            underliningLabel.topAnchor.constraint(equalTo: photoCollectionImageView.bottomAnchor, constant: 10),
            underliningLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            underliningLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            underliningLabel.heightAnchor.constraint(equalToConstant: 1),
            imageCollection.topAnchor.constraint(equalTo: underliningLabel.bottomAnchor, constant: 10),
            imageCollection.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            imageCollection.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            imageCollection.bottomAnchor.constraint(equalTo:
                safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/3 - 15,
                      height: frame.width/3 - 15)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        profileViewController?.postsViewControllerPresnt(indexPath: indexPath)
    }
}
