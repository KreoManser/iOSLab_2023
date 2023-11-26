//
//  PublicationTableViewCell.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 02.11.2023.
//

import UIKit

protocol AllertConnection: AnyObject {
    func presentAllertVC(indexPath: IndexPath)
}

class PublicationTableViewCell: UITableViewCell {
    var superView: UITableView?
    var delegate: AllertConnection?
    lazy var postPhotoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var postAvatarImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }()
    lazy var postDeleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "deleteIcon"), for: .normal)
        return button
    }()
    lazy var postNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    lazy var postLikeImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Like"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var postShringImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Share"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var postFavoritesImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Favorites"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var postCommentImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Comment"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var postCommentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var postDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(postPhotoImageView)
        addSubview(postAvatarImageView)
        addSubview(postNameLabel)
        addSubview(postDeleteButton)
        addSubview(postDeleteButton)
        addSubview(postLikeImageView)
        addSubview(postShringImageView)
        addSubview(postFavoritesImageView)
        addSubview(postCommentImageView)
        addSubview(postCommentLabel)
        addSubview(postDateLabel)
        setupLayout()
        setupButton()
    }
    func setupButton() {
        let action = UIAction {_ in
            self.postNameLabel.text = "ахпзцопщцз"
        }
        postDeleteButton.addAction(action, for: .touchUpInside)
    }
    func getIndexPath() -> IndexPath? {
            guard let superView = superView, let indexPath = superView.indexPath(for: self) else {
                return nil
            }
            return indexPath
        }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        NSLayoutConstraint.activate([
            postAvatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            postAvatarImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            postAvatarImageView.widthAnchor.constraint(equalToConstant: 40),
            postAvatarImageView.heightAnchor.constraint(equalToConstant: 40),
            postNameLabel.centerYAnchor.constraint(equalTo: postAvatarImageView.centerYAnchor),
            postNameLabel.leadingAnchor.constraint(equalTo: postAvatarImageView.trailingAnchor, constant: 10),
            postDeleteButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            postDeleteButton.widthAnchor.constraint(equalToConstant: 20),
            postDeleteButton.heightAnchor.constraint(equalToConstant: 20),
            postDeleteButton.centerYAnchor.constraint(equalTo: postAvatarImageView.centerYAnchor),
            postPhotoImageView.topAnchor.constraint(equalTo: postAvatarImageView.bottomAnchor, constant: 10),
            postPhotoImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            postPhotoImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            postPhotoImageView.heightAnchor.constraint(equalToConstant: 300),
            postLikeImageView.topAnchor.constraint(equalTo: postPhotoImageView.bottomAnchor, constant: 10),
            postLikeImageView.widthAnchor.constraint(equalToConstant: 25),
            postLikeImageView.heightAnchor.constraint(equalToConstant: 25),
            postLikeImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            postShringImageView.topAnchor.constraint(equalTo: postPhotoImageView.bottomAnchor, constant: 10),
            postShringImageView.widthAnchor.constraint(equalToConstant: 25),
            postShringImageView.heightAnchor.constraint(equalToConstant: 25),
            postShringImageView.leadingAnchor.constraint(equalTo: postLikeImageView.trailingAnchor, constant: 10),
            postCommentImageView.topAnchor.constraint(equalTo: postPhotoImageView.bottomAnchor, constant: 10),
            postCommentImageView.widthAnchor.constraint(equalToConstant: 25),
            postCommentImageView.heightAnchor.constraint(equalToConstant: 25),
            postCommentImageView.leadingAnchor.constraint(equalTo: postShringImageView.trailingAnchor, constant: 10),
            postFavoritesImageView.topAnchor.constraint(equalTo: postPhotoImageView.bottomAnchor, constant: 10),
            postFavoritesImageView.widthAnchor.constraint(equalToConstant: 20),
            postFavoritesImageView.heightAnchor.constraint(equalToConstant: 25),
            postFavoritesImageView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            postCommentLabel.topAnchor.constraint(equalTo: postLikeImageView.bottomAnchor, constant: 10),
            postCommentLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            postCommentLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            postDateLabel.topAnchor.constraint(equalTo: postCommentLabel.bottomAnchor, constant: 10),
            postDateLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            postDateLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}
