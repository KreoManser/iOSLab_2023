//
//  ShopTableViewCell.swift
//  AuthorisationWithCode
//
//  Created by Mac on 2023-09-26.
//

import UIKit

class ShopTableViewCell: UITableViewCell {
    // MARK: - Declaration objects
    private lazy var productImage: UIImageView = {
        let image = UIImageView()
        image.setImage(name: "photo", cornerRadius: 0)
        return image
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.setLable(title: ".")
        return label
    }()
    
    private lazy var productCostLabel: UILabel = {
        let label = UILabel()
        label.setLable(title: ".")
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Constraints
extension ShopTableViewCell {
    private func setupLayouts() {
        
        contentView.addSubview(productImage)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productCostLabel)
        
        NSLayoutConstraint.activate([
            productImage.widthAnchor.constraint(equalToConstant: 60),
            productImage.heightAnchor.constraint(equalToConstant: 60),
            productImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            
            productNameLabel.leadingAnchor.constraint(equalTo: productImage.leadingAnchor, constant: 70),
            productNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            productCostLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            productCostLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}

// MARK: - ViewCell settings
extension ShopTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    func conigureCell(with product: Product) {
        productImage.image = UIImage(named: product.imageName)
        productNameLabel.text = product.name
        productCostLabel.text = String(product.cost)
    }
}
