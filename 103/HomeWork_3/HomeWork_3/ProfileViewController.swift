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
    private lazy var avatarImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "adminImage"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 200 / 2
        return image
    }()
    
    // MARK: - Labels
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = label.font.withSize(30)
        label.text = "Сергей"
        return label
    }()
    
    private lazy var userPhoneNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = label.font.withSize(30)
        label.text = "8 800 555 3535"
        return label
    }()
    
    // MARK: - Buttons
    private lazy var shoppingBasketButton: UIButton = {
        let action = UIAction { [weak self] _ in
            let shoppingbasketViewController = ShoppingBasketViewController()
            shoppingbasketViewController.modalPresentationStyle = .fullScreen
            self?.present(shoppingbasketViewController, animated: true)
        }
        
        let button = UIButton(configuration: .filled(), primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.baseBackgroundColor = .darkGray
        button.setTitle("корзина", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var leftSomethingButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.baseBackgroundColor = .darkGray
        button.setTitle("что-то", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var rightSomethingButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.baseBackgroundColor = .darkGray
        button.setTitle("что-то", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var bottomSomethingButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.baseBackgroundColor = .darkGray
        button.setTitle("что-то", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var shopButton: UIButton = {
        let action = UIAction { [weak self] _ in
            let shopViewController = ShopViewController()
            shopViewController.modalPresentationStyle = .fullScreen
            self?.present(shopViewController, animated: true)
        }
        
        let button = UIButton(configuration: .filled(), primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.baseBackgroundColor = .darkGray
        button.setTitle("Магазин", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var exitButton: UIButton = {
        let action = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
        let button = UIButton(configuration: .filled(), primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.baseBackgroundColor = .darkGray
        button.setTitle("Выйти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews(avatarImage, userNameLabel, userPhoneNumberLabel, leftSomethingButton, rightSomethingButton, shopButton, bottomSomethingButton, exitButton, shoppingBasketButton)
        
        configureUI()
    }
}

// MARK: - extencion ProfileVC
extension ProfileViewController {
    private func addSubviews(_ subviews: UIView...) {
        subviews.forEach { view.addSubview($0) }
    }
    
    // MARK: - configureUI func
    private func configureUI() {
        view.backgroundColor = UIColor(displayP3Red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        
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
            
            leftSomethingButton.widthAnchor.constraint(equalToConstant: 100),
            leftSomethingButton.heightAnchor.constraint(equalToConstant: 35),
            leftSomethingButton.topAnchor.constraint(equalTo: shoppingBasketButton.bottomAnchor, constant: 10),
            leftSomethingButton.leadingAnchor.constraint(equalTo: shoppingBasketButton.leadingAnchor, constant: 0),
            
            rightSomethingButton.widthAnchor.constraint(equalToConstant: 100),
            rightSomethingButton.heightAnchor.constraint(equalToConstant: 35),
            rightSomethingButton.topAnchor.constraint(equalTo: shoppingBasketButton.bottomAnchor, constant: 10),
            rightSomethingButton.trailingAnchor.constraint(equalTo: shoppingBasketButton.trailingAnchor, constant: 0),
            
            shopButton.widthAnchor.constraint(equalToConstant: 100),
            shopButton.heightAnchor.constraint(equalToConstant: 35),
            shopButton.topAnchor.constraint(equalTo: leftSomethingButton.bottomAnchor, constant: 10),
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
    }
}
