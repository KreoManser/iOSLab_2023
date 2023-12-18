//
//  UsersTableViewCell.swift
//  homework_11
//
//  Created by Кирилл Щёлоков on 17.12.2023.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
    lazy var cellImageView: UIImageView = UIImageView()
    lazy var nameLabel: UILabel = UILabel()
    lazy var subscribeButton: UIButton = UIButton()

    var subscribeFriend: ((_ user: User) -> Void)?
    var unSubscribeFriend: ((_ user: User) -> Void)?
    private var user: User?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpCellImageView()
        setUpSubscribeButton()
        setUpNameLabel()
    }

    func configure(with user: User, isSubscribed: Bool) {
        guard let imageData = user.avatarImage else {return}
        cellImageView.image = UIImage(data: imageData)
        nameLabel.text = user.login
        self.user = user
        if isSubscribed {
            subscribeButton.backgroundColor = UIColor.systemGray
            subscribeButton.setTitle("Отписаться", for: .normal)
        } else {
            subscribeButton.backgroundColor = UIColor.systemBlue
            subscribeButton.setTitle("Подписаться", for: .normal)
        }
    }

    func toggleSubsribition() {
        if subscribeButton.backgroundColor == UIColor.systemGray {
            subscribeButton.backgroundColor = UIColor.systemBlue
            subscribeButton.setTitle("Подписаться", for: .normal)
        } else {
            subscribeButton.backgroundColor = UIColor.systemGray
            subscribeButton.setTitle("Отписаться", for: .normal)
        }
    }

    private func setUpCellImageView() {
        contentView.addSubview(cellImageView)
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        cellImageView.contentMode = .scaleAspectFill
        cellImageView.clipsToBounds = true
        cellImageView.layer.cornerRadius = 15

        NSLayoutConstraint.activate([
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cellImageView.widthAnchor.constraint(equalToConstant: 30),
            cellImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func setUpSubscribeButton() {
        contentView.addSubview(subscribeButton)
        subscribeButton.layer.cornerRadius = 10
        subscribeButton.translatesAutoresizingMaskIntoConstraints = false

        let subscribeAction = UIAction { [weak self] _ in
            guard let user = self?.user else { return }
            if self?.subscribeButton.backgroundColor == UIColor.systemBlue {
                self?.subscribeFriend?(user)
            } else {
                self?.unSubscribeFriend?(user)
            }
        }

        subscribeButton.addAction(subscribeAction, for: .touchUpInside)

        NSLayoutConstraint.activate([
            subscribeButton.centerYAnchor.constraint(equalTo: cellImageView.centerYAnchor),
            subscribeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            subscribeButton.widthAnchor.constraint(equalToConstant: 150),
            subscribeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func setUpNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: cellImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: subscribeButton.leadingAnchor, constant: -10)
        ])
    }
}
