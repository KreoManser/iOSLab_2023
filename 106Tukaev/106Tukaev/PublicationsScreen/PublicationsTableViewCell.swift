//
//  PublicationsTableViewCell.swift
//  106Tukaev
//
//  Created by surexnx on 01.11.2023.
//

import UIKit

class PublicationsTableViewCell: UITableViewCell {

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

    private lazy var publicationDate: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var likeButton: UIButton = {
        var button = UIButton(type: .system)
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
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tuppedAlert), for: .touchUpInside)
        return button
    }()

    var alertButton: (() -> Void)?

    private lazy var buttonHorizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, shareButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .leading
        return stackView
    }()

    @objc func tuppedAlert() {
        alertButton!()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUser()
        setupButton()
        setupPublicationCell()
        setupLayout()
        backgroundColor = .white
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var id: UUID?

    private func setupUser() {
        userImage.image = UIImage(named: "user")
        userLogin.text = "Surexnx"
    }

    private func setupPublicationCell() {
        userLogin.font = UIFont.systemFont(ofSize: 14)
        publicationDesription.font = UIFont.systemFont(ofSize: 13)
        publicationDate.font = UIFont.systemFont(ofSize: 13)
    }

    func configureCell(publication: Publication) {
        publicationImage.image = publication.images[0]
        publicationDate.text = publication.date
        publicationDesription.text = publication.description
        self.id = publication.id
    }

    private func setupButton() {
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .highlighted)
        shareButton.setImage(UIImage(systemName: "paperplane"), for: .normal)
        commentButton.setImage(UIImage(systemName: "message"), for: .normal)
        favoriteButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        optionButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
    }

    private func addSubviews(_ subview: UIView...) {
        subview.forEach { addSubview($0) }
    }

    private func setupLayout() {
        addSubviews(userLogin, userImage, publicationImage, publicationDesription, publicationDate)
        addSubviews(buttonHorizontalStackView, optionButton, favoriteButton)
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

            favoriteButton.topAnchor.constraint(equalTo: publicationImage.bottomAnchor, constant: 10),
            favoriteButton.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -5),

            publicationDesription.topAnchor.constraint(equalTo: buttonHorizontalStackView.bottomAnchor, constant: 10),
            publicationDesription.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 5),

            publicationDate.topAnchor.constraint(equalTo: publicationDesription.bottomAnchor, constant: 10),
            publicationDate.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 5)
        ])
    }

    static var reuseIdentificator: String {
        return String(describing: self)
    }

}
