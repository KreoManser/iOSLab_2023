//
//  PostCell.swift
//  CaTGramm
//
//  Created by Rustem on 01.11.2023.
//

import UIKit

protocol PostTableAlertDelegate: AnyObject {
    func presentAlert(indexPath: IndexPath)
}

class PostCell: UITableViewCell {

    static let reuseIdentifier = "PostCell"

    var cellId = 0

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
        label.text = ""
        label.textColor = .black
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
            if DataManager.OurDataManager.syncGetAllPosts()[(self?.cellId) ?? 0].nickname == DataManager.OurDataManager.currentUser.userName {
                self?.delegate?.presentAlert(indexPath: indexPath)
            }
        }

        let button = UIButton()
        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "ellipsis")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
        button.imageView?.tintColor = .black
        return button
    }()

    private lazy var likeButton = TempButton.createLikeButton()

    private lazy var commentButton = TempButton.createCommentButton()

    private lazy var shareButton = TempButton.createShareButton()

    private lazy var favouriteButton = TempButton.createFavButton()

    private lazy var userNameBottomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()

    private lazy var postDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private lazy var postDateBottomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    // MARK: - Variables
    weak var delegate: PostTableAlertDelegate?

    weak var superView: UITableView?

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        addSubviews(subviews: userImageView, userNameTopLabel,
        postImageView, deleteButton, likeButton, commentButton,
        shareButton, favouriteButton, userNameBottomLabel, postDescriptionLabel, postDateBottomLabel)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostCell {

    private func addSubviews(subviews: UIView...) {
        subviews.forEach { contentView.addSubview($0) }
    }

    func configureCell(_ post: PictureModel) {
        self.userImageView.image = post.avatar
        self.userNameTopLabel.text = post.nickname
        self.postImageView.image = post.picture
        self.userNameBottomLabel.text = post.nickname
        self.postDescriptionLabel.text = post.text
        self.postDateBottomLabel.text = "\(post.date)"
    }

    func getIndexPath() -> IndexPath {
        return (superView?.indexPath(for: self) ?? IndexPath(row: 0, section: 0))
    }

    private func configureUI() {
        self.backgroundColor = .white
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            userImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            userImageView.widthAnchor.constraint(equalToConstant: 40),
            userImageView.heightAnchor.constraint(equalToConstant: 40),

            userNameTopLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 10),
            userNameTopLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),

            deleteButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),

            postImageView.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 5),
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
