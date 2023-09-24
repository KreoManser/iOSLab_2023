//
//  ShopTableViewCell.swift
//  ios_homework3
//
//  Created by Аделя Миннехузина on 24.09.2023.
//

import UIKit

class ShopTableViewCell: UITableViewCell {
    
    private lazy var sweaterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var sweaterNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sweaterPriceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        sweaterImageView.image = nil
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with shop: Shop) {
        
        sweaterImageView.image = shop.sweaterImage
        sweaterNameLabel.text = shop.sweaterName
        sweaterPriceLabel.text = shop.sweaterPrice
    }
    
    private func setupLayout() {
        
        guard sweaterImageView.superview == nil else { return }
        
        contentView.addSubview(sweaterImageView)
        contentView.addSubview(sweaterNameLabel)
        contentView.addSubview(sweaterPriceLabel)
        
        NSLayoutConstraint.activate([
            sweaterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            sweaterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            sweaterImageView.widthAnchor.constraint(equalToConstant: 40),
            sweaterImageView.heightAnchor.constraint(equalToConstant: 40),
            
            sweaterNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            sweaterNameLabel.leadingAnchor.constraint(equalTo: sweaterImageView.trailingAnchor, constant: 15),
            
            sweaterPriceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            sweaterPriceLabel.leadingAnchor.constraint(equalTo: sweaterNameLabel.trailingAnchor, constant: 15),
        ])
    }

}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
