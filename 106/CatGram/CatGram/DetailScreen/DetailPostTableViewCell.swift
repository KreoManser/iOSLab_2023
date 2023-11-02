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
    private let support = SupportFunctions()
    weak var delegate: DetailPostAlertDelegate?
    weak var table: UITableView?

    private lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var nickLabel: UILabel = {
        let nick = support.createAmountLabel("evaklq")
        return nick
    }()
    private lazy var additionalButton: UIButton = {
        let action = UIAction { [weak self] _ in
            let indexPath = self?.getIndexPath()
            guard var indexPath = indexPath else { return }
            self?.delegate?.presentAlert(indexPath: indexPath)
        }

        let button = support.createButtonWithImage(UIImage(systemName: "ellipsis") ?? UIImage())
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private lazy var photoOfPost: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var likeButton: UIButton = {
        let button = support.createButtonWithImage(UIImage(systemName: "heart") ?? UIImage())
        return button
    }()
    private lazy var commentButton: UIButton = {
        let button = support.createButtonWithImage(UIImage(systemName: "message") ?? UIImage())
        return button
    }()
    private lazy var shareButton: UIButton = {
        let button = support.createButtonWithImage(UIImage(systemName: "paperplane") ?? UIImage())
        return button
    }()
    private lazy var saveButton: UIButton = {
        let button = support.createButtonWithImage(UIImage(systemName: "bookmark") ?? UIImage())
        return button
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = support.createDescriptionLabel("This is me")
        return label
    }()
    private lazy var dateLabel: UILabel = {
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

// MARK: - ViewCell settings
extension DetailPostTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    func configureCell(with post: Post) {
        setImageAsync(post.author.iconUrl ?? nil)
        self.nickLabel.text = post.author.nick
        self.photoOfPost.image = post.photos
        self.descriptionLabel.text = post.description
        self.dateLabel.text = support.formateDataToString(post.dateOfPublication)
    }
}

// MARK: - Support things
extension DetailPostTableViewCell {
    private func setImageAsync(_ url: URL?) {
        guard let rigthUrl = url else { return }
        DispatchQueue.global(qos: .utility).async {
            if let data = try? Data(contentsOf: rigthUrl) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.iconImage.image = image
                        print("фото загрузилось")
                    }
                }
            }
        }
    }
    private func getIndexPath() -> IndexPath {
        return (table?.indexPath(for: self) ?? IndexPath(row: 0, section: 0))
    }
}

// MARK: - Constraints
extension DetailPostTableViewCell {
    private func setupLayouts() {
        let actionsStackView = support.createSV([likeButton, commentButton, shareButton], axis: .horizontal, align: .fill)
        actionsStackView.spacing = 5
        let descriptionStackView = support.createSV([descriptionLabel, dateLabel], align: .fill)

        contentView.addSubview(iconImage)
        contentView.addSubview(nickLabel)
        contentView.addSubview(additionalButton)
        contentView.addSubview(photoOfPost)
        contentView.addSubview(actionsStackView)
        contentView.addSubview(saveButton)
        contentView.addSubview(descriptionStackView)

        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 7),
            iconImage.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 7),
            iconImage.heightAnchor.constraint(equalToConstant: 50),
            iconImage.widthAnchor.constraint(equalToConstant: 50),

            nickLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 65),
            nickLabel.centerYAnchor.constraint(equalTo: iconImage.centerYAnchor),
            nickLabel.heightAnchor.constraint(equalTo: iconImage.heightAnchor),

            additionalButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            additionalButton.centerYAnchor.constraint(equalTo: nickLabel.centerYAnchor),

            photoOfPost.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 7),
            photoOfPost.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            photoOfPost.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            photoOfPost.heightAnchor.constraint(equalToConstant: contentView.frame.width),

            actionsStackView.topAnchor.constraint(equalTo: photoOfPost.bottomAnchor, constant: 10),
            actionsStackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 7),

            saveButton.topAnchor.constraint(equalTo: photoOfPost.bottomAnchor, constant: 10),
            saveButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -5),

            descriptionStackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            descriptionStackView.topAnchor.constraint(equalTo: actionsStackView.bottomAnchor, constant: 5),
            descriptionStackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
    }
}
