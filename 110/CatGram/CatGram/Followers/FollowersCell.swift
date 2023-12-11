//
//  FollowersCell.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 25.11.2023.
//

import UIKit

class FollowersCell: UITableViewCell {

    lazy var avatarImageView: UIImageView = {
        let avatarView = UIImageView()
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.layer.masksToBounds = true
        avatarView.layer.cornerRadius = 35 / 2
        return avatarView
    }()

    lazy var userNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()

    lazy var statusButton: UIButton = {
        let statusButton = UIButton()
        statusButton.backgroundColor = .lightGray
        statusButton.clipsToBounds = true
        statusButton.layer.cornerRadius = 12
        statusButton.setTitle("Подписан", for: .normal)
        statusButton.setTitleColor(.black, for: .normal)
        statusButton.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        return statusButton
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configFollower(withFollower follower: Follower) {
        avatarImageView.image = follower.avatar
        userNameLabel.text = follower.userName
        statusButton.titleLabel?.text = follower.status
    }

    private func setUpLayout() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(statusButton)

        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            avatarImageView.widthAnchor.constraint(equalToConstant: 35),
            avatarImageView.heightAnchor.constraint(equalToConstant: 35),

            userNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 30),

            statusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            statusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            statusButton.widthAnchor.constraint(equalToConstant: 90),
            statusButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

