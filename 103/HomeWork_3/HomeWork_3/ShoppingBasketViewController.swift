//
//  ShoppingBasketViewController.swift
//  HomeWork_3
//
//  Created by Камил Хайрутдинов on 24.09.2023.
//

import UIKit

class ShoppingBasketViewController: UIViewController {
    
    // MARK: - UI elements
    
    // MARK: - Labels
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Корзина"
        label.font = label.font.withSize(30)
        label.textColor = .black
        return label
    }()
    
    lazy var basketStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Корзина пока пуста"
        label.font = label.font.withSize(30)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Buttons
    lazy var exitButton: UIButton = {
        let button =  UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.baseBackgroundColor = .darkGray
        button.setTitle("Вернуться", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var payButton: UIButton = {
        let button =  UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.baseBackgroundColor = .darkGray
        button.setTitle("Оплатить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    // MARK: - Lise cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupButtonTarget()
    }
    
    // MARK: - Setup layot func
    private func setupLayout() {
        view.backgroundColor = UIColor(displayP3Red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        
        let buttonsStackView = UIStackView(arrangedSubviews: [payButton, exitButton])
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.spacing = 25
        
        view.addSubview(titleLabel)
        view.addSubview(basketStatusLabel)
        view.addSubview(buttonsStackView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            basketStatusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            basketStatusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            exitButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            exitButton.heightAnchor.constraint(equalToConstant: 35),
            
            payButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            payButton.heightAnchor.constraint(equalToConstant: 35),
            
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Setup buttons target func
    
    private func setupButtonTarget() {
        exitButton.addTarget(self, action: #selector(exitButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Buttons logic
    @objc private func exitButtonPressed() {
        dismiss(animated: true)
    }
}
