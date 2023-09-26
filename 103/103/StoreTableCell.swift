//
//  StoreTableCell.swift
//  103
//
//  Created by Dmitry on 26.09.2023.
//

import UIKit

class StoreTableCell: UITableViewCell {
    
    lazy var productPicture: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 7
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private lazy var productCost: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
        setUpProductPictureConstraints()
        setUpProductNameConstraints()
        setUpProductCostLabel()
    }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    func configureCell(with: Product) {
        productCost.text = String(with.cost) + " ₽"
        productPicture.image = with.image
        productNameLabel.text = with.name
    }
    
    func setUpLayout() {
        guard productPicture.superview == nil else { return }
        contentView.addSubview(productPicture)
        contentView.addSubview(productCost)
        contentView.addSubview(productNameLabel)
    }
    
    func setUpProductPictureConstraints() {
        NSLayoutConstraint.activate([
            productPicture.widthAnchor.constraint(equalToConstant: 50),
            productPicture.heightAnchor.constraint(equalToConstant: 50),
            productPicture.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            productPicture.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
        ])
    }
    
    func setUpProductNameConstraints() {
        NSLayoutConstraint.activate([
            productNameLabel.leadingAnchor.constraint(equalTo: productPicture.trailingAnchor, constant: 20),
            productNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    func setUpProductCostLabel() {
        NSLayoutConstraint.activate([
            productCost.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            productCost.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    
}


