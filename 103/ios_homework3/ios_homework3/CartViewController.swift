//
//  CartViewController.swift
//  ios_homework3
//
//  Created by Аделя Миннехузина on 23.09.2023.
//

import UIKit

class CartViewController: UIViewController {
    
    private lazy var OrangeSweaterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "orange")
        return imageView
    }()
    
    private lazy var BrownSweaterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "brown")
        return imageView
    }()
    
    private lazy var OrangeSweaterNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Оранжевый свитер"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var BrownSweaterNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Коричневый свитер"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var OrangeSweaterPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "1499.99"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var BrownSweaterPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "1699.99"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ShopButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("Магазин", for: .normal)
        button.addTarget(self, action: #selector(ShopButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    @objc private func ShopButtonDidTap(sender: UIButton!) {
        let shopViewController = ShopViewController()
        navigationController?.pushViewController(shopViewController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationItem.title = "Моя корзина"
        view.addSubview(OrangeSweaterImageView)
        view.addSubview(OrangeSweaterNameLabel)
        view.addSubview(OrangeSweaterPriceLabel)
        view.addSubview(BrownSweaterImageView)
        view.addSubview(BrownSweaterNameLabel)
        view.addSubview(BrownSweaterPriceLabel)
        view.addSubview(ShopButton)
        
        setupLayout()
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            OrangeSweaterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            OrangeSweaterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            OrangeSweaterImageView.widthAnchor.constraint(equalToConstant: 70),
            OrangeSweaterImageView.heightAnchor.constraint(equalToConstant: 70),
            
            OrangeSweaterNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            OrangeSweaterNameLabel.leadingAnchor.constraint(equalTo: OrangeSweaterImageView.trailingAnchor, constant: 15),
            
            OrangeSweaterPriceLabel.topAnchor.constraint(equalTo: OrangeSweaterNameLabel.bottomAnchor, constant: 9),
            OrangeSweaterPriceLabel.leadingAnchor.constraint(equalTo: OrangeSweaterImageView.trailingAnchor, constant: 15),
            
            BrownSweaterImageView.topAnchor.constraint(equalTo: OrangeSweaterImageView.bottomAnchor, constant: 25),
            BrownSweaterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            BrownSweaterImageView.widthAnchor.constraint(equalToConstant: 70),
            BrownSweaterImageView.heightAnchor.constraint(equalToConstant: 70),

            BrownSweaterNameLabel.topAnchor.constraint(equalTo: OrangeSweaterImageView.bottomAnchor, constant: 33),
            BrownSweaterNameLabel.leadingAnchor.constraint(equalTo: OrangeSweaterImageView.trailingAnchor, constant: 15),

            BrownSweaterPriceLabel.topAnchor.constraint(equalTo: BrownSweaterNameLabel.bottomAnchor, constant: 9),
            BrownSweaterPriceLabel.leadingAnchor.constraint(equalTo: OrangeSweaterImageView.trailingAnchor, constant: 15),
            
            ShopButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -55),
            ShopButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 125),
            ShopButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -125)
        ])
    }

}
