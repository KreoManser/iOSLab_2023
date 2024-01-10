//
//  UserTableViewCell.swift
//  IosHW103
//
//  Created by Ильмир Шарафутдинов on 09.01.2024.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    let avatarImageViewHeightWidthAnchorConstraint = 60
    let mainStackViewRightLeadingAnchorConstraint = 16
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
    }
    
    func configureCell(with user: User) {
        avatarImageView.image = user.avatarImageView
        nameLabel.text = user.name
        priceLabel.text = user.price
    }
    
    private func setupLayout() {
        guard avatarImageView.superview == nil else { return}
        let mainStackView = UIStackView(arrangedSubviews: [nameLabel, priceLabel])
        
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillProportionally
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(mainStackView)
        contentView.addSubview(rightLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: CGFloat(avatarImageViewHeightWidthAnchorConstraint)),
            avatarImageView.heightAnchor.constraint(equalToConstant: CGFloat(avatarImageViewHeightWidthAnchorConstraint)),
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: CGFloat(mainStackViewRightLeadingAnchorConstraint)),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            rightLabel.leadingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            rightLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -CGFloat(mainStackViewRightLeadingAnchorConstraint)),
            rightLabel.centerYAnchor.constraint(equalTo: mainStackView.centerYAnchor)
        ])
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}



