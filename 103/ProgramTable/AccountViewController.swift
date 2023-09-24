//
//  AccountViewController.swift
//  ProgramTable
//
//  Created by Timur on 24.09.2023.
//

import SwiftUI

class AccountViewController: UIViewController{
    
    let buttonCreator = ButtonTemplate()
    
    lazy var profilePic: UIImageView = {
        let image = UIImageView(image: UIImage(named: "prepodImage"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.frame = CGRectMake(0, 0, 200, 200)
        return image
    }()
    
    lazy var username: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30)
        label.text = "Сергей"
        return label
    }()
    
    lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "PhoneColor")
        label.font = UIFont.systemFont(ofSize: 30)
        label.text = "8 800 555 3535"
        return label
    }()
    
    lazy var cartButton: UIButton = {
        let button = buttonCreator.buttonTemplate(title: "Корзина")
        return button
    }()
    
    lazy var firstButton = {
        let button = buttonCreator.buttonTemplate(title: "Что-то")
        return button
    }()
    
    lazy var secondButton = {
        let button = buttonCreator.buttonTemplate(title: "Что-то")
        return button
    }()
    
    lazy var thirdButton = {
        let button = buttonCreator.buttonTemplate(title: "Что-то")
        return button
    }()
    
    lazy var fourthButton = {
        let button = buttonCreator.buttonTemplate(title: "Что-то")
        return button
    }()
    
    lazy var exitButton = {
        let button = buttonCreator.buttonTemplate(title: "Выйти")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Ваш аккаунт"
        view.backgroundColor = .white
        view.addSubview(profilePic)
        view.addSubview(username)
        view.addSubview(phoneNumberLabel)
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        view.addSubview(thirdButton)
        view.addSubview(fourthButton)
        view.addSubview(exitButton)
        view.addSubview(cartButton)
        setupLayout()
        setupButtons()
    }
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            profilePic.widthAnchor.constraint(equalToConstant: 200),
            profilePic.heightAnchor.constraint(equalToConstant: 200),
            profilePic.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            profilePic.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            username.topAnchor.constraint(equalTo: profilePic.bottomAnchor, constant: 15),
            username.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 10),
            phoneNumberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            cartButton.widthAnchor.constraint(equalToConstant: 223),
            cartButton.heightAnchor.constraint(equalToConstant: 33),
            cartButton.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 19),
            cartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            firstButton.widthAnchor.constraint(equalToConstant: 100),
            firstButton.heightAnchor.constraint(equalToConstant: 27),
            firstButton.topAnchor.constraint(equalTo: cartButton.bottomAnchor, constant: 16),
            firstButton.leadingAnchor.constraint(equalTo: cartButton.leadingAnchor, constant: 0),
            
            secondButton.widthAnchor.constraint(equalToConstant: 100),
            secondButton.heightAnchor.constraint(equalToConstant: 27),
            secondButton.topAnchor.constraint(equalTo: cartButton.bottomAnchor, constant: 16),
            secondButton.trailingAnchor.constraint(equalTo: cartButton.trailingAnchor, constant: 0),
            
            fourthButton.widthAnchor.constraint(equalToConstant: 100),
            fourthButton.heightAnchor.constraint(equalToConstant: 27),
            fourthButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 16),
            fourthButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            thirdButton.widthAnchor.constraint(equalToConstant: 100),
            thirdButton.heightAnchor.constraint(equalToConstant: 27),
            thirdButton.topAnchor.constraint(equalTo: fourthButton.bottomAnchor, constant: 16),
            thirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            exitButton.widthAnchor.constraint(equalToConstant: 223),
            exitButton.heightAnchor.constraint(equalToConstant: 33),
            exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -34)
            
        ])
        
        profilePic.layer.masksToBounds = true
        profilePic.layer.cornerRadius = profilePic.frame.width / 2
    }
    
    private func setupButtons() {
        cartButton.addTarget(self, action: #selector(cartButtonPressed), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(exitButtonPressed), for: .touchUpInside)
    }
    
    @objc private func cartButtonPressed() {
        let cartViewController = CartViewController()
        cartViewController.modalPresentationStyle = .fullScreen
        self .navigationController?.pushViewController(cartViewController, animated: true)
    }
    
    @objc private func exitButtonPressed() {
        let rootVC = ViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
}

