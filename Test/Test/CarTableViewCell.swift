//
//  CarTableViewCell.swift
//  Test
//
//  Created by Alina on 10.10.2023.
//

import UIKit

protocol CarCellDelegate: AnyObject {
    func didPressDetailDisclosure()
    func didSelectCar(_ car: Car)
}

class CarTableViewCell: UITableViewCell {

    let carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let modelLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var AddButton: UIButton = {

       
        let action = UIAction { _ in
            self.delegate?.didPressDetailDisclosure()
        }
        let button = UIButton(type: .contactAdd, primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        
        return button
    }()
    
    func configureCell(with car: Car) {
        carImageView.image = car.image
        modelLabel.text = car.model
        priceLabel.text = "\(car.price)" + "$"
    }
    
    weak var delegate: CarCellDelegate?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        carImageView.image = nil
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLayout()
        
    }
    
    private func setupLayout() {
        
        guard carImageView.superview == nil else { return }
        
        contentView.addSubview(carImageView)
        contentView.addSubview(modelLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(AddButton)
        
        NSLayoutConstraint.activate([
            carImageView.heightAnchor.constraint(equalToConstant: 80),
            carImageView.widthAnchor.constraint(equalToConstant: 80),
            carImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            carImageView.trailingAnchor.constraint(equalTo: AddButton.leadingAnchor,constant: -40),
            carImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: 10),
            modelLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            modelLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,constant: 10),
            priceLabel.topAnchor.constraint(equalTo: modelLabel.bottomAnchor, constant: 15),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,constant: 10),
            AddButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            AddButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}



