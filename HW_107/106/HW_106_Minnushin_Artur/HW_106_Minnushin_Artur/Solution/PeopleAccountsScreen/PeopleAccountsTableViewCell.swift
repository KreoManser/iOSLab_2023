//
//  PeopleAccountsTableViewCell.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 21.12.2023.
//

import UIKit
protocol PeopleAccountsProtocols: AnyObject {
    func updateFriends(userId: Int)
}

class PeopleAccountsTableViewCell: UITableViewCell {
    var subscribeCheker: Bool?
    var delegate: PeopleAccountsProtocols?
    var userId: Int?
    let coreDataManager = CoreDataManager.shared
    lazy var userAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    lazy var subscribeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .lightGray
        button.setTitle("Подписаться", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        let action = UIAction { _ in
            self.delegate?.updateFriends(userId: self.userId!)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userAvatarImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(subscribeButton)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupButton() {
        if coreDataManager.authorizationUser!.userId == userId! {
            subscribeButton.setTitle("Это вы", for: .normal)
            subscribeButton.backgroundColor = .cyan
            subscribeButton.setTitleColor(.black, for: .normal)
            return
        }
        if subscribeCheker == true {
            subscribeButton.setTitle("Вы подписаны", for: .normal)
            subscribeButton.backgroundColor = .darkGray
            return
        } else {
            subscribeButton.setTitle("Подписаться", for: .normal)
            subscribeButton.backgroundColor = .lightGray
            return
        }
    }
    func setupLayout() {
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 100),
            userAvatarImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            userAvatarImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            userAvatarImageView.heightAnchor.constraint(equalToConstant: 60),
            userAvatarImageView.widthAnchor.constraint(equalToConstant: 60),
            userNameLabel.centerYAnchor.constraint(equalTo: userAvatarImageView.centerYAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: userAvatarImageView.trailingAnchor, constant: 20),
            subscribeButton.widthAnchor.constraint(equalToConstant: 90),
            subscribeButton.heightAnchor.constraint(equalToConstant: 30),
            subscribeButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            subscribeButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}
