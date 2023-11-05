//
//  FeedTableViewCell.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 04.11.2023.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    private lazy var mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.axis = .horizontal
        mainStackView.spacing = 10
        mainStackView.distribution = .fillEqually
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        return mainStackView
    }()
    private lazy var avatarImageView: UIImageView = {
        let subView = UIImageView()
        subView.clipsToBounds = true
        subView.layer.cornerRadius = 10
        subView.translatesAutoresizingMaskIntoConstraints = false
        return subView
    }()
    private lazy var userName: UILabel = {
        let subView = UILabel()
        subView.font = UIFont.systemFont(ofSize: 14)
        subView.translatesAutoresizingMaskIntoConstraints = false
        return subView
    }()
    private lazy var postImageView: UIImageView = {
            let subView = UIImageView()
            subView.translatesAutoresizingMaskIntoConstraints = false
            return subView
        }()
    private lazy var caption: UILabel = {
            let subView = UILabel()
            subView.font = UIFont.systemFont(ofSize: 10)
            subView.translatesAutoresizingMaskIntoConstraints = false
            return subView
        }()
    private lazy var likeButton: UIButton = {
            let subView = UIButton()
            subView.translatesAutoresizingMaskIntoConstraints = false
            subView.setImage(UIImage(named: "like"), for: .normal)
            return subView
        }()
    private lazy var sharePostButton: UIButton = {
            let subView = UIButton()
            subView.setImage(UIImage(named: "share"), for: .normal)
            subView.translatesAutoresizingMaskIntoConstraints = false
            return subView
        }()
    private lazy var commentButton: UIButton = {
            let subView = UIButton()
            subView.setImage(UIImage(named: "comment"), for: .normal)
            subView.translatesAutoresizingMaskIntoConstraints = false
            return subView
        }()
    private lazy var favButton: UIButton = {
            let subView = UIButton()
            subView.setImage(UIImage(named: "save"), for: .normal)
            subView.translatesAutoresizingMaskIntoConstraints = false
            return subView
        }()
    private lazy var commentLabel: UILabel = {
            let subView = UILabel()
            subView.text = "View all comments"
            subView.textColor = .gray
            subView.font = UIFont.systemFont(ofSize: 10)
            subView.translatesAutoresizingMaskIntoConstraints = false
            return subView
        }()
    private lazy var dateLabel: UILabel = {
            let subView = UILabel()
            subView.font = UIFont.systemFont(ofSize: 10)
            subView.translatesAutoresizingMaskIntoConstraints = false
            return subView
        }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setUp()
        }
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    func configureCell(with feedPost: Feed) {
        avatarImageView.image = feedPost.avatar
        userName.text = feedPost.userName
        postImageView.image = feedPost.photo
        caption.text = feedPost.caption
        dateLabel.text = feedPost.date
        }

   private func setUpAvatarImage() {
        addSubview(avatarImageView)
        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: 20),
            avatarImageView.widthAnchor.constraint(equalToConstant: 20),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
    }

    private func setUpUserName() {
        addSubview(userName)
        NSLayoutConstraint.activate([
            userName.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            userName.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        ])
    }

    private func setUpPostImageView() {
        addSubview(postImageView)
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: 250)
    ])
}

    private func setUpMainStackView() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(likeButton)
        mainStackView.addArrangedSubview(commentButton)
        mainStackView.addArrangedSubview(sharePostButton)

            NSLayoutConstraint.activate([
                mainStackView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 5),
                mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                mainStackView.heightAnchor.constraint(equalToConstant: 15),
                mainStackView.widthAnchor.constraint(equalToConstant: 75)
            ])
    }

    private func setUpFavButton() {
        addSubview(favButton)

        NSLayoutConstraint.activate([
            favButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            favButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 5),
            favButton.heightAnchor.constraint(equalToConstant: 20),
            favButton.widthAnchor.constraint(equalToConstant: 20)
        ])
    }

    private func setUpCaption() {
        addSubview(caption)
        NSLayoutConstraint.activate([
            caption.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 5),
            caption.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
    }

    private func setUpCommentLabel() {
        addSubview(commentLabel)
        NSLayoutConstraint.activate([
            commentLabel.topAnchor.constraint(equalTo: caption.bottomAnchor, constant: 5),
            commentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
    }

    private func setUpDateLabel() {
        addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
    }
        private func setUp() {
            setUpAvatarImage()
            setUpUserName()
            setUpPostImageView()
            setUpMainStackView()
            setUpFavButton()
            setUpCaption()
            setUpCommentLabel()
            setUpDateLabel()
        }
    }

extension UITableViewCell {
    static var reuseIdentifiers: String {
        return String(describing: self)
    }
}
