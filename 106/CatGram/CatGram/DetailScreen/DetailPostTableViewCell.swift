//
//  DetailPostTableViewCell.swift
//  CatGram
//
//  Created by Mac on 2023-10-30.
//

import UIKit

protocol DetailPostAlertDelegate: AnyObject {
    func presentAlert(indexPath: IndexPath)
}

class DetailPostTableViewCell: UITableViewCell {
    // MARK: - Declaration objects
    weak var delegate: DetailPostAlertDelegate?
    weak var tableView: UITableView?
    private let support = SupportFunctions()
    lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var nickLabel: UILabel = {
        let nick = support.createAmountLabel("evaklq")
        return nick
    }()
    lazy var additionalButton: UIButton = {
        let action = UIAction { [weak self] _ in
            let indexPath = self?.getIndexPath()
            self?.delegate?.presentAlert(indexPath: indexPath!)
        }
        let button = support.createButtonWithImage(UIImage(systemName: "ellipsis") ?? UIImage())
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    lazy var photoOfPost: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var likeButton: UIButton = {
        let button = support.createButtonWithImage(UIImage(systemName: "heart") ?? UIImage())
        return button
    }()
    lazy var commentButton: UIButton = {
        let button = support.createButtonWithImage(UIImage(systemName: "message") ?? UIImage())
        return button
    }()
    lazy var shareButton: UIButton = {
        let button = support.createButtonWithImage(UIImage(systemName: "paperplane") ?? UIImage())
        return button
    }()
    lazy var saveButton: UIButton = {
        let button = support.createButtonWithImage(UIImage(systemName: "bookmark") ?? UIImage())
        return button
    }()
    lazy var descriptionLabel: UILabel = {
        let label = support.createDescriptionLabel("This is me")
        return label
    }()
    lazy var dateLabel: UILabel = {
        let date = Date.now
        let formattedDate = support.formateDataToString(date)
        let label = support.createDescriptionLabel("\(date)")
        return label
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayouts()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Constraints
extension DetailPostTableViewCell {
    private func setupLayouts() {
        let actionsStackView = support.createSV([likeButton, commentButton, shareButton], axis: .horizontal, align: .fill)
        actionsStackView.spacing = 5
        let descriptionStackView = support.createSV([descriptionLabel, dateLabel], align: .fill)

        addSubview(iconImage)
        addSubview(nickLabel)
        addSubview(additionalButton)
        addSubview(photoOfPost)
        addSubview(actionsStackView)
        addSubview(saveButton)
        addSubview(descriptionStackView)

        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 7),
            iconImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            iconImage.heightAnchor.constraint(equalToConstant: 50),
            iconImage.widthAnchor.constraint(equalToConstant: 50),

            nickLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 3),
            nickLabel.centerYAnchor.constraint(equalTo: iconImage.centerYAnchor),

            additionalButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            additionalButton.centerYAnchor.constraint(equalTo: nickLabel.centerYAnchor),

            photoOfPost.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 7),
            photoOfPost.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            photoOfPost.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            photoOfPost.heightAnchor.constraint(equalTo: photoOfPost.widthAnchor, multiplier: 1),

            actionsStackView.topAnchor.constraint(equalTo: photoOfPost.bottomAnchor, constant: 5),
            actionsStackView.leadingAnchor.constraint(equalTo: iconImage.leadingAnchor),
            actionsStackView.heightAnchor.constraint(equalToConstant: 40),

            saveButton.topAnchor.constraint(equalTo: actionsStackView.topAnchor),
            saveButton.trailingAnchor.constraint(equalTo: additionalButton.trailingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            saveButton.widthAnchor.constraint(equalToConstant: 40),

            descriptionStackView.leadingAnchor.constraint(equalTo: actionsStackView.leadingAnchor),
            descriptionStackView.topAnchor.constraint(equalTo: actionsStackView.bottomAnchor, constant: 5),
            descriptionStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

// MARK: - ViewCell settings
extension DetailPostTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    func configureCell(with post: Post) {
        setImageAsync(post.author.iconUrl)
        self.nickLabel.text = post.author.nick
        self.photoOfPost.image = post.photos
        self.descriptionLabel.text = post.description
        self.dateLabel.text = support.formateDataToString(post.dateOfPublication)
    }
}

// MARK: - Support things
extension DetailPostTableViewCell {
    private func setImageAsync(_ url: URL) {
        DispatchQueue.global(qos: .utility).async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.iconImage.image = image
                        print("фото загрузилось")
                    }
                }
            }
        }
    }
    func getIndexPath() -> IndexPath {
        return (tableView?.indexPath(for: self))!
    }
}
