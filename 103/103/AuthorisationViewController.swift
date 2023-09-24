//
//  AuthorisationViewController.swift
//  103
//
//  Created by Alina on 24.09.2023.
//

import UIKit

class AuthorisationViewController: UIViewController {
    
    let AvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 150
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Photo2")
        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.text = "Алина"
        return label
    }()

    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "8(995)364-44-18"
        return label
    }()
    
    let FirstButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        return button
    }()
    
    let ShopButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.setTitle("Магазин", for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.addTarget(AuthorisationViewController.self, action: #selector(ShopButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let ThirdButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        return button
    }()
    
    let ForthButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        return button
    }()
    

    let BackButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.setTitle("Выход", for: .normal)
        button.addTarget(AuthorisationViewController.self, action: #selector(BackButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(AvatarImageView)
        view.addSubview(nameLabel)
        view.addSubview(phoneNumberLabel)
        view.addSubview(BackButton)
        view.addSubview(FirstButton)
        view.addSubview(ShopButton)
        view.addSubview(ThirdButton)
        view.addSubview(ForthButton)

        setupLayoutConstraints()
    }

    private func setupLayoutConstraints() {
    NSLayoutConstraint.activate([
        AvatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        AvatarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
        AvatarImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
        AvatarImageView.heightAnchor.constraint(equalToConstant: 300),

        nameLabel.topAnchor.constraint(equalTo: AvatarImageView.bottomAnchor, constant: 20),
        nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),

        phoneNumberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
        phoneNumberLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        phoneNumberLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        
        FirstButton.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 30),
        FirstButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 50),
        FirstButton.trailingAnchor.constraint(equalTo: ShopButton.leadingAnchor,constant: -20),
        
        ShopButton.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 30),
        ShopButton.leadingAnchor.constraint(equalTo: FirstButton.leadingAnchor, constant: 157),
        ShopButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
        
        ThirdButton.topAnchor.constraint(equalTo: FirstButton.bottomAnchor, constant: 10),
        ThirdButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 125),
        ThirdButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -125),
        
        ForthButton.topAnchor.constraint(equalTo: ThirdButton.bottomAnchor, constant: 10),
        ForthButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 125),
        ForthButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -125),

        BackButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
        BackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
        BackButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
    ])
    }

    @objc private func BackButtonTapped(_ Sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func ShopButtonTapped(_ Sender: UIButton) {
        let nextViewController = ShopViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}
