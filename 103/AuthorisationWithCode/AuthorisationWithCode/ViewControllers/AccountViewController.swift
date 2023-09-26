//
//  AccountViewController.swift
//  AuthorisationWithCode
//
//  Created by Mac on 2023-09-24.
//

import UIKit

class AccountViewController: UIViewController {
    // MARK: - Declaration objects
    private lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.setImage(name: "photo", cornerRadius: 100)
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let name = UILabel()
        name.setLable(title: "Имя")
        name.font = UIFont.systemFont(ofSize: 30)
        return name
    }()
    
    private lazy var numberLabel: UILabel = {
        let number = UILabel()
        number.setLable(title: "8 800 555 35 35")
        number.textColor = .lightGray
        number.font = UIFont.systemFont(ofSize: 30)
        return number
    }()
    
    private lazy var horisontalFirstButton: UIButton = {
        createDefaultButton()
    }()
    
    private lazy var horisontalSecondButton: UIButton = {
        createDefaultButton()
    }()
    
    private lazy var verticalThirdButton: UIButton = {
        createDefaultButton()
    }()
    
    private lazy var verticalFourthButton: UIButton = {
        createDefaultButton()
    }()
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setButton(title: "Выйти")

        button.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var goToBucketButton: UIButton = {
        let button = UIButton(type: .system)
        button.setButton(title: "Корзина")
        
        button.addTarget(self, action: #selector(goToBucketButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Load view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.topViewController?.navigationItem.leftBarButtonItem = nil
        view.backgroundColor = .gray
        setupLayouts()
    }
}

// MARK: - ObjC
extension AccountViewController {
    /// перемещает на след экран
    @objc func goToBucketButtonTapped() {
        let bucketVC = BucketViewController()
        navigationController?.pushViewController(bucketVC, animated: true)
    }
    
    /// перемещает на пред экран
    @objc func logOutButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Support things
extension AccountViewController {
    /// создаёт одинаковые кнопки
    private func createDefaultButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setButton(title: "Что-то")
        return button
    }
}

// MARK: - Constraints
extension AccountViewController {
    /// добавляет констрэины
    private func setupLayouts() {
        setupProfileImageView()
        setupLabels()
        setupGoToBucketButton()
        setupStackViewes()
        setupLogOutButton()
    }
    
    private func setupProfileImageView() {
        view.addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
            profileImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 200),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setupLabels() {
        view.addSubview(nameLabel)
        view.addSubview(numberLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 6),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            numberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setupGoToBucketButton() {
        view.addSubview(goToBucketButton)
        
        NSLayoutConstraint.activate([
            goToBucketButton.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 10),
            goToBucketButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goToBucketButton.widthAnchor.constraint(equalToConstant: 223),
            goToBucketButton.heightAnchor.constraint(equalToConstant: 33),
        ])
    }
    
    private func setupStackViewes() {
        let horizontalButtonsStackView = UIStackView(arrangedSubviews: [horisontalFirstButton, horisontalSecondButton])
        let verticalButtonsStackView = UIStackView(arrangedSubviews: [verticalThirdButton, verticalFourthButton])
        
        horizontalButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalButtonsStackView.spacing = 23
        horizontalButtonsStackView.axis = .horizontal
        
        verticalButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalButtonsStackView.spacing = 10
        verticalButtonsStackView.axis = .vertical
        
        view.addSubview(horizontalButtonsStackView)
        view.addSubview(verticalButtonsStackView)
        
        NSLayoutConstraint.activate([
            horizontalButtonsStackView.topAnchor.constraint(equalTo: goToBucketButton.bottomAnchor, constant: 10),
            horizontalButtonsStackView.heightAnchor.constraint(equalToConstant: 27),
            horizontalButtonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            horisontalFirstButton.widthAnchor.constraint(equalToConstant: 100),
            horisontalSecondButton.widthAnchor.constraint(equalToConstant: 100),
            
            verticalButtonsStackView.topAnchor.constraint(equalTo: horizontalButtonsStackView.bottomAnchor, constant: 10),
            verticalButtonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalThirdButton.widthAnchor.constraint(equalToConstant: 100),
            verticalFourthButton.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    private func setupLogOutButton() {
        view.addSubview(logOutButton)

        NSLayoutConstraint.activate([
            logOutButton.widthAnchor.constraint(equalToConstant: 223),
            logOutButton.heightAnchor.constraint(equalToConstant: 33),
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
