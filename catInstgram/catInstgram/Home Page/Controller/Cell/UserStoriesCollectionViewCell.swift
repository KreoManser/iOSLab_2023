//
//  UserStoriesCollectionViewCell.swift
//  catInstgram
//
//  Created by marwa awwad mohamed awwad on 22/12/2023.
//

import UIKit

class UserStoriesCollectionViewCell: UICollectionViewCell {
    // MARK: - UI elements
    private lazy var userAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = .none
        return imageView
    }()

    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()

    private lazy var plusImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "plus.circle.fill"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image?.withTintColor(.blue)
        return imageView
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .black
        addSubviews(subviews: userAvatarImageView, userNameLabel, plusImageView)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension UserStoriesCollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    private func addSubviews(subviews: UIView...) {
        subviews.forEach { contentView.addSubview($0) }
    }

    private func configureUI() {
        NSLayoutConstraint.activate([
            userAvatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            userAvatarImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            userAvatarImageView.widthAnchor.constraint(equalToConstant: 80),
            userAvatarImageView.heightAnchor.constraint(equalToConstant: 80),

            userNameLabel.topAnchor.constraint(equalTo: userAvatarImageView.bottomAnchor, constant: 10),
            userNameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 2),
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -2),

            plusImageView.trailingAnchor.constraint(equalTo: userAvatarImageView.trailingAnchor, constant: 2),
            plusImageView.bottomAnchor.constraint(equalTo: userAvatarImageView.bottomAnchor, constant: 2),
            plusImageView.widthAnchor.constraint(equalToConstant: 30),
            plusImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    func configureCell(with user: User) {
        userAvatarImageView.image = UIImage(named: user.avatar)
        userNameLabel.text = user.username
        plusImageView.isHidden = true
    }

    func configureCellForCurrentUser() {
        userAvatarImageView.image = UIImage(named: DataManager.shared.syncGetCurrentUser().avatar)
        userNameLabel.text = "your history"
    }

}

