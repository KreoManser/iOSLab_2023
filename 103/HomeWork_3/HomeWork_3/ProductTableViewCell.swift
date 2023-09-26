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
    private lazy var productImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 5.0
        return image
    }()
    
    // MARK: - Labels
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private lazy var productDecriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(14)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews(productImage, productNameLabel, productPriceLabel, productDecriptionLabel)
        configureUI()
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
        productPriceLabel.text = "Цена: " + product.price + " руб"
        productDecriptionLabel.text = product.description
    }
}

// MARK: - extention ProductTableViewCell
// MARK: - reuse Identifier
extension ProductTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    private func addSubviews(_ subviews: UIView ...) {
        subviews.forEach { contentView.addSubview($0) }
    }
    
    // MARK: - configureUI func
    private func configureUI() {
        contentView.backgroundColor = UIColor(displayP3Red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            productImage.widthAnchor.constraint(equalToConstant: 80),
            productImage.heightAnchor.constraint(equalToConstant: 80),
            
            productNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            productNameLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 10),
            
            productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 10),
            productPriceLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 10),
            productDecriptionLabel.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 5),
            productDecriptionLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 10)
        ])
    }
}
