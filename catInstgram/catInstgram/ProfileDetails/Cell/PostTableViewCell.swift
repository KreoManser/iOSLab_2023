//
//  PostTableViewCell.swift
//  catInstgram
//
//  Created by marwa awwad mohamed awwad on 22/12/2023.
//

import Foundation
import UIKit

protocol PostTableAlertDelegate: AnyObject {
    func presentAlert(indexPath: IndexPath)
}

class PostTableViewCell: UITableViewCell {
    // MARK: - UI elements
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private lazy var userNameTopLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()

    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private lazy var deleteButton: UIButton = {
        let action = UIAction { [weak self] _ in
            let indexPath = self?.getIndexPath()
            guard var indexPath = indexPath else { return }
            self?.delegate?.presentAlert(indexPath: indexPath)
        }

        let button = UIButton()
        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "ellipsis")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
        button.imageView?.tintColor = .white
        return button
    }()


    private lazy var likeButton: UIButton = {
        var isLiked: Bool = false
        let action = UIAction { [weak self] _ in
            self?.animateLikeButton(isLiked)
            UserDefaults.standard.setValue(!isLiked, forKey: "like")
            isLiked.toggle()
        }

        let button = UIButton()
        button.addAction(action, for: .touchUpInside)
        button.setImage(UIImage(systemName: "heart")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 21)), for: .normal)
        button.imageView?.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var commentButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "message")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
        button.imageView?.tintColor = .white
        return button
    }()

    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "paperplane")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
        button.imageView?.tintColor = .white
        return button
    }()

    private lazy var favouriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "bookmark")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 22)), for: .normal)
        button.imageView?.tintColor = .white
        return button
    }()

    private lazy var userNameBottomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()

    private lazy var postDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private lazy var postDateBottomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "11-01-2002"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    // MARK: - Variables
    weak var delegate: PostTableAlertDelegate?

    weak var superView: UITableView?

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .black
        addSubviews(subviews: userImageView, userNameTopLabel,
        postImageView, deleteButton, likeButton, commentButton,
        shareButton, favouriteButton, userNameBottomLabel, postDescriptionLabel, postDateBottomLabel)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    private func addSubviews(subviews: UIView...) {
        subviews.forEach { contentView.addSubview($0) }
    }

    func configureCellForProfile(post: Post, userName: String, avatar: String) {
        deleteButton.isHidden = false
        userNameTopLabel.text = userName
        userNameBottomLabel.text = userName
        userImageView.image = UIImage(named: avatar)
        postImageView.image = UIImage(named: post.imageName)
        postDescriptionLabel.text = post.description
    }

    func configureCellForMainFeed(post: Post, userName: String, avatar: String) {
        deleteButton.isHidden = true
        userNameTopLabel.text = userName
        userNameBottomLabel.text = userName
        userImageView.image = UIImage(named: avatar)
        postImageView.image = UIImage(named: post.imageName)
        postDescriptionLabel.text = post.description
        likeButton.imageView?.tintColor = post.isLiked ? .red : .black
        let symbolName = post.isLiked ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: symbolName)?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 21)), for: .normal)
    }

    func getIndexPath() -> IndexPath {
        return (superView?.indexPath(for: self) ?? IndexPath(row: 0, section: 0))
    }

    private func configureUI() {
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            userImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            userImageView.widthAnchor.constraint(equalToConstant: 40),
            userImageView.heightAnchor.constraint(equalToConstant: 40),

            userNameTopLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 10),
            userNameTopLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),

            deleteButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),

            postImageView.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 20),
            postImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: contentView.frame.width),

            likeButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            likeButton.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),

            commentButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            commentButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 15),

            shareButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            shareButton.leadingAnchor.constraint(equalTo: commentButton.trailingAnchor, constant: 15),

            favouriteButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            favouriteButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),

            userNameBottomLabel.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 10),
            userNameBottomLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),

            postDescriptionLabel.topAnchor.constraint(equalTo: userNameBottomLabel.bottomAnchor, constant: 10),
            postDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            postDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),

            postDateBottomLabel.topAnchor.constraint(equalTo: postDescriptionLabel.bottomAnchor, constant: 10),
            postDateBottomLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            postDateBottomLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
extension PostTableViewCell {
    private func animateLikeButton(_ isLiked: Bool) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            let symbolName = isLiked ? "heart" : "heart.fill"
            self?.likeButton.imageView?.addSymbolEffect(.scale)
            self?.likeButton.setImage(UIImage(systemName: symbolName)?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 21)), for: .normal)
            self?.likeButton.imageView?.tintColor = isLiked ? .black : .red
            self?.likeButton.imageView?.removeAllSymbolEffects(options: .speed(0.1), animated: true)
        }
    }
}
