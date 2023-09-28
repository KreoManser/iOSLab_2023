//
//  ProductTableViewCell.swift
//  Homework3
//
//  Created by kerik on 28.09.2023.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    private lazy var productImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productCostLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGray3
        addSubviews(productImage, productNameLabel, productCostLabel)
        setLayout()
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
        productCostLabel.text = "Цена: " + product.cost + " руб"
    }
}

extension ProductTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    private func addSubviews(_ subviews: UIView ...) {
        subviews.forEach { contentView.addSubview($0) }
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            productImage.widthAnchor.constraint(equalToConstant: 65),
            productImage.heightAnchor.constraint(equalToConstant: 65),
            productImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),

            productNameLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 20),
            productNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            productCostLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            productCostLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}
