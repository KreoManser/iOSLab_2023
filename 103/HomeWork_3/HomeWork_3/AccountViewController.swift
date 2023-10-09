//
//  AccountViewController.swift
//  HomeWork_3
//
//  Created by Нияз Ризванов on 23.09.2023.
//

import UIKit

class AccountViewController: UIViewController {

    private lazy var accountPhoto: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var telephoneNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buttonBasket: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonSetting: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonInfo: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonMyCard: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonShop: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonExit: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: false)
        
        view.addSubview(accountPhoto)
        view.addSubview(nameLabel)
        view.addSubview(telephoneNumberLabel)
        view.addSubview(buttonBasket)
        view.addSubview(buttonExit)
        
        buttonExit.addTarget(self, action: #selector(buttonTappedForExit), for: .touchUpInside)
        
        buttonBasket.addTarget(self, action: #selector(buttonTappedForBasket), for: .touchUpInside)

        buttonShop.addTarget(self, action: #selector(buttonTappedForShop), for: .touchUpInside)
        
        configureElement()
        
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        accountPhoto.layer.cornerRadius = accountPhoto.frame.width / 2
        accountPhoto.clipsToBounds = true
    }

    @objc func buttonTappedForExit() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func buttonTappedForBasket() {
        let basketObj = BasketViewController()
        navigationController?.pushViewController(basketObj, animated: true)
    }
    
    @objc func buttonTappedForShop() {
        let shopObj = ShopViewController()
        navigationController?.pushViewController(shopObj, animated: true)
    }
    
    private func configureElement() {
        view.backgroundColor = .white
        
        if let image = UIImage(named: "account_photo_Sergey"){
                    accountPhoto.image = image
        }
        
        navigationItem.title = "Aккаунт"
        
        configureButton(buttonBasket, title: "Корзина")
        configureButton(buttonSetting, title: "Настройки")
        configureButton(buttonInfo, title: "Информация")
        configureButton(buttonMyCard, title: "Мои карты")
        configureButton(buttonShop, title: "Магазин")
        configureButton(buttonExit, title: "Выход")
        
        nameLabel.text = "Cергей"
        nameLabel.font = UIFont.systemFont(ofSize: 30)
        
        telephoneNumberLabel.text = "8 800 555 3535"
        telephoneNumberLabel.font = UIFont.systemFont(ofSize: 23)
    }
    
    private func setupLayout() {
        let mainStacklView_1 = createHorizontalStackView([buttonSetting, buttonInfo])
        let mainStacklView_2 = createVerticalStackView([buttonMyCard, buttonShop])
        
        view.addSubview(mainStacklView_1)
        view.addSubview(mainStacklView_2)
    
        NSLayoutConstraint.activate([
            accountPhoto.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 50),
            accountPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            accountPhoto.widthAnchor.constraint(equalToConstant: 200),
            accountPhoto.heightAnchor.constraint(equalToConstant: 200),
            
            nameLabel.topAnchor.constraint(equalTo: accountPhoto.bottomAnchor,constant: 5),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            telephoneNumberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 5),
            telephoneNumberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            buttonBasket.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonBasket.topAnchor.constraint(equalTo: telephoneNumberLabel.bottomAnchor,constant: 5),
            buttonBasket.widthAnchor.constraint(equalToConstant: 223),
            buttonBasket.heightAnchor.constraint(equalToConstant: 35),
            
            mainStacklView_1.topAnchor.constraint(equalTo: buttonBasket.bottomAnchor,constant: 10),
            mainStacklView_1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStacklView_1.widthAnchor.constraint(equalToConstant: 280),
            mainStacklView_1.heightAnchor.constraint(equalToConstant: 38),
            
            mainStacklView_2.topAnchor.constraint(equalTo: mainStacklView_1.bottomAnchor,constant: 10),
            mainStacklView_2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStacklView_2.widthAnchor.constraint(equalToConstant: 130),
            mainStacklView_2.heightAnchor.constraint(equalToConstant: 86),
            
            buttonExit.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonExit.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -5),
            buttonExit.widthAnchor.constraint(equalToConstant: 223),
            buttonExit.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
    
    private func configureButton(_ button: UIButton, title: String) {
           button.backgroundColor = .systemGray4
           button.setTitle(title, for: .normal)
           button.setTitleColor(.black, for: .normal)
       }
    
    private func createHorizontalStackView(_ views: [UIView]) -> UIStackView {
            let stackView = UIStackView(arrangedSubviews: views)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = 10
            return stackView
        }
        
    private func createVerticalStackView(_ views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }
}
