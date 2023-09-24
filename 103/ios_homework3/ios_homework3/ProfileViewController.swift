//
//  ProfileViewController.swift
//  ios_homework3
//
//  Created by Аделя Миннехузина on 22.09.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    private lazy var ProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "circle")
        return imageView
    }()

    private lazy var NameLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var PhoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "8 800 555 3535"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var CartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("Корзина", for: .normal)
        button.addTarget(self, action: #selector(CartButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var FirstSomeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("Что-то", for: .normal)
        return button
    }()
    
    private lazy var SecondSomeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("Что-то", for: .normal)
        return button
    }()
    
    private lazy var ThirdSomeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("Что-то", for: .normal)
        return button
    }()
    
    private lazy var FourthSomeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("Что-то", for: .normal)
        return button
    }()
    
    private lazy var BackButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("Выйти", for: .normal)
        button.addTarget(self, action: #selector(BackButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    @objc private func CartButtonDidTap(sender: UIButton!) {
        let cartViewController = CartViewController()
        navigationController?.pushViewController(cartViewController, animated: true)
    }
    
    @objc private func BackButtonDidTap(sender: UIButton!) {
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = .white
        view.addSubview(ProfileImageView)
        view.addSubview(NameLabel)
        view.addSubview(PhoneNumberLabel)
        view.addSubview(CartButton)
        view.addSubview(FirstSomeButton)
        view.addSubview(SecondSomeButton)
        view.addSubview(ThirdSomeButton)
        view.addSubview(FourthSomeButton)
        view.addSubview(BackButton)
        
        setupLayout()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Профиль", style: .plain, target: nil, action: nil)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            ProfileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            ProfileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ProfileImageView.widthAnchor.constraint(equalToConstant: 130),
            ProfileImageView.heightAnchor.constraint(equalToConstant: 130),
            
            NameLabel.topAnchor.constraint(equalTo: ProfileImageView.bottomAnchor, constant: 25),
            NameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            NameLabel.widthAnchor.constraint(equalToConstant: 35),
            
            PhoneNumberLabel.topAnchor.constraint(equalTo: NameLabel.bottomAnchor, constant: 15),
            PhoneNumberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            PhoneNumberLabel.widthAnchor.constraint(equalToConstant: 130),
            
            CartButton.topAnchor.constraint(equalTo: PhoneNumberLabel.bottomAnchor, constant: 40),
            CartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 105),
            CartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -105),
            
            FirstSomeButton.topAnchor.constraint(equalTo: CartButton.bottomAnchor, constant: 40),
            FirstSomeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 105),
            FirstSomeButton.widthAnchor.constraint(equalToConstant: 70),
            
            SecondSomeButton.topAnchor.constraint(equalTo: CartButton.bottomAnchor, constant: 40),
            SecondSomeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -105),
            SecondSomeButton.widthAnchor.constraint(equalToConstant: 70),
            
            ThirdSomeButton.topAnchor.constraint(equalTo: FirstSomeButton.bottomAnchor, constant: 18),
            ThirdSomeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ThirdSomeButton.widthAnchor.constraint(equalToConstant: 70),
            
            FourthSomeButton.topAnchor.constraint(equalTo: ThirdSomeButton.bottomAnchor, constant: 18),
            FourthSomeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            FourthSomeButton.widthAnchor.constraint(equalToConstant: 70),
            
            BackButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -55),
            BackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 125),
            BackButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -125)
        ])
    }
}
