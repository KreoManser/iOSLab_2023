//
//  BasketCarsListTableViewCell.swift
//  MyCarDealership
//
//  Created by Азат Зиганшин on 10.10.2023.
//

import UIKit

class BasketCarsListTableViewCell: UITableViewCell {

    private lazy var carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var modelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var addToBasketButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Убрать из корзины"
        config.baseForegroundColor = UIColor.white
        config.background.backgroundColor = UIColor.systemBlue
        config.background.cornerRadius = 10
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        carImageView.image = nil
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with car: Car) {
        carImageView.image = car.image
        modelLabel.text = car.model
        priceLabel.text = String(car.price)
    }
}

extension BasketCarsListTableViewCell {
    
    func setupLayout() {
        
        guard carImageView.superview == nil else { return }
        
        contentView.addSubview(carImageView)
        contentView.addSubview(modelLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(addToBasketButton)
        
        NSLayoutConstraint.activate([
            carImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            carImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            carImageView.heightAnchor.constraint(equalToConstant: 100),
            carImageView.widthAnchor.constraint(equalTo: carImageView.heightAnchor),
            
            modelLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            modelLabel.leadingAnchor.constraint(equalTo: carImageView.trailingAnchor, constant: 20),
            
            priceLabel.leadingAnchor.constraint(equalTo: modelLabel.leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: modelLabel.bottomAnchor, constant: 10),
            
            addToBasketButton.leadingAnchor.constraint(equalTo: modelLabel.leadingAnchor),
            addToBasketButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10)
        ])
    }
}

