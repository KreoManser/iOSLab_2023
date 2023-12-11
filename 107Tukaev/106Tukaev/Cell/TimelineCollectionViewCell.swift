//
//  PublicationsTableViewCell.swift
//  106Tukaev
//
//  Created by surexnx on 01.11.2023.
//

import UIKit

protocol AlertDelegate: AnyObject {
    func didPressAlert(id: UUID)
}

protocol ProfilePushDelegate: AnyObject {
    func didPressImage(user: User)
}

class TimelineCollectionViewCell: UICollectionViewCell {

    private var likes: Int = 0
    private var user: User?

    private lazy var userImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()

    private lazy var userLogin: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var publicationImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        return image
    }()

    private lazy var publicationDesription: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var numbersOfLike: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var publicationDate: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var likeButton: UIButton = {
        var action = UIAction {[weak self] _ in
            self?.doubleTap?()
        }
        var button = UIButton(type: .system, primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var shareButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var commentButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var favoriteButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var optionButton: UIButton = {

        var action = UIAction { _ in
            if let id = self.id {
                self.delegate?.didPressAlert(id: id)
            }
        }
        var button = UIButton()
        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var buttonHorizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, shareButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .leading
        return stackView
    }()

    weak var delegate: AlertDelegate?
    weak var pushDelegate: ProfilePushDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        setupPublicationCell()
        setupLayout()
        contentView.backgroundColor = .white

        setupImageGesture()
    }

    @objc func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            likeAnimate()
            doubleTap?()
        }
    }
    @objc func handleTap() {
        pushDelegate?.didPressImage(user: user ?? User())
    }

    func setupImageGesture() {
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        publicationImage.isUserInteractionEnabled = true
        publicationImage.addGestureRecognizer(doubleTapGesture)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        userImage.addGestureRecognizer(tapGesture)
        userImage.isUserInteractionEnabled = true
    }

    func likeAnimate() {
        let likeAnimation = UIImageView(image: UIImage(systemName: "heart.fill"))
        likeAnimation.tintColor = .red
        let x: CGFloat = publicationImage.layer.presentation()?.frame.maxX ?? .zero
        let y: CGFloat = publicationImage.layer.presentation()?.frame.maxY ?? .zero
        likeAnimation.frame = CGRect(x: x / 2 - 40, y: y / 2 - 40, width: 40, height: 40)
        addSubview(likeAnimation)

        UIView.animate(withDuration: 2, animations: {
            likeAnimation.alpha = 0
        }, completion: {_ in
            likeAnimation.removeFromSuperview()
        })

    }

    var doubleTap: (() -> Void)?

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var id: UUID?

    func setupUser(user: User) {
        userImage.image = UIImage(named: user.image)
        userLogin.text = user.login
        self.user = user
    }

    private func setupPublicationCell() {
        userLogin.font = UIFont.systemFont(ofSize: 14)
        publicationDesription.font = UIFont.systemFont(ofSize: 13)
        numbersOfLike.font = UIFont.systemFont(ofSize: 13)
        publicationDate.font = UIFont.systemFont(ofSize: 13)
    }

    func configureCell(publication: Publication) {

        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd.MM.yyy"
        publicationImage.image = UIImage(named: publication.images.first?.nameImage ?? "нет")
        publicationDate.text = dateFormat.string(from: publication.date)
        publicationDesription.text = publication.discription
        likes = publication.likes.count
        numbersOfLike.text = "нравится: " + String(likes)

        id = publication.id
    }

    func setLikes(likes: Int) {
        self.likes = likes
        numbersOfLike.text = "нравится: " + String(likes)
    }

    func pressedLikeBtn(like: Bool) {
        if like {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }

    private func setupButton() {
        likeButton.tintColor = .red
        shareButton.setImage(UIImage(systemName: "paperplane"), for: .normal)
        commentButton.setImage(UIImage(systemName: "message"), for: .normal)
        favoriteButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        optionButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
    }

    private func addSubviews(_ subview: UIView...) {
        subview.forEach { contentView.addSubview($0) }
    }

    private func setupLayout() {

        addSubviews(userLogin, userImage, publicationImage, publicationDesription, publicationDate)
        addSubviews(buttonHorizontalStackView, optionButton, favoriteButton, numbersOfLike)
        let content = contentView.safeAreaLayoutGuide
        let width = UIScreen.main.bounds.width
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: content.topAnchor, constant: 5),
            userImage.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 5),
            userImage.heightAnchor.constraint(equalToConstant: 40),
            userImage.widthAnchor.constraint(equalToConstant: 40),

            userLogin.topAnchor.constraint(equalTo: content.topAnchor, constant: 15),
            userLogin.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 5),

            optionButton.topAnchor.constraint(equalTo: content.topAnchor, constant: 5),
            optionButton.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -5),

            publicationImage.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 5),
            publicationImage.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            publicationImage.widthAnchor.constraint(equalToConstant: width),
            publicationImage.heightAnchor.constraint(equalToConstant: width),

            buttonHorizontalStackView.topAnchor.constraint(equalTo: publicationImage.bottomAnchor, constant: 10),
            buttonHorizontalStackView.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 5),

            numbersOfLike.topAnchor.constraint(equalTo: buttonHorizontalStackView.bottomAnchor, constant: 10),
            numbersOfLike.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 5),

            favoriteButton.topAnchor.constraint(equalTo: publicationImage.bottomAnchor, constant: 10),
            favoriteButton.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -5),

            publicationDesription.topAnchor.constraint(equalTo: numbersOfLike.bottomAnchor, constant: 10),
            publicationDesription.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 5),

            publicationDate.topAnchor.constraint(equalTo: publicationDesription.bottomAnchor, constant: 10),
            publicationDate.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 5)
        ])
    }

    static var reuseIdentificator: String {
        return String(describing: self)
    }

}
