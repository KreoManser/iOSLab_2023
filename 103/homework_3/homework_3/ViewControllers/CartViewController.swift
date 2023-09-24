//
//  CartViewController.swift
//  homework_3
//
//  Created by Данил on 24.09.2023.
//

import UIKit

internal class CartViewController: UIViewController{
    
    private lazy var cartImageView: UIImageView = {
        let image = UIImageView();
        image.translatesAutoresizingMaskIntoConstraints = false;
        image.image = UIImage(named: "cart");
        image.contentMode = .scaleAspectFit;
        
        return image;
    }()
    
    private lazy var cartLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "Корзина пока что пуста...";
        label.font = UIFont.systemFont(ofSize: 20);
        label.textColor = .black;
        
        return label;
    }()
    
    private lazy var exitButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.setTitle("Выйти", for: .normal);
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12);
        button.setTitleColor(.black, for: .normal);
        button.backgroundColor = .systemGray3;
        button.layer.cornerRadius = 5;
        button.addTarget(self, action: #selector(exitButtonPressed), for: .touchUpInside);
        
        return button;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        view.backgroundColor = .white;
        
        addSubviews();
        setConstraints();
    }
    
    private func addSubviews(){
        view.addSubview(cartImageView);
        view.addSubview(cartLabel);
        view.addSubview(exitButton)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            cartImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            cartImageView.widthAnchor.constraint(equalToConstant: 100),
            cartImageView.heightAnchor.constraint(equalToConstant: 100),
            cartImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cartImageView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16),
            cartImageView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16),
            cartImageView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -16),
            
            cartLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cartLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            exitButton.widthAnchor.constraint(equalToConstant: 200),
            exitButton.heightAnchor.constraint(equalToConstant: 30),
            exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exitButton.topAnchor.constraint(equalTo: cartLabel.bottomAnchor, constant: 320),
        ])
    }
    
    @objc private func exitButtonPressed() {
        dismiss(animated: true)
    }
}
