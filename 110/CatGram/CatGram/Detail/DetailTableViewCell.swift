//
//  DetailTableViewCell.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 02.11.2023.
//

import UIKit

protocol DetailTableViewCellDelegate: AnyObject {
    func didDeletePublication(publication: DetailPublication)
}

class DetailTableViewCell: UITableViewCell {

    weak var delegate: DetailTableViewCellDelegate?
    var optionsTapped: ((_ alertContoller: UIAlertController) -> Void)?
    var animator: UIViewPropertyAnimator?

    lazy var avatarView: UIImageView = {
        let avatarView = UIImageView()
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.layer.cornerRadius = 25
        avatarView.layer.masksToBounds = true
        return avatarView
    }()

    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()

    var actionBarButton: UIButton = {
        let actionBarButton = UIButton()
        actionBarButton.setImage(UIImage(named: "button"), for: .normal)
        actionBarButton.translatesAutoresizingMaskIntoConstraints = false
        return actionBarButton
    }()

    lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private var userDefaults = UserDefaults.standard
    var isLiked: Bool = false

    lazy var buttonIconHeart: UIButton = {
        let buttonIconHeart = UIButton()
        buttonIconHeart.setImage(UIImage(named: "heart"), for: .normal)
        buttonIconHeart.translatesAutoresizingMaskIntoConstraints = false
        buttonIconHeart.addTarget(self, action: #selector(buttonIconHeartTapped), for: .touchUpInside)
        return buttonIconHeart
    }()

    @objc func buttonIconHeartTapped() {
        animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear, animations: {
            self.buttonIconHeart.transform = CGAffineTransform(scaleX: 3, y: 3)
            self.buttonIconHeart.transform = .identity
        })
        if isLiked {
            buttonIconHeart.setImage(UIImage.heart, for: .normal)
            self.isLiked.toggle()
            self.userDefaults.setValue(self.isLiked, forKey: "like")
            animator?.startAnimation()
        } else {
            buttonIconHeart.setImage(UIImage.redHeart, for: .normal)
            self.isLiked.toggle()
            self.userDefaults.setValue(self.isLiked, forKey: "like")
            animator?.startAnimation()
        }
    }

    lazy var buttonIconComment: UIButton = {
        let buttonIconComment = UIButton()
        buttonIconComment.setImage(UIImage(named: "comment"), for: .normal)
        buttonIconComment.translatesAutoresizingMaskIntoConstraints = false
        return buttonIconComment
    }()

    lazy var buttonSendIcon: UIButton = {
        let buttonSendIcon = UIButton()
        buttonSendIcon.setImage(UIImage(named: "send"), for: .normal)
        buttonSendIcon.translatesAutoresizingMaskIntoConstraints = false
        return buttonSendIcon
    }()

    lazy var buttonBookmarkIcon: UIButton = {
        let buttonBookmarkIcon = UIButton()
        buttonBookmarkIcon.setImage(UIImage(named: "bookmark"), for: .normal)
        buttonBookmarkIcon.translatesAutoresizingMaskIntoConstraints = false
        return buttonBookmarkIcon
    }()

    lazy var commentLabel: UILabel = {
        let commentLabel = UILabel()
        commentLabel.font = UIFont.systemFont(ofSize: 12)
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        return commentLabel
    }()

    lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.systemFont(ofSize: 11)
        return dateLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with publication: DetailPublication) {
        avatarView.image = publication.avatarImage
        nameLabel.text = publication.accountName
        image.image = publication.postImage
        commentLabel.text = publication.caption
        dateLabel.text = publication.date
        let isLiked = UserDefaults.standard.bool(forKey: "like")
        self.isLiked = isLiked
        let likeImage = isLiked ? UIImage.redHeart : UIImage.heart
        buttonIconHeart.setImage(likeImage, for: .normal)
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let deleteAction = UIAlertAction(title: "Удалить пост", style: .destructive) { [weak self] _ in
            self?.delegate?.didDeletePublication(publication: publication)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)

        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)

        actionBarButton.addAction(UIAction(handler: { _  in
            self.optionsTapped!(alertController)
        }), for: .touchUpInside)
    }

    func setupLayout() {
        contentView.addSubview(avatarView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(actionBarButton)
        contentView.addSubview(image)
        contentView.addSubview(buttonIconHeart)
        contentView.addSubview(buttonIconComment)
        contentView.addSubview(buttonSendIcon)
        contentView.addSubview(buttonBookmarkIcon)
        contentView.addSubview(commentLabel)
        contentView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            avatarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            avatarView.heightAnchor.constraint(equalToConstant: 50),
            avatarView.widthAnchor.constraint(equalToConstant: 50),

            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            nameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 20),

            actionBarButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            actionBarButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            actionBarButton.heightAnchor.constraint(equalToConstant: 20),
            actionBarButton.widthAnchor.constraint(equalToConstant: 20),

            image.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 10),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            image.heightAnchor.constraint(equalToConstant: 350),
            image.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0),

            buttonIconHeart.heightAnchor.constraint(equalToConstant: 25),
            buttonIconHeart.widthAnchor.constraint(equalToConstant: 25),
            buttonIconHeart.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            buttonIconHeart.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),

            buttonIconComment.heightAnchor.constraint(equalToConstant: 27),
            buttonIconComment.widthAnchor.constraint(equalToConstant: 27),
            buttonIconComment.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 9),
            buttonIconComment.leadingAnchor.constraint(equalTo: buttonIconHeart.trailingAnchor, constant: 15),

            buttonSendIcon.heightAnchor.constraint(equalToConstant: 24),
            buttonSendIcon.widthAnchor.constraint(equalToConstant: 24),
            buttonSendIcon.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 11),
            buttonSendIcon.leadingAnchor.constraint(equalTo: buttonIconComment.trailingAnchor, constant: 15),

            buttonBookmarkIcon.heightAnchor.constraint(equalToConstant: 25),
            buttonBookmarkIcon.widthAnchor.constraint(equalToConstant: 25),
            buttonBookmarkIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            buttonBookmarkIcon.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),

            commentLabel.topAnchor.constraint(equalTo: buttonIconHeart.bottomAnchor, constant: 15),
            commentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            commentLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            dateLabel.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 15),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)

        ])
    }

}
extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
