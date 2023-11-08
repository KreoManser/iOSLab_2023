//
//  ProfileView.swift
//  Homework6
//
//  Created by kerik on 29.10.2023.
//

import UIKit

class ProfileView: UIView {
    private lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.frame.size = CGSize(width: 100, height: 100)
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var profileUserName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            createVerticalStackView(labels: [countOfPublications, publicationsLabel]),
            createVerticalStackView(labels: [countOfFollowers, followersLabel]),
            createVerticalStackView(labels: [countOfSubscribes, subscribesLabel])
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 3
        stackView.axis = .horizontal
        return stackView
    }()

    private lazy var countOfPublications: UILabel = {
        createlabel(text: "")
    }()

    private lazy var publicationsLabel: UILabel = {
        createlabel(text: "Публикации")
    }()

    private lazy var countOfFollowers: UILabel = {
        createlabel(text: "")
    }()

    private lazy var followersLabel: UILabel = {
        createlabel(text: "Подписчики")
    }()

    private lazy var countOfSubscribes: UILabel = {
        createlabel(text: "2")
    }()

    private lazy var subscribesLabel: UILabel = {
        createlabel(text: "Подписки")
    }()

    private lazy var exitButton: UIButton = {
        let action = UIAction { [weak self] _ in
            self?.controller?.setExitAction()
        }

        let button = UIButton()
        button.addAction(action, for: .touchUpInside)
        button.setTitle("Выйти", for: .normal)
        button.backgroundColor = .systemGray5
        button.setTitleColor(.red, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Редактировать", for: .normal)
        button.backgroundColor = .systemGray5
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [editButton, exitButton])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var photoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.register(PhotoViewCell.self, forCellWithReuseIdentifier: PhotoViewCell.reuseIdentifier)
        return collectionView
    }()

    weak var controller: ProfileViewController?

    private var viewFrame: CGRect

    init(viewWidth: CGRect) {
        viewFrame = viewWidth
        super.init(frame: .zero)

        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(subviews: profileImage, profileUserName, horizontalStackView, buttonsStackView, photoCollectionView)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileView {
    private func addSubviews(subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            profileImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),

            profileUserName.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            profileUserName.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),

            horizontalStackView.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
            horizontalStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            horizontalStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),

            buttonsStackView.topAnchor.constraint(equalTo: profileUserName.bottomAnchor, constant: 10),
            buttonsStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            buttonsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),

            photoCollectionView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 10),
            photoCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            photoCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            photoCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }
}

extension ProfileView {
    private func createlabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13)
        return label
    }

    private func createVerticalStackView(labels: [UILabel]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: labels)
        stackView.spacing = 3
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }
}

extension ProfileView {
    func setupDataSource(_ dataSource: UICollectionViewDataSource) {
        photoCollectionView.dataSource = dataSource
    }

    func reloadData() {
        photoCollectionView.reloadData()
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
        profileImage.image = UIImage(named: user.avatar)
        profileUserName.text = user.fullName
        countOfPublications.text = String(user.posts.count)
        countOfFollowers.text = String(user.numberOfSubscribers)
    }

    func updateProfileData(with user: User) {
        countOfPublications.text = String(user.posts.count)
        countOfFollowers.text = String(user.numberOfSubscribers)
    }
}
