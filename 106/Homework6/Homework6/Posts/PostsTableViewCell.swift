//
//  PostsTableViewCell.swift
//  Homework6
//
//  Created by kerik on 30.10.2023.
//

import UIKit

protocol PostsTableAlertDelegate: AnyObject {
    func presentAlert(indexPath: IndexPath)
}

class PostsTableViewCell: UITableViewCell {
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "profile"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "kerikg"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
        button.imageView?.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 21)), for: .normal)
        button.imageView?.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "message")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
        button.imageView?.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
        button.imageView?.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var favouriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
        button.imageView?.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var postDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var postDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    weak var delegate: PostsTableAlertDelegate?
    weak var superView: UITableView?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        addSubviews(subviews: userImageView, userNameLabel,
        postImageView, deleteButton, likeButton, commentButton,
        shareButton, favouriteButton, postDescriptionLabel, postDateLabel)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostsTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    private func addSubviews(subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }

    func configureCell(_ post: Post) {
        postImageView.image = UIImage(named: post.imageName)
        postDescriptionLabel.text = post.description
        postDateLabel.text = post.date
    }

    func getIndexPath() -> IndexPath? {
        guard let superView = superView, let indexPath = superView.indexPath(for: self) else {
            return nil
        }
        return indexPath
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            userImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            userImageView.widthAnchor.constraint(equalToConstant: 40),
            userImageView.heightAnchor.constraint(equalToConstant: 40),

            userNameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 10),
            userNameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),

            deleteButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),

            postImageView.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 10),
            postImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: contentView.frame.width),

            likeButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 7),
            likeButton.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),

            commentButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            commentButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 15),

            shareButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            shareButton.leadingAnchor.constraint(equalTo: commentButton.trailingAnchor, constant: 15),

            favouriteButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            favouriteButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),

            postDescriptionLabel.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 10),
            postDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            postDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),

            postDateLabel.topAnchor.constraint(equalTo: postDescriptionLabel.bottomAnchor, constant: 10),
            postDateLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            postDateLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}
