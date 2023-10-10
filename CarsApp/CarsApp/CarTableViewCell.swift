//
//  CarTableViewCell.swift
//  CarsApp
//
//  Created by kerik on 10.10.2023.
//

import UIKit

class CarTableViewCell: UITableViewCell {
    private lazy var carImage: UIImageView = {
            let image = UIImageView()
            image.contentMode = .scaleAspectFill
            image.layer.masksToBounds = true
            image.layer.cornerRadius = 10
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
        }()
        
        private lazy var carNameLabel: UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private lazy var carCostLabel: UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    private lazy var buyButton: UIButton = {
        let button = UIButton(configuration: .bordered())
        button.setTitle("Добавить в корзину", for: .normal)
        button.tintColor = .black
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            contentView.backgroundColor = .systemGray3
            addSubviews(carImage, carNameLabel, carCostLabel, buyButton)
            setLayout()
        }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
            
        override func prepareForReuse() {
            super.prepareForReuse()
            carImage.image = nil
        }
            
        func configureCellForCarList(with car: Car, action: UIAction) {
            carImage.image = car.image
            carNameLabel.text = car.name
            carCostLabel.text = "Цена: " + String(car.cost) + " руб"
            buyButton.addAction(action, for: .touchUpInside)
        }
    
        func conigureCellforBasket(with car: Car) {
            carImage.image = car.image
            carNameLabel.text = car.name
            carCostLabel.text = "Цена: " + String(car.cost) + " руб"
            //buyButton.addAction(action, for: .touchUpInside)
            buyButton.setTitle("Удалить", for: .normal)
    }
}

extension CarTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    private func addSubviews(_ subviews: UIView ...) {
        subviews.forEach { contentView.addSubview($0) }
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            carImage.widthAnchor.constraint(equalToConstant: 80),
            carImage.heightAnchor.constraint(equalToConstant: 80),
            carImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            carImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),

            carNameLabel.leadingAnchor.constraint(equalTo: carImage.trailingAnchor, constant: 30),
            carNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            carCostLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            carCostLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            buyButton.widthAnchor.constraint(equalToConstant: 130),
            buyButton.heightAnchor.constraint(equalToConstant: 40),
            buyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            buyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
