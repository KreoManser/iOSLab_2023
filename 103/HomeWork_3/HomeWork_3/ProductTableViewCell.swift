//
//  ProductTableViewCell.swift
//  HomeWork_3
//
//  Created by Камил Хайрутдинов on 24.09.2023.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    // MARK: - UI elements
    
    // MARK: - Image
    lazy var productImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.frame = CGRectMake(0, 0, 50, 50)
        return image
    }()
    
    // MARK: - Labels
    lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    lazy var productDecriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(10)
        label.textColor = .black
        return label
    }()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        productImage.image = nil
    }
    
    func configureCell(with product: Product) {
        
        productImage.image = product.image
        productNameLabel.text = product.name
        productPriceLabel.text = product.price
        productDecriptionLabel.text = product.description
    }
    
    // MARK: - Setup layout func
    private func setupLayout() {
        contentView.backgroundColor = UIColor(displayP3Red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        
        contentView.addSubview(productImage)
//        contentView.addSubview(productNameLabel)
//        contentView.addSubview(productPriceLabel)
//        contentView.addSubview(productDecriptionLabel)
        
        
        NSLayoutConstraint.activate([
            productImage.heightAnchor.constraint(equalToConstant: 50),
            productImage.heightAnchor.constraint(equalToConstant: 50),
            productImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5)
        ])
    }
}

// MARK: - reuse Identifier
extension ProductTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
