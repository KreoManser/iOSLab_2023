//
//  FriendsTableViewCell.swift
//  homework_9
//
//  Created by Кирилл Щёлоков on 24.11.2023.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    lazy var cellImageView: UIImageView = UIImageView()
    lazy var nameLabel: UILabel = UILabel()
    lazy var optionButton: UIButton = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpCellImageView()
        setUpOptionButton()
        setUpNameLabel()
    }

    func configure(with user: User) {
        guard let imageData = user.avatarImage else {return}
        cellImageView.image = UIImage(data: imageData)
        nameLabel.text = user.login
    }

    private func setUpCellImageView() {
        contentView.addSubview(cellImageView)
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        cellImageView.contentMode = .scaleAspectFill
        cellImageView.clipsToBounds = true
        cellImageView.layer.cornerRadius = 15

        NSLayoutConstraint.activate([
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cellImageView.widthAnchor.constraint(equalToConstant: 30),
            cellImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func setUpOptionButton() {
        contentView.addSubview(optionButton)
        optionButton.setImage(UIImage.dotsIcon, for: .normal)
        optionButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            optionButton.centerYAnchor.constraint(equalTo: cellImageView.centerYAnchor),
            optionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            optionButton.widthAnchor.constraint(equalToConstant: 30),
            optionButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func setUpNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: cellImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: optionButton.leadingAnchor, constant: -10)
        ])
    }
}
