//
//  ProductTableViewCell.swift
//  103
//
//  Created by Alina on 24.09.2023.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    private lazy var productImageView: UIImageView = {
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
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rightSideLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        productImageView.image = nil
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with product: Product) {
        
        productImageView.image = product.ProductImage
        titleLabel.text = product.name
        subtitleLabel.text = product.color
        rightSideLabel.text = product.price
    }
    
    private func setupLayout() {
        
        guard productImageView.superview == nil else { return }
        
        let mainStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(productImageView)
        contentView.addSubview(mainStackView)
        contentView.addSubview(rightSideLabel)
        
        NSLayoutConstraint.activate([
            productImageView.heightAnchor.constraint(equalToConstant: 30),
            productImageView.widthAnchor.constraint(equalToConstant: 30),
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            rightSideLabel.leadingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            rightSideLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            rightSideLabel.centerYAnchor.constraint(equalTo: mainStackView.centerYAnchor),
        ])
    }

}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
