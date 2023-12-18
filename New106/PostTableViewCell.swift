//
//  PostsTableViewCell.swift
//  New106
//
//  Created by Alina on 01.11.2023.
//

import UIKit

 protocol PostTableViewCellDelegate: AnyObject {
     func didDeletePost(postModel: Publication)
 }

 class PostTableViewCell: UITableViewCell {

     var deleteTapped: ((_ alertController: UIAlertController) -> Void)?

     weak var delegate: PostTableViewCellDelegate?
     
     lazy var avatarImageView: UIImageView = {
         let image = UIImageView()
         image.translatesAutoresizingMaskIntoConstraints = false
         image.backgroundColor = .black
         image.image = UIImage(named: "1")
         image.layer.cornerRadius = 20
         image.clipsToBounds = true
         return image
     }()
     
     lazy var postImageView: UIImageView = {
         let image = UIImageView()
         image.translatesAutoresizingMaskIntoConstraints = false
         image.backgroundColor = .black
         image.image = UIImage(named: "2")
         image.clipsToBounds = true
         return image
     }()

     lazy var usernameLabel: UILabel = {
         let label = UILabel()
         label.text = "radzhaaa"
         label.font = UIFont.boldSystemFont(ofSize: 18)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
     
     lazy var captionLabel: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.font = UIFont.boldSystemFont(ofSize: 14)
         return label

     }()
     lazy var dateLabel: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.font = UIFont.boldSystemFont(ofSize: 14)
         return label
     }()
     lazy var optionsButton: UIButton = {
         let button = UIButton()
         button.translatesAutoresizingMaskIntoConstraints = false
         button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
         button.tintColor = .black
         return button
     }()
     
     lazy var likeButton: UIButton = {
     let action = UIAction { [weak self] _ in
     self?.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
     }
     let button = UIButton(type: .custom, primaryAction: action)
     button.translatesAutoresizingMaskIntoConstraints = false
     button.tintColor = .black
     button.setImage(UIImage(systemName: "suit.heart"), for: .normal)
     button.tintColor = .black
     return button
     }()
     lazy var commentButton: UIButton = {
         let button = UIButton()
         button.translatesAutoresizingMaskIntoConstraints = false
         button.setImage(UIImage(systemName: "message"), for: .normal)
         button.tintColor = .black
         return button
     }()
     lazy var shareButton: UIButton = {
         let button = UIButton()
         button.translatesAutoresizingMaskIntoConstraints = false
         button.setImage(UIImage(systemName: "paperplane"), for: .normal)
         button.tintColor = .black
         return button
     }()
     lazy var saveButton: UIButton = {
         let button = UIButton()
         button.translatesAutoresizingMaskIntoConstraints = false
         button.setImage(UIImage(systemName: "bookmark"), for: .normal)
         button.tintColor = .black
         return button
     }()


     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         setUp()
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

     private func setUp() {
         contentView.addSubview(avatarImageView)
         contentView.addSubview(usernameLabel)
         contentView.addSubview(optionsButton)
         contentView.addSubview(postImageView)
         contentView.addSubview(saveButton)
         contentView.addSubview(captionLabel)
         contentView.addSubview(dateLabel)
         
         let buttonStackView = UIStackView(arrangedSubviews: [likeButton,commentButton,shareButton])
         buttonStackView.axis = .horizontal
         buttonStackView.distribution = .fillEqually
         buttonStackView.translatesAutoresizingMaskIntoConstraints = false
         

         contentView.addSubview(buttonStackView)
         NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            avatarImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 10),
            avatarImageView.bottomAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 40),
            avatarImageView.trailingAnchor.constraint(equalTo: avatarImageView.leadingAnchor,constant: 40),
            
            usernameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            
            optionsButton.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            optionsButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: 10),
            optionsButton.leadingAnchor.constraint(equalTo: optionsButton.trailingAnchor,constant: -50),
            
            postImageView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10),
            postImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            postImageView.bottomAnchor.constraint(equalTo: postImageView.topAnchor,constant: 350),
            
            saveButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor,constant: 5),
            saveButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: 10),
            saveButton.leadingAnchor.constraint(equalTo: optionsButton.trailingAnchor,constant: -50),
            
            buttonStackView.topAnchor.constraint(equalTo: postImageView.bottomAnchor,constant: 5),
            buttonStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor,constant: -40),
            
            captionLabel.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor,constant: 5),
            captionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 10),
            captionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: captionLabel.bottomAnchor,constant: 15),
            dateLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 10)
         ])
     }

     func configure(with publication: Publication) {
         avatarImageView.image = publication.avatarImage
         usernameLabel.text = publication.username
         postImageView.image = publication.postImage
         captionLabel.text = publication.caption
         dateLabel.text = publication.date

         let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

         let deleteAction = UIAlertAction(title: "Удалить пост", style: .destructive) { [weak self] _ in
             self?.delegate?.didDeletePost(postModel: publication)
         }
         let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)

         alertController.addAction(deleteAction)
         alertController.addAction(cancelAction)

         optionsButton.addAction(UIAction(handler: { _  in
             self.deleteTapped!(alertController)
         }), for: .touchUpInside)
     }

     
 }

 extension UITableViewCell {
     static var reuseIdentifier: String {
         return String(describing: self)
     }
 }

protocol PostCollectionViewCellDelegate: AnyObject {
    func didDeletePost(post: Post)
}
