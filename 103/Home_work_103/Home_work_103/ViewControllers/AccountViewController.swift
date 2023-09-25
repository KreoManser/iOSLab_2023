//
//  AccountViewController.swift
//  Home_work_103
//
//  Created by Артур Миннушин on 24.09.2023.
//

import UIKit

class AccountViewController: UIViewController {

    lazy var accountImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "MyFace"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 100
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Артур"
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "8 800 555 3535"
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var basketButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(displayP3Red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0)
        button.setTitle("Корзина", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    lazy var shopButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(displayP3Red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0)
        button.setTitle("Магазин", for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(shopDidTap), for: .touchUpInside)
        return button
    }()
    
    lazy var someButton1: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(displayP3Red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0)
        button.setTitle("Что-то", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    lazy var someButton2: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(displayP3Red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0)
        button.setTitle("Что-то", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    lazy var someButton3: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(displayP3Red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0)
        button.setTitle("Что-то", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    lazy var exitButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(displayP3Red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0)
        button.setTitle("Выйти", for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(exitProfile), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem (
            title: "",
            style: .plain,
            target: self, action: nil
        )
        view.backgroundColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        view.addSubview(accountImageView)
        view.addSubview(nameLabel)
        view.addSubview(numberLabel)
        view.addSubview(basketButton)
        view.addSubview(shopButton)
        view.addSubview(someButton1)
        view.addSubview(someButton2)
        view.addSubview(someButton3)
        view.addSubview(exitButton)
        setupLayoutConstrains()
    }
    
    @objc func exitProfile(sender: UIButton!){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func shopDidTap(sender: UIButton!){
        navigationController?.pushViewController(ShopViewController(), animated: true)
    }
    
    func setupLayoutConstrains(){
        NSLayoutConstraint.activate([
            accountImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            accountImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            accountImageView.widthAnchor.constraint(equalToConstant: 200),
            accountImageView.heightAnchor.constraint(equalToConstant: 200),
            
            nameLabel.topAnchor.constraint(equalTo: accountImageView.bottomAnchor, constant: 23),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            numberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            basketButton.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 27),
            basketButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            basketButton.widthAnchor.constraint(equalToConstant: 223),
            basketButton.heightAnchor.constraint(equalToConstant: 33),
            
            shopButton.topAnchor.constraint(equalTo: basketButton.bottomAnchor, constant: 16),
            shopButton.leadingAnchor.constraint(equalTo: basketButton.leadingAnchor),
            shopButton.widthAnchor.constraint(equalToConstant: 100),
            shopButton.heightAnchor.constraint(equalToConstant: 27),
            
            someButton1.topAnchor.constraint(equalTo: basketButton.bottomAnchor, constant: 16),
            someButton1.trailingAnchor.constraint(equalTo: basketButton.trailingAnchor),
            someButton1.widthAnchor.constraint(equalToConstant: 100),
            someButton1.heightAnchor.constraint(equalToConstant: 27),
            
            someButton2.topAnchor.constraint(equalTo: someButton1.bottomAnchor, constant: 16),
            someButton2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            someButton2.widthAnchor.constraint(equalToConstant: 100),
            someButton2.heightAnchor.constraint(equalToConstant: 27),
            
            someButton3.topAnchor.constraint(equalTo: someButton2.bottomAnchor, constant: 16),
            someButton3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            someButton3.widthAnchor.constraint(equalToConstant: 100),
            someButton3.heightAnchor.constraint(equalToConstant: 27),
            
            exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exitButton.widthAnchor.constraint(equalToConstant: 223),
            exitButton.heightAnchor.constraint(equalToConstant: 33),
        ])
    }
}
