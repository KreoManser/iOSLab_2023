//
//  LentaPostsTableViewCell.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 09.11.2023.
//

import UIKit
class LentaPostsTableViewCell: UITableViewCell {
    var currentPublication: Publication?
    weak var delegate: PublicationCellDelegate?
    private lazy var imageAvatar: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var labelName: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var buttonThreePoint: UIButton = {
        let action = UIAction { _ in
            Task {
                guard let currentUser = await RegistrationDataManager.shared.getCurrentUser() else {return}
                guard let publication = self.currentPublication else {return}

                for publicatione in currentUser.publications where publicatione.id == publication.id {
                    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                    let deleteAction = UIAlertAction(title: "Удалить пост", style: .destructive) { _ in
                        PublicationDataManager.shared.asyncDelete(publication)
                    }
                    let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
                    alertController.addAction(deleteAction)
                    alertController.addAction(cancelAction)
                    if let viewController = self.delegate as? UIViewController {
                        viewController.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        }
        let button = UIButton(type: .custom, primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "threePoints"), for: .normal)
        return button
    }()
    private lazy var photoPublication: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var heartIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "heartIcon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var messageIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "messageIcon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var planeIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "planeIcon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var favoriteIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "favoriteIcon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var descriptionPublication: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    private lazy var datePublication: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .white
        return label
    }()
    override func prepareForReuse() {
        super.prepareForReuse()
        photoPublication.image = nil
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        contentView.addSubview(imageAvatar)
        contentView.addSubview(labelName)
        contentView.addSubview(buttonThreePoint)
        contentView.addSubview(photoPublication)
        contentView.addSubview(descriptionPublication)
        contentView.addSubview(datePublication)
        contentView.addSubview(favoriteIcon)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        let iconsStackView = UIStackView(arrangedSubviews: [heartIcon, messageIcon, planeIcon])
        iconsStackView.translatesAutoresizingMaskIntoConstraints = false
        iconsStackView.axis = .horizontal
        iconsStackView.alignment = .leading
        iconsStackView.distribution = .fillEqually
        iconsStackView.spacing = 5
        contentView.addSubview(iconsStackView)
        NSLayoutConstraint.activate([
            imageAvatar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            imageAvatar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageAvatar.widthAnchor.constraint(equalToConstant: 30),
            imageAvatar.heightAnchor.constraint(equalToConstant: 30),
            labelName.leadingAnchor.constraint(equalTo: imageAvatar.trailingAnchor, constant: 10),
            labelName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            buttonThreePoint.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            buttonThreePoint.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            photoPublication.topAnchor.constraint(equalTo: imageAvatar.bottomAnchor, constant: 10),
            photoPublication.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoPublication.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoPublication.heightAnchor.constraint(equalToConstant: 570),
            iconsStackView.topAnchor.constraint(equalTo: photoPublication.bottomAnchor, constant: 15),
            iconsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            iconsStackView.widthAnchor.constraint(equalToConstant: 100),
            iconsStackView.heightAnchor.constraint(equalToConstant: 35),
            heartIcon.widthAnchor.constraint(equalToConstant: 30),
            heartIcon.heightAnchor.constraint(equalToConstant: 25),
            planeIcon.heightAnchor.constraint(equalToConstant: 25),
            planeIcon.widthAnchor.constraint(equalToConstant: 30),
            favoriteIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            favoriteIcon.topAnchor.constraint(equalTo: photoPublication.bottomAnchor, constant: 15),
            favoriteIcon.heightAnchor.constraint(equalToConstant: 35),
            descriptionPublication.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            descriptionPublication.topAnchor.constraint(equalTo: iconsStackView.bottomAnchor, constant: 15),
            datePublication.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            datePublication.topAnchor.constraint(equalTo: descriptionPublication.bottomAnchor, constant: 10)
        ])
    }
    func configure(with publication: Publication) {
        imageAvatar.image = publication.imageAvatar
        labelName.text = publication.label
        photoPublication.image = publication.image
        datePublication.text = publication.date
        descriptionPublication.text = publication.description
    }
}
