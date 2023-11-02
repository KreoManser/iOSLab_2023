//
//  DetailTableViewCell.swift
//  CatGram
//
//  Created by Аделя Миннехузина on 01.11.2023.
//

import UIKit

protocol PostTableViewCellDelegate: AnyObject {
    func didDeletePost(indexPath: IndexPath)
}

class DetailTableViewCell: UITableViewCell {

    weak var delegate: PostTableViewCellDelegate?

    private lazy var userImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "profile"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private lazy var topNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "cat's name"
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
            self?.delegate?.didDeletePost(indexPath: indexPath)
        }

        let button = UIButton()
        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "three_dots"), for: .normal)
        button.imageView?.tintColor = .white
        return button
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 25)), for: .normal)
        button.imageView?.tintColor = .white
        return button
    }()

    private lazy var commentButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "message")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 25)), for: .normal)
        button.imageView?.tintColor = .white
        return button
    }()

    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "paperplane")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 25)), for: .normal)
        button.imageView?.tintColor = .white
        return button
    }()

    private lazy var favouriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "bookmark")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 25)), for: .normal)
        button.imageView?.tintColor = .white
        return button
    }()

    private lazy var bottomNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "cat's name"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    weak var superView: UITableView?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews(subviews: userImage, topNameLabel,
        postImageView, deleteButton, likeButton, commentButton,
        shareButton, favouriteButton, bottomNameLabel,
        descriptionLabel, dateLabel)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with post: Post) {
        postImageView.image = post.image
        descriptionLabel.text = post.caption
        dateLabel.text = post.date

    }
}

extension DetailTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    private func addSubviews(subviews: UIView...) {
        subviews.forEach { contentView.addSubview($0) }
    }

    func getIndexPath() -> IndexPath {
        return (superView?.indexPath(for: self) ?? IndexPath(row: 0, section: 0))
    }

    private func configureUI() {
        NSLayoutConstraint.activate([
            userImage.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            userImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            userImage.widthAnchor.constraint(equalToConstant: 40),
            userImage.heightAnchor.constraint(equalToConstant: 40),

            topNameLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 10),
            topNameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),

            deleteButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            deleteButton.widthAnchor.constraint(equalToConstant: 55),
            deleteButton.heightAnchor.constraint(equalToConstant: 55),

            postImageView.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 20),
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

            bottomNameLabel.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 14),
            bottomNameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),

            descriptionLabel.topAnchor.constraint(equalTo: bottomNameLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),

            dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

