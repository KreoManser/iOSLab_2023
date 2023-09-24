//
//  BucketViewController.swift
//  AuthorisationWithCode
//
//  Created by Mac on 2023-09-24.
//

import UIKit

class BucketViewController: UIViewController {
    
    lazy var bucketLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Корзина"
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    lazy var basketStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Корзина пуста, оплатите"
        
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    lazy var payButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Оплатить", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setupLayout()
    }
    
    private func setupLayout() {
        
        view.addSubview(bucketLabel)
        view.addSubview(basketStatusLabel)
        view.addSubview(payButton)
        
        NSLayoutConstraint.activate([
            bucketLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -10),
            bucketLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            basketStatusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            basketStatusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            payButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            payButton.heightAnchor.constraint(equalToConstant: 35),
            
            payButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            payButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
