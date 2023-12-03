//
//  FriendTableViewCell.swift
//  CatGram
//
//  Created by Mac on 2023-12-03.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    private lazy var iconImageView: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFill
        icon.clipsToBounds = true
        icon.layer.cornerRadius = 15
        return icon
    }()
    private lazy var nameLabel: UILabel = {
        let label = support.createAmountLabel("title")
        return label
    }()
    private lazy var followButton: UIButton = UIButton()
    private let support = SupportFunctions()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static var reuseIdentifier: String {
        return String(describing: self)
    }
    func configure(with user: User) {
        support.setImageAsync(url: user.iconUrl, imageView: &iconImageView)
        nameLabel.text = user.nick
    }

    private func setupLayouts() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(followButton)
        followButton.setImage(UIImage(systemName: "paperclip"), for: .normal)
        followButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),

            followButton.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            followButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            followButton.widthAnchor.constraint(equalToConstant: 30),
            followButton.heightAnchor.constraint(equalToConstant: 30),

            nameLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10)
        ])
    }
}

