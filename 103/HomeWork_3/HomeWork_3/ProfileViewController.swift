//
//  ProfileViewController.swift
//  HomeWork_3
//
//  Created by Камил Хайрутдинов on 24.09.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - UI elements
    
    // MARK: - Image
    lazy var avatarImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "adminImage"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.frame = CGRectMake(0, 0, 200, 200)
        return image
    }()
    
    // MARK: - Labels
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = label.font.withSize(30)
        label.text = "Сергей"
        return label
    }()
    
    lazy var userPhoneNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = label.font.withSize(30)
        label.text = "8 800 555 3535"
        return label
    }()
    
    // MARK: - Buttons
    lazy var shoppingBasketButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.baseBackgroundColor = .darkGray
        button.setTitle("корзина", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var leftsomethingButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.baseBackgroundColor = .darkGray
        button.setTitle("что-то", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var rightSomethingButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.baseBackgroundColor = .darkGray
        button.setTitle("что-то", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var bottomSomethingButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.baseBackgroundColor = .darkGray
        button.setTitle("что-то", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var somethingButtonLeft = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.baseBackgroundColor = .darkGray
        button.setTitle("что-то", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var shopButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.baseBackgroundColor = .darkGray
        button.setTitle("Магазин", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var exitButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.baseBackgroundColor = .darkGray
        button.setTitle("Выйти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupButtons()
    }
    
    // MARK: - Setup layot func
    private func setupLayout() {
        view.backgroundColor = UIColor(displayP3Red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        
        view.addSubview(avatarImage)
        view.addSubview(userNameLabel)
        view.addSubview(userPhoneNumberLabel)
        view.addSubview(leftsomethingButton)
        view.addSubview(rightSomethingButton)
        view.addSubview(bottomSomethingButton)
        view.addSubview(shopButton)
        view.addSubview(exitButton)
        view.addSubview(shoppingBasketButton)
        
        NSLayoutConstraint.activate([
            avatarImage.widthAnchor.constraint(equalToConstant: 200),
            avatarImage.heightAnchor.constraint(equalToConstant: 200),
            avatarImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            avatarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            userNameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 15),
            userNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            userPhoneNumberLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
            userPhoneNumberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            shoppingBasketButton.widthAnchor.constraint(equalToConstant: 223),
            shoppingBasketButton.heightAnchor.constraint(equalToConstant: 35),
            shoppingBasketButton.topAnchor.constraint(equalTo: userPhoneNumberLabel.bottomAnchor, constant: 20),
            shoppingBasketButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            leftsomethingButton.widthAnchor.constraint(equalToConstant: 100),
            leftsomethingButton.heightAnchor.constraint(equalToConstant: 35),
            leftsomethingButton.topAnchor.constraint(equalTo: shoppingBasketButton.bottomAnchor, constant: 10),
            leftsomethingButton.leadingAnchor.constraint(equalTo: shoppingBasketButton.leadingAnchor, constant: 0),
            
            rightSomethingButton.widthAnchor.constraint(equalToConstant: 100),
            rightSomethingButton.heightAnchor.constraint(equalToConstant: 35),
            rightSomethingButton.topAnchor.constraint(equalTo: shoppingBasketButton.bottomAnchor, constant: 10),
            rightSomethingButton.trailingAnchor.constraint(equalTo: shoppingBasketButton.trailingAnchor, constant: 0),
            
            shopButton.widthAnchor.constraint(equalToConstant: 100),
            shopButton.heightAnchor.constraint(equalToConstant: 35),
            shopButton.topAnchor.constraint(equalTo: leftsomethingButton.bottomAnchor, constant: 10),
            shopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bottomSomethingButton.widthAnchor.constraint(equalToConstant: 100),
            bottomSomethingButton.heightAnchor.constraint(equalToConstant: 35),
            bottomSomethingButton.topAnchor.constraint(equalTo: shopButton.bottomAnchor, constant: 10),
            bottomSomethingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            exitButton.widthAnchor.constraint(equalToConstant: 223),
            exitButton.heightAnchor.constraint(equalToConstant: 35),
            exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            
        ])
        
        avatarImage.layer.masksToBounds = true
        avatarImage.layer.cornerRadius = avatarImage.frame.width / 2
    }
    
    // MARK: - Setup buttons target func
    private func setupButtons() {
        shoppingBasketButton.addTarget(self, action: #selector(shoppingBasketButtonPressed), for: .touchUpInside)
        shopButton.addTarget(self, action: #selector(shopButtonPressed), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(exitButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Buttons logic
    @objc private func shoppingBasketButtonPressed() {
        let shoppingbasketViewController = ShoppingBasketViewController()
        shoppingbasketViewController.modalPresentationStyle = .fullScreen
        present(shoppingbasketViewController, animated: true)
    }
    
    @objc private func shopButtonPressed() {
        let shopViewController = ShopViewController()
        shopViewController.modalPresentationStyle = .fullScreen
        present(shopViewController, animated: true)
    }
    
    @objc private func exitButtonPressed() {
        dismiss(animated: true)
    }
}
