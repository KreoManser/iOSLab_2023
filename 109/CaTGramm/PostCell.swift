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
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            userImageView.widthAnchor.constraint(equalToConstant: 40),
            userImageView.heightAnchor.constraint(equalToConstant: 40),

            userNameTopLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 10),
            userNameTopLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),

            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            postImageView.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 5),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: contentView.frame.width),

            likeButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),

            commentButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            commentButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 15),

            shareButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            shareButton.leadingAnchor.constraint(equalTo: commentButton.trailingAnchor, constant: 15),

            favouriteButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            favouriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            likesCounter.trailingAnchor.constraint(equalTo: favouriteButton.leadingAnchor, constant: -10),
            likesCounter.centerYAnchor.constraint(equalTo: favouriteButton.centerYAnchor),

            userNameBottomLabel.topAnchor.constraint(equalTo: shareButton.bottomAnchor, constant: 10),
            userNameBottomLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),

            postDescriptionLabel.topAnchor.constraint(equalTo: userNameBottomLabel.bottomAnchor, constant: 10),
            postDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            postDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            postDateBottomLabel.topAnchor.constraint(equalTo: postDescriptionLabel.bottomAnchor, constant: 10),
            postDateBottomLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            postDateBottomLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    func configureCell(_ post: PictureModel) {

        if DataManager.OurDataManager.getCurrentUser().likedPosts.contains(where: { $0.text == post.text }) {
            likesCounter.text = "1"
        } else {
            likesCounter.text = "0"
        }

        let myAction = UIAction(title: "Like") { _ in
            print("liked")
            if DataManager.OurDataManager.getCurrentUser().likedPosts.contains(where: { $0.text == post.text }) {
                self.likesCounter.text = "0"
                print("disliked")
                UIView.animate(withDuration: 1.0, delay: .zero, animations: {
                    self.likeButton.imageView?.tintColor = .black
                })
                self.likeButton.imageView?.tintColor = .black
                self.likeButton.tintColor = .black
                DataManager.OurDataManager.getCurrentUser().likedPosts.removeAll(where: { $0.text == post.text })
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
                DataManager.OurDataManager.getCurrentUser().likedPosts.append(post)
            }
            self.saveLikedPosts()
        }
        self.likeButton.addAction(myAction, for: .touchDown)
        self.userImageView.image = post.avatar
        self.userNameTopLabel.text = post.nickname
        self.postImageView.image = post.picture
        self.userNameBottomLabel.text = post.nickname
        self.postDescriptionLabel.text = post.text
        self.postDateBottomLabel.text = "\(post.date)"
        if DataManager.OurDataManager.getCurrentUser().likedPosts.contains(where: { $0.text == post.text }) {
            self.likeButton.imageView?.tintColor = .red
            print("da")
            DataManager.OurDataManager.getCurrentUser().likedPosts.append(post)
        }
    }

    func saveLikedPosts() {
        for post in DataManager.OurDataManager.getCurrentUser().likedPosts {
            print(post.text)
        }
        do {
            let encoder = JSONEncoder()
            let likedPosts = try encoder.encode(DataManager.OurDataManager.getCurrentUser().likedPosts)
            UserDefaults.standard.setValue(likedPosts, forKey: "liked")
            print(likedPosts)
        } catch {
            print("\(error)")
        }
    }

    func getIndexPath() -> IndexPath {
        return (superView?.indexPath(for: self) ?? IndexPath(row: 0, section: 0))
    }
}
