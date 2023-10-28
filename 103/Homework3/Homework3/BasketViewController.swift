//
//  BasketViewController.swift
//  Homework3
//
//  Created by kerik on 28.09.2023.
//

import UIKit

class BasketViewController: UIViewController {
    private lazy var basketLabel: UILabel = {
        let label = UILabel()
        label.text = "Корзина"
        label.textColor = .black
        label.font = label.font.withSize(30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var basketStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Ваша корзина пуста"
        label.textColor = .gray
        label.font = label.font.withSize(30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var payButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Купить", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemGray3
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Назад", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemGray3
        button.addAction(UIAction { [weak self] _ in
            self?.navigationController?.popViewController(animated: true) }, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
        addSubviews(basketLabel, basketStatusLabel, payButton, exitButton)
        setLayout()

    }
}

extension BasketViewController {
    private func addSubviews(_ subviews: UIView...) {
        subviews.forEach { view.addSubview($0) }
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            basketLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            basketLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            basketStatusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            basketStatusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            payButton.widthAnchor.constraint(equalToConstant: 223),
            payButton.heightAnchor.constraint(equalToConstant: 33),
            payButton.bottomAnchor.constraint(equalTo: exitButton.topAnchor, constant: -10),
            payButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            exitButton.widthAnchor.constraint(equalToConstant: 223),
            exitButton.heightAnchor.constraint(equalToConstant: 33),
            exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
