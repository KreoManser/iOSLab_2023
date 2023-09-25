//
//  TableViewCell.swift
//  HomeWork_3
//
//  Created by Нияз Ризванов on 24.09.2023.
//

import UIKit

class BasketTableViewCell: UITableViewCell {

    private lazy var imageProduct: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var labelDescriptionProduct: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelCountProduct: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageProduct.image = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier )
        contentView.addSubview(imageProduct)
        contentView.addSubview(labelDescriptionProduct)
        contentView.addSubview(labelCountProduct)
        
        setupLayuot()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with card: ProductCard) {
        imageProduct.image = card.photoProduct
        labelDescriptionProduct.text = card.descrption
        labelCountProduct.text = card.count
    }
    
    private func setupLayuot() {
        NSLayoutConstraint.activate([
            imageProduct.heightAnchor.constraint(equalToConstant: 75),
            imageProduct.widthAnchor.constraint(equalToConstant: 110),
            imageProduct.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            imageProduct.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            labelDescriptionProduct.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            labelDescriptionProduct.leadingAnchor.constraint(equalTo: imageProduct.trailingAnchor,constant: 10),
            
            labelCountProduct.topAnchor.constraint(equalTo: labelDescriptionProduct.bottomAnchor,constant: 10),
            labelCountProduct.leadingAnchor.constraint(equalTo: labelDescriptionProduct.leadingAnchor)
        ])
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

