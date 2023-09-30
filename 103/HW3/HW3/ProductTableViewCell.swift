//
//  ProductTableViewCell.swift
//  HW3
//
//  Created by Kseniya Skvortsova on 27.09.2023.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    private lazy var picImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Blaka-Regular", size: 25)
        label.textColor = .yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "BhuTukaExpandedOne-Regular", size: 20)
        label.textColor = .orange
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        picImageView.image = nil
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with product: Product) {
        
        picImageView.image = product.picImage
        titleLabel.text = product.name
        subtitleLabel.text = product.subtitle
        priceLabel.text = product.price
    }
    
    private func setupLayout() {
        
        guard picImageView.superview == nil else { return }
        
        let mainStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, priceLabel])
        mainStackView.axis = .vertical
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.setCustomSpacing(20, after: subtitleLabel)
        
        contentView.addSubview(picImageView)
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            picImageView.widthAnchor.constraint(equalToConstant: 180),
            picImageView.heightAnchor.constraint(equalTo: picImageView.widthAnchor, multiplier: 1),
            picImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            picImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            mainStackView.heightAnchor.constraint(greaterThanOrEqualTo: picImageView.widthAnchor, multiplier: 1),
            mainStackView.topAnchor.constraint(equalTo: picImageView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: picImageView.trailingAnchor, constant: 10),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
