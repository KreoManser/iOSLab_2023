//
//  SearchCollectionViewCell.swift
//  107Tukaev
//
//  Created by surexnx on 11.12.2023.
//

import UIKit

protocol CellTapDelegate: AnyObject {
    func cellDidSelect(user: User)
}

class SearchCollectionViewCell: UICollectionViewCell {

    var user: User?
    var delegate: CellTapDelegate?
    private lazy var userImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()

    private lazy var userLoginLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var userNameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        addGestureRecognizer(tapGesture)
    }

    @objc func cellTapped() {
        self.delegate?.cellDidSelect(user: user ?? User())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(user: User) {
        userImage.image = UIImage(named: user.image)
        userLoginLabel.text = user.login
        userNameLabel.text = user.name
        self.user = user
        userNameLabel.font = UIFont.systemFont(ofSize: 13)

    }

    func setupLayout() {
        addSubview(userImage)
        addSubview(userLoginLabel)
        addSubview(userNameLabel)
        let content = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: content.topAnchor, constant: 10),
            userImage.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 10),
            userImage.heightAnchor.constraint(equalToConstant: 40),
            userImage.widthAnchor.constraint(equalToConstant: 40),

            userLoginLabel.topAnchor.constraint(equalTo: content.topAnchor, constant: 10),
            userLoginLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 10),

            userNameLabel.topAnchor.constraint(equalTo: userLoginLabel.bottomAnchor, constant: 10),
            userNameLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 10)
        ])
    }

}
extension SearchCollectionViewCell {
    static var reuseIdentificator: String {
        return String(describing: self)
    }
}
