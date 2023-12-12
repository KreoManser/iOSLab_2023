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

    private lazy var likesCounter: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

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
        shareButton, favouriteButton, userNameBottomLabel, postDescriptionLabel, postDateBottomLabel, likesCounter)
        self.likeButton.imageView?.tintColor = .black
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

    private func configureUI() {
        self.backgroundColor = .white
        userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        userImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        userImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true

        userNameTopLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 10).isActive = true
        userNameTopLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true

        deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true

        postImageView.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 5).isActive = true
        postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        postImageView.heightAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true

        likeButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10).isActive = true
        likeButton.leadingAnchor.constraint(equalTo: userImageView.leadingAnchor).isActive = true

        commentButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10).isActive = true
        commentButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 15).isActive = true

        shareButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10).isActive = true
        shareButton.leadingAnchor.constraint(equalTo: commentButton.trailingAnchor, constant: 15).isActive = true

        favouriteButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10).isActive = true
        favouriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true

        likesCounter.trailingAnchor.constraint(equalTo: favouriteButton.leadingAnchor, constant: -10).isActive = true
        likesCounter.centerYAnchor.constraint(equalTo: favouriteButton.centerYAnchor).isActive = true

        userNameBottomLabel.topAnchor.constraint(equalTo: shareButton.bottomAnchor, constant: 10).isActive = true
        userNameBottomLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true

        postDescriptionLabel.topAnchor.constraint(equalTo: userNameBottomLabel.bottomAnchor, constant: 10).isActive = true
        postDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        postDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true

        postDateBottomLabel.topAnchor.constraint(equalTo: postDescriptionLabel.bottomAnchor, constant: 10).isActive = true
        postDateBottomLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        postDateBottomLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }

    func configureCell(_ post: Post) {

        if DataManager.OurDataManager.getCurrentUser().likes.contains(where: { $0.post == post }) {
            likesCounter.text = "1"
        } else {
            likesCounter.text = "0"
        }

        let myAction = UIAction(title: "Like") { _ in
            print("liked")
            if DataManager.OurDataManager.getCurrentUser().likes.contains(where: { $0.post == post }) {
                self.likesCounter.text = "0"
                print("disliked")
                UIView.animate(withDuration: 1.0, delay: .zero, animations: {
                    self.likeButton.imageView?.tintColor = .black
                })
                self.likeButton.imageView?.tintColor = .black
                self.likeButton.tintColor = .black
                DataManager.OurDataManager.getCurrentUser().likes = DataManager.OurDataManager.getCurrentUser().likes.filter { $0.post == post }
            } else {
                self.likesCounter.text = "1"
                UIView.animate(withDuration: 1.0, delay: .zero, animations: {
                    self.likeButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                    self.likeButton.imageView?.tintColor = .systemRed
                }, completion: { _ in
                    UIView.animate(withDuration: 1.0, delay: .zero, animations: {
                        self.likeButton.transform = .identity
                    })
                })
                self.likeButton.imageView?.tintColor = .systemRed
                var likedItem = Like(context: CoreDataManager.shared.viewContext)
                likedItem.post = post
                likedItem.likeId = UUID()
                likedItem.likeDate = Date()
                likedItem.user = DataManager.OurDataManager.getCurrentUser()
                DataManager.OurDataManager.getCurrentUser().likes.insert(likedItem)
            }
        }
        self.likeButton.addAction(myAction, for: .touchDown)
        self.userImageView.image = UIImage(named: post.avatar)
        self.userNameTopLabel.text = post.nickname
        self.postImageView.image = UIImage(named: post.picture)
        self.userNameBottomLabel.text = post.nickname
        self.postDescriptionLabel.text = post.text
        self.postDateBottomLabel.text = "\(post.date)"
    }

    func getIndexPath() -> IndexPath {
        return (superView?.indexPath(for: self) ?? IndexPath(row: 0, section: 0))
    }
}
