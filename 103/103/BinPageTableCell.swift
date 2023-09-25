//
//  BinPageTableCell.swift
//  103
//
//  Created by Dmitry on 24.09.2023.
//

import UIKit

class BinPageTableCell: UITableViewCell {
    
    private lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var userNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
        setUpAvatarImageConstraints()
        setUpUserNameLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with: User) {
        
        avatarImageView.image = UIImage(named: "appleLogo")
        userNameLabel.text = "Valera"
        userNumberLabel.text = "228"
        
    }
    
    func setUpLayout() {
        
        guard avatarImageView.superview == nil else { return }
        
        let mainStackView = UIStackView(arrangedSubviews: [userNameLabel, userNumberLabel])
        
        
        
        contentView.addSubview(avatarImageView)
        //contentView.addSubview(mainStackView)
        contentView.addSubview(userNameLabel)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImageView.image = UIImage(named: "appleLogo")
    }
    
    func setUpAvatarImageConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -120),
            avatarImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    func setUpUserNameLabelConstraints() {
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            userNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
}
