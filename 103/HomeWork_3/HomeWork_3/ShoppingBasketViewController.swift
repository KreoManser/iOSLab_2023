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
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Корзина"
        label.font = label.font.withSize(30)
        label.textColor = .black
        return label
    }()
    
    private lazy var basketStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Корзина пока пуста"
        label.font = label.font.withSize(30)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Buttons
    private lazy var exitButton: UIButton = {
        let action = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
        let button =  UIButton(configuration: .filled(), primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.baseBackgroundColor = .darkGray
        button.setTitle("Вернуться", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var payButton: UIButton = {
        let button =  UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.baseBackgroundColor = .darkGray
        button.setTitle("Оплатить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    // MARK: - Stackview
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [payButton, exitButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 25
        return stackView
    }()
    
    // MARK: - Lise cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AddSubviews(titleLabel, basketStatusLabel, buttonsStackView)
        
        configureUI()
    }
}

extension ShoppingBasketViewController {
    private func AddSubviews(_ subviews: UIView ...) {
        subviews.forEach { view.addSubview($0) }
    }
    
    // MARK: - configureUI func
    private func configureUI() {
        view.backgroundColor = UIColor(displayP3Red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        
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
}
