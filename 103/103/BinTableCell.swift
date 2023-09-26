//
//  BinPageTableCell.swift
//  103
//
//  Created by Dmitry on 24.09.2023.
//

import UIKit

class BinPageTableCell: UITableViewCell {
    
    private lazy var productPictureImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 7
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var productAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with: Product) {
        productPictureImageView.image = with.image
        productNameLabel.text = with.name
        productAmountLabel.text = String(Int(with.cost)) + " шт."
    }
    
    func setUpLayout() {
        guard productPictureImageView.superview == nil else { return }
        contentView.addSubview(productPictureImageView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productAmountLabel)
    }
}

extension UITableViewCell {
    static var reuseIdentifire: String {
        return String(describing: self)
    }
}

extension BinPageTableCell {
    
    func setUpConstraints() {
        setUpAvatarImageConstraints()
        setUpUserProductNameConstraints()
        setUpUserProductAmountLabelConstraints()
    }
    
    func setUpAvatarImageConstraints() {
        NSLayoutConstraint.activate([
            productPictureImageView.heightAnchor.constraint(equalToConstant: 35),
            productPictureImageView.widthAnchor.constraint(equalToConstant: 35),
            productPictureImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productPictureImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    func setUpUserProductNameConstraints() {
        NSLayoutConstraint.activate([
            productNameLabel.leadingAnchor.constraint(equalTo: productPictureImageView.trailingAnchor, constant: 10),
            productNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func setUpUserProductAmountLabelConstraints() {
        NSLayoutConstraint.activate([
            productAmountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productAmountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
}
