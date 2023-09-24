//
//  TableViewCell.swift
//  HomeWork3
//
//  Created by Faki Doosuur Doris on 24.09.2023.
//

import UIKit

class OutfitTableViewCell: UITableViewCell {
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurationCell(with outfit: Outfit) {
        avatarImageView.image = outfit.avatarImage
        titleLabel.text = outfit.name
        priceLabel.text = outfit.price
        subtitleLabel.text = outfit.size
    }
    
    private func setUpLayout() {
        guard avatarImageView.superview == nil else { return }
        let mainStackView = UIStackView(arrangedSubviews: [titleLabel,subtitleLabel])
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalSpacing
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(mainStackView)
        contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            priceLabel.leadingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            priceLabel.centerYAnchor.constraint(equalTo: mainStackView.centerYAnchor),
            
        ])
    }
}
extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
