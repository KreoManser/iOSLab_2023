//
//  ShopItemTableViewCell.swift
//  HW_103
//
//  Created by Азат Зиганшин on 26.09.2023.
//

import UIKit

class ShopItemTableViewCell: UITableViewCell {

    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var addToBasketButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Добавить в корзину"
        config.baseForegroundColor = UIColor.white
        config.background.backgroundColor = UIColor.systemBlue
        config.background.cornerRadius = 10
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImageView.image = nil
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with shopItem: ShopItem) {
        
        avatarImageView.image = shopItem.avatarImage
        nameLabel.text = shopItem.name
    }
}

extension ShopItemTableViewCell {
    
    func setupLayout() {
        
        guard avatarImageView.superview == nil else { return }
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(addToBasketButton)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 40),
            
            addToBasketButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            addToBasketButton.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
        ])
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
