//
//  PostsTableViewCell.swift
//  homework_10
//
//  Created by Кирилл Щёлоков on 10.12.2023.
//

import UIKit

protocol PostTableViewCellDelegate: AnyObject {
    func didDeletePost(postModel: Post)
}

class PostTableViewCell: UITableViewCell {

    var optionsTapped: ((_ alertController: UIAlertController, _ author: String) -> Void)?
    var likeTapped: (() -> Int)?
    var unlikeTapped: (() -> Int)?

    weak var delegate: PostTableViewCellDelegate?

    lazy var logoImageView: UIImageView = UIImageView()
    lazy var postImageView: UIImageView = UIImageView()

    lazy var nameLabel: UILabel = UILabel()
    lazy var captionLabel: UILabel = UILabel()
    lazy var likeLabel: UILabel = UILabel()
    lazy var dateLabel: UILabel = UILabel()

    lazy var favoriteButton: UIButton = UIButton()
    lazy var optionsButton: UIButton = UIButton()
    lazy var likeButton: UIButton = UIButton()
    lazy var commentButton: UIButton = UIButton()
    lazy var shareButton: UIButton = UIButton()

    lazy var buttonsStackView: UIStackView = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpLogoImageView()
        setUpNameLabel()
        setUpPostImageView()
        setUpOptionButton()
        setUpButtonsStackView()
        setUpFavoriteButton()
        setUpLikeLabel()
        setUpCaptionLabel()
        setUpDateLabel()
    }

    func configure(with post: Post, likeCount: Int, isLiked: Bool) {
        if let authorAvatarData = post.author?.avatarImage {
            logoImageView.image = UIImage(data: authorAvatarData)
        } else {
            logoImageView.image = UIImage.question
        }
        nameLabel.text = post.author?.login
        if let postImageData = post.postImage {
            postImageView.image = UIImage(data: postImageData)
        } else {
            postImageView.image = UIImage.question
        }
        captionLabel.text = post.caption
        dateLabel.text = post.date
        likeLabel.text = "Нравится: \(likeCount)"
        if isLiked {
            likeButton.setImage(UIImage(named: "likeIconRed"), for: .normal)
        } else {
            likeButton.setImage(UIImage(named: "likeIcon"), for: .normal)
        }

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let deleteAction = UIAlertAction(title: "Удалить пост", style: .destructive) { [weak self] _ in
            self?.delegate?.didDeletePost(postModel: post)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)

        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)

        optionsButton.addAction(UIAction(handler: { _  in
            self.optionsTapped?(alertController, post.author?.login ?? "")
        }), for: .touchUpInside)
    }

    private func setUpLogoImageView() {
        addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.layer.cornerRadius = 20
        logoImageView.clipsToBounds = true

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            logoImageView.widthAnchor.constraint(equalToConstant: 40),
            logoImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setUpNameLabel() {
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 12)

        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 5)
        ])
    }

    private func setUpOptionButton() {
        addSubview(optionsButton)
        optionsButton.translatesAutoresizingMaskIntoConstraints = false
        optionsButton.setImage(UIImage(named: "dotsIcon"), for: .normal)

        NSLayoutConstraint.activate([
            optionsButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            optionsButton.trailingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: -20),
            optionsButton.widthAnchor.constraint(equalToConstant: 25),
            optionsButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }

    private func setUpPostImageView() {
        addSubview(postImageView)
        postImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 10),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.widthAnchor.constraint(equalToConstant: 396),
            postImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }

    private func setUpButtonsStackView() {
        addSubview(buttonsStackView)
        buttonsStackView.axis = .horizontal
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.spacing = 10

        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            buttonsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            buttonsStackView.widthAnchor.constraint(equalToConstant: 95),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 25)
        ])

        setUpLikeButton()
        setUpCommentButton()
        setUpShareButton()
    }

    private func setUpLikeButton() {
        buttonsStackView.addArrangedSubview(likeButton)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeButton.widthAnchor.constraint(equalToConstant: 25),
            likeButton.heightAnchor.constraint(equalToConstant: 25)
        ])

        let likeAction = UIAction { [weak self] _ in
            self?.setUpLikeAnimation()
        }
        likeButton.addAction(likeAction, for: .touchUpInside)
    }

    private func setUpLikeAnimation() {
        if likeButton.image(for: .normal) == UIImage(named: "likeIcon") {
            UIView.transition(with: likeButton, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.likeButton.setImage(UIImage(named: "likeIconRed"), for: .normal)
            })
            likeLabel.text = "Нравится: \(likeTapped?() ?? 0)"
        } else {
            UIView.transition(with: likeButton, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.likeButton.setImage(UIImage(named: "likeIcon"), for: .normal)
            })
            likeLabel.text = "Нравится: \(unlikeTapped?() ?? 0)"
        }

    }

    private func setUpCommentButton() {
        buttonsStackView.addArrangedSubview(commentButton)
        commentButton.setImage(UIImage(named: "commentIcon"), for: .normal)
        commentButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commentButton.widthAnchor.constraint(equalToConstant: 25),
            commentButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }

    private func setUpShareButton() {
        buttonsStackView.addArrangedSubview(shareButton)
        shareButton.setImage(UIImage(named: "shareIcon"), for: .normal)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shareButton.widthAnchor.constraint(equalToConstant: 25),
            shareButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }

    private func setUpFavoriteButton() {
        addSubview(favoriteButton)
        favoriteButton.setImage(UIImage(named: "favoriteIcon"), for: .normal)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            favoriteButton.trailingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: -20),
            favoriteButton.widthAnchor.constraint(equalToConstant: 25),
            favoriteButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }

    private func setUpLikeLabel() {
        addSubview(likeLabel)
        likeLabel.translatesAutoresizingMaskIntoConstraints = false
        likeLabel.textColor = .darkText
        likeLabel.font = UIFont.systemFont(ofSize: 14)

        NSLayoutConstraint.activate([
            likeLabel.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 10),
            likeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            likeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    private func setUpCaptionLabel() {
        addSubview(captionLabel)
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        captionLabel.textColor = .darkText
        captionLabel.font = UIFont.systemFont(ofSize: 14)

        NSLayoutConstraint.activate([
            captionLabel.topAnchor.constraint(equalTo: likeLabel.bottomAnchor, constant: 5),
            captionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            captionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    private func setUpDateLabel() {
        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.systemFont(ofSize: 11)

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
    }
}
