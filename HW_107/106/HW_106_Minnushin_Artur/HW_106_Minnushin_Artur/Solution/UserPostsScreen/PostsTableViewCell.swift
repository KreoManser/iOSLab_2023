//
//  PublicationTableViewCell.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 02.11.2023.
//

import UIKit

protocol AllertConnection: AnyObject {
    func presentAllertVC(postId: Int, userId: Int)
    func tapLikeButton(postId: Int, userId: Int)
}

class PostsTableViewCell: UITableViewCell {
    var delegate: AllertConnection?
    var isLikedCheker: Bool?
    var postId: Int?
    var userId: Int?
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
        let action = UIAction { _ in
            self.delegate?.presentAllertVC(postId: self.postId!, userId: self.userId!)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    lazy var postNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    lazy var postLikeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "LikeIcon"), for: .normal)
        let action = UIAction { _ in
            self.likeAnimation()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    lazy var postLikeCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "Лайков: 0"
        return label
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
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
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
        contentView.addSubview(postDeleteButton)
        addSubview(postDeleteButton)
        addSubview(postLikeButton)
        addSubview(postShringImageView)
        addSubview(postFavoritesImageView)
        addSubview(postCommentImageView)
        addSubview(postCommentLabel)
        addSubview(postDateLabel)
        addSubview(postLikeCountLabel)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpLikeButton() {
        if isLikedCheker == true {
            postLikeButton.setImage(UIImage(named: "isLikeIcon"), for: .normal)
            isLikedCheker = true
        } else {
            postLikeButton.setImage(UIImage(named: "LikeIcon"), for: .normal)
            isLikedCheker = false
        }
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
            postPhotoImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            postPhotoImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            postPhotoImageView.heightAnchor.constraint(equalToConstant: 300),
            postLikeButton.topAnchor.constraint(equalTo: postPhotoImageView.bottomAnchor, constant: 10),
            postLikeButton.widthAnchor.constraint(equalToConstant: 25),
            postLikeButton.heightAnchor.constraint(equalToConstant: 25),
            postLikeButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            postShringImageView.topAnchor.constraint(equalTo: postPhotoImageView.bottomAnchor, constant: 10),
            postShringImageView.widthAnchor.constraint(equalToConstant: 25),
            postShringImageView.heightAnchor.constraint(equalToConstant: 25),
            postShringImageView.leadingAnchor.constraint(equalTo: postLikeButton.trailingAnchor, constant: 10),
            postCommentImageView.topAnchor.constraint(equalTo: postPhotoImageView.bottomAnchor, constant: 10),
            postCommentImageView.widthAnchor.constraint(equalToConstant: 25),
            postCommentImageView.heightAnchor.constraint(equalToConstant: 25),
            postCommentImageView.leadingAnchor.constraint(equalTo: postShringImageView.trailingAnchor, constant: 10),
            postFavoritesImageView.topAnchor.constraint(equalTo: postPhotoImageView.bottomAnchor, constant: 10),
            postFavoritesImageView.widthAnchor.constraint(equalToConstant: 20),
            postFavoritesImageView.heightAnchor.constraint(equalToConstant: 25),
            postFavoritesImageView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            postLikeCountLabel.topAnchor.constraint(
                equalTo: postLikeButton.bottomAnchor, constant: 5),
            postLikeCountLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            postCommentLabel.topAnchor.constraint(equalTo: postLikeCountLabel.bottomAnchor, constant: 5),
            postCommentLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            postCommentLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            postDateLabel.topAnchor.constraint(equalTo: postCommentLabel.bottomAnchor, constant: 10),
            postDateLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            postDateLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}

extension PostsTableViewCell {
    func likeAnimation() {
        if isLikedCheker == false {
            self.postLikeButton.setImage(UIImage(named: "isLikeIcon"), for: .normal)
            let likeImageViewAnimate: UIImageView = {
                let posX = self.postLikeButton.frame.origin.x
                let posY = self.postLikeButton.frame.origin.y
                let width = self.postLikeButton.bounds.width
                let height = self.postLikeButton.bounds.height
                let imageView = UIImageView(frame: CGRect(x: posX,
                                                          y: posY,
                                                          width: width,
                                                          height: height))
                imageView.image = UIImage(named: "isLikeIcon")
                return imageView
            }()
            addSubview(likeImageViewAnimate)
            let animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear, animations: {
                let translation = CGAffineTransform(translationX: 0, y: -30)
                let scale = CGAffineTransform(scaleX: 2, y: 2)
                likeImageViewAnimate.transform = translation.concatenating(scale)
            })
            animator.addCompletion({_ in
                likeImageViewAnimate.removeFromSuperview()
                self.delegate?.tapLikeButton(postId: self.postId!, userId: self.userId!)
            })
            animator.startAnimation()
        } else {
            self.postLikeButton.setImage(UIImage(named: "LikeIcon"), for: .normal)
            self.delegate?.tapLikeButton(postId: self.postId!, userId: self.userId!)
        }
    }
}
