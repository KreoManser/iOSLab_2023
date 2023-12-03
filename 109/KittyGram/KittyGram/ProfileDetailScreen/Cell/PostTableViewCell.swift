//
//  PostTableViewCell.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 22.11.2023.
//

import UIKit

enum PostLocation {
    case profile
    case main
}

protocol PostTableAlertDelegate: AnyObject {
    func presentAlert(indexPath: IndexPath)
}

protocol PostLikeObserver: AnyObject {
    func saveLikedPost(postId: Int)
    func deleteLikedPost(postId: Int)
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
        button.setImage(
            UIImage(systemName: "ellipsis")?.withConfiguration(
                UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
        button.imageView?.tintColor = .white
        return button
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton(configuration: PostButton.configureation)
        let action = UIAction { [weak self] _ in
            guard let self = self else { return }
            self.animateLike()

            if isLiked {
                self.observer?.deleteLikedPost(postId: self.postId )
                self.likesCounter -= 1
                self.likeCounterLabel.text = "Нравится: \(self.likesCounter)"

            } else {
                self.likesCounter += 1
                self.likeCounterLabel.text = "Нравится: \(self.likesCounter)"
                self.observer?.saveLikedPost(postId: self.postId )
            }

            self.isLiked.toggle()
        }
        button.addAction(action, for: .touchUpInside)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(
            UIImage(systemName: "heart"), for: .normal)
        button.imageView?.tintColor = .white
        return button
    }()

    private lazy var commentButton: UIButton = {
        let button = UIButton(configuration: PostButton.configureation)
        button.tintColor = .white

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(
            UIImage(systemName: "message"), for: .normal)
        button.imageView?.tintColor = .white
        return button
    }()

    private lazy var shareButton: UIButton = {
        let button = UIButton(configuration: PostButton.configureation)
        button.tintColor = .white

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(
            UIImage(systemName: "paperplane"), for: .normal)
        button.imageView?.tintColor = .white
        return button
    }()

    private lazy var favouriteButton: UIButton = {
        let button = UIButton(configuration: .plain())
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(
            UIImage(systemName: "bookmark"), for: .normal)
        button.imageView?.tintColor = .white
        return button
    }()

    private lazy var likeCounterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
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
        label.font = UIFont.systemFont(ofSize: 15)
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

    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, shareButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.distribution = .fillEqually
        return stackView
    }()

    // MARK: - Variables
    weak var delegate: PostTableAlertDelegate?

    weak var observer: PostLikeObserver?

    weak var superView: UITableView?

    private var postId: Int = -1

    private var isLiked: Bool = false

    private var likesCounter: Int = 0

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .black
        addSubviews(subviews: userImageView, userNameTopLabel,
        postImageView, deleteButton, favouriteButton,
        userNameBottomLabel, postDescriptionLabel, postDateBottomLabel,
        buttonStackView, likeCounterLabel)
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

    private func configureUI() {
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                constant: 10),
            userImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            userImageView.widthAnchor.constraint(equalToConstant: 40),
            userImageView.heightAnchor.constraint(equalToConstant: 40),

            userNameTopLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 10),
            userNameTopLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),

            deleteButton.topAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            deleteButton.trailingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                constant: -10),

            postImageView.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 20),
            postImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: contentView.frame.width),

            buttonStackView.leadingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                constant: 10),
            buttonStackView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),

            favouriteButton.topAnchor.constraint(
                equalTo: postImageView.bottomAnchor, constant: 10),
            favouriteButton.trailingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                constant: -5),

            likeCounterLabel.leadingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                constant: 10),
            likeCounterLabel.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 10),

            userNameBottomLabel.topAnchor.constraint(
                equalTo: likeCounterLabel.bottomAnchor, constant: 3),
            userNameBottomLabel.leadingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                constant: 10),

            postDescriptionLabel.topAnchor.constraint(
                equalTo: likeCounterLabel.bottomAnchor, constant: 3),
            postDescriptionLabel.leadingAnchor.constraint(
                equalTo: userNameBottomLabel.trailingAnchor,
                constant: 5),
            postDescriptionLabel.trailingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                constant: -10),

            postDateBottomLabel.topAnchor.constraint(
                equalTo: postDescriptionLabel.bottomAnchor,
                constant: 10),
            postDateBottomLabel.leadingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                constant: 10),
            postDateBottomLabel.bottomAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.bottomAnchor,
                constant: -20)
        ])
    }
}

extension PostTableViewCell {

    func configureCell(post: Post, userName: String, avatar: String, isLiked: Bool, configureFor: PostLocation) {
        likeHandler(isLiked: isLiked)
        configureCell(post: post, userName: userName, avatar: avatar)
        likesCounter = post.likes
        likeCounterLabel.text = "Нравится: \(post.likes)"
        switch configureFor {
        case .profile:
            deleteButton.isHidden = false
        case .main:
            deleteButton.isHidden = true
        }

    }

    private func configureCell(post: Post, userName: String, avatar: String) {
        userNameTopLabel.text = userName
        userNameBottomLabel.text = userName
        userImageView.image = UIImage(named: avatar)
        postImageView.image = UIImage(named: post.imageName)
        postDescriptionLabel.text = post.description
        postId = post.id
    }

    private func likeHandler(isLiked: Bool) {
        if isLiked {
            self.isLiked = true
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = .red
        }
    }

}

extension PostTableViewCell {

    func getIndexPath() -> IndexPath {
        return superView?.indexPath(for: self) ?? IndexPath(row: 0, section: 0)
    }

    private func animateLike() {
        if !isLiked {
            UIView.animate(withDuration: 0.1, animations: {
                self.likeButton.imageView?.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                self.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                self.likeButton.tintColor = .red
            }, completion: { _ in
                self.likeButton.imageView?.transform = .identity
            })
        } else {
            UIView.animate(withDuration: 0.1, animations: {
                self.likeButton.imageView?.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                self.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                self.likeButton.tintColor = .white
            }, completion: { _ in
                self.likeButton.imageView?.transform = .identity
            })
        }
    }

}
