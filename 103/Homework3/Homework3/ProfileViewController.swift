//
//  ProfileViewController.swift
//  Homework3
//
//  Created by kerik on 24.09.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView(image:  UIImage(named: "profileImage"))
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 100
        return imageView
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = label.font.withSize(30)
        label.text = "Сергей"
        return label
    }()
    
    lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = label.font.withSize(30)
        label.text = "8 800 555 3535"
        return label
    }()
    
    lazy var basketButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Корзина", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemGray3
        button.frame = CGRect(x: 0, y: 0, width: 223, height: 33)
        //button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        //loginButton.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var leftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Что-то", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemGray3
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 27)
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Что-то", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemGray3
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 27)
        return button
    }()
    
    lazy var bottomButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Что-то", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemGray3
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 27)
        return button
    }()
    
    lazy var marketButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Магазин", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemGray3
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 27)
        return button
    }()
        
    lazy var exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выйти", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemGray3
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 27)
        button.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayout()
    }
    
    private func setLayout() {
        view.addSubview(profileImageView)
        view.addSubview(userNameLabel)
        view.addSubview(phoneNumberLabel)
        view.addSubview(basketButton)
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        view.addSubview(bottomButton)
        view.addSubview(marketButton)
        view.addSubview(exitButton)
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        basketButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        bottomButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        marketButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 200),
            profileImageView.heightAnchor.constraint(equalToConstant: 200),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            userNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250),
            userNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            phoneNumberLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 290),
            phoneNumberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            basketButton.widthAnchor.constraint(equalToConstant: 223),
            basketButton.heightAnchor.constraint(equalToConstant: 33),
            basketButton.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 20),
            basketButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            leftButton.widthAnchor.constraint(equalToConstant: 100),
            leftButton.heightAnchor.constraint(equalToConstant: 27),
            leftButton.topAnchor.constraint(equalTo: basketButton.bottomAnchor, constant: 10),
            leftButton.leadingAnchor.constraint(equalTo: basketButton.leadingAnchor, constant: 0),

            rightButton.widthAnchor.constraint(equalToConstant: 100),
            rightButton.heightAnchor.constraint(equalToConstant: 27),
            rightButton.topAnchor.constraint(equalTo: basketButton.bottomAnchor, constant: 10),
            rightButton.trailingAnchor.constraint(equalTo: basketButton.trailingAnchor, constant: 0),

            bottomButton.widthAnchor.constraint(equalToConstant: 100),
            bottomButton.heightAnchor.constraint(equalToConstant: 27),
            bottomButton.topAnchor.constraint(equalTo: leftButton.bottomAnchor, constant: 10),
            bottomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            marketButton.widthAnchor.constraint(equalToConstant: 100),
            marketButton.heightAnchor.constraint(equalToConstant: 33),
            marketButton.topAnchor.constraint(equalTo: bottomButton.bottomAnchor, constant: 10),
            marketButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            exitButton.widthAnchor.constraint(equalToConstant: 223),
            exitButton.heightAnchor.constraint(equalToConstant: 33),
            exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    @objc func logOutButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
