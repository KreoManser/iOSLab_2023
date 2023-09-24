//
//  AccountViewController.swift
//  AuthorisationWithCode
//
//  Created by Mac on 2023-09-24.
//

import UIKit

class AccountViewController: UIViewController {

    lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "photo")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 100
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let name = UILabel()
        name.text = "Имя"
        name.font = UIFont.systemFont(ofSize: 30)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    lazy var numberLabel: UILabel = {
        let number = UILabel()
        number.text = "Телефон"
        number.font = UIFont.systemFont(ofSize: 30)
        number.translatesAutoresizingMaskIntoConstraints = false
        return number
    }()
    
    lazy var goToBucketButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Корзина", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(goToBucketButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func goToBucketButtonTapped() {
        let bucketViewController = BucketViewController()
        navigationController?.pushViewController(bucketViewController, animated: true)
    }
    
    lazy var somethingFirstButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Что-то", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var somethingSecondButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Что-то", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var somethingThirdButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Что-то", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var somethingFourthButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Что-то", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выйти", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func logOutButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setupLayouts()
    }

    /// добавляет констрэины
    private func setupLayouts() {
        let horizontalButtonsStackView = UIStackView(arrangedSubviews: [somethingFirstButton, somethingSecondButton])
        let verticalButtonsStackView = UIStackView(arrangedSubviews: [somethingThirdButton, somethingFourthButton])
        horizontalButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalButtonsStackView.spacing = 23
        verticalButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        verticalButtonsStackView.spacing = 10
        verticalButtonsStackView.axis = .vertical
        horizontalButtonsStackView.axis = .horizontal
        
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(numberLabel)
        view.addSubview(goToBucketButton)
        view.addSubview(horizontalButtonsStackView)
        view.addSubview(verticalButtonsStackView)
        view.addSubview(logOutButton)

        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
            profileImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 200),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 6),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            numberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            goToBucketButton.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 10),
            goToBucketButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goToBucketButton.widthAnchor.constraint(equalToConstant: 223),
            goToBucketButton.heightAnchor.constraint(equalToConstant: 33),
            
            horizontalButtonsStackView.topAnchor.constraint(equalTo: goToBucketButton.bottomAnchor, constant: 10),
            horizontalButtonsStackView.heightAnchor.constraint(equalToConstant: 27),
            horizontalButtonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            somethingFirstButton.widthAnchor.constraint(equalToConstant: 100),
            somethingSecondButton.widthAnchor.constraint(equalToConstant: 100),
            
            verticalButtonsStackView.topAnchor.constraint(equalTo: horizontalButtonsStackView.bottomAnchor, constant: 10),
            verticalButtonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            somethingThirdButton.widthAnchor.constraint(equalToConstant: 100),
            somethingFourthButton.widthAnchor.constraint(equalToConstant: 100),

            logOutButton.widthAnchor.constraint(equalToConstant: 223),
            logOutButton.heightAnchor.constraint(equalToConstant: 33),
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
