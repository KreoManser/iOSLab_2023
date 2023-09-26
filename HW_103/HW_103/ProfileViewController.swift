//
//  ProfileViewController.swift
//  HW_103
//
//  Created by Азат Зиганшин on 25.09.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    lazy var MonaLisaImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "MonaLisa")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Сергей"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "8 800 555 3535"
        label.font = label.font.withSize(20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var basketButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Корзина"
        config.baseForegroundColor = UIColor.black
        config.background.backgroundColor = UIColor.gray
        config.background.cornerRadius = 10
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 80, bottom: 10, trailing: 80)
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.basketButtonTapped()
        }), for: .touchUpInside)
        return button
    }()
    
    lazy var nothingButton1: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Что-то"
        config.baseForegroundColor = UIColor.black
        config.background.backgroundColor = UIColor.gray
        config.background.cornerRadius = 10
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 35, bottom: 10, trailing: 35)
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var nothingButton2: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Что-то"
        config.baseForegroundColor = UIColor.black
        config.background.backgroundColor = UIColor.gray
        config.background.cornerRadius = 10
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 35, bottom: 10, trailing: 35)
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var nothingButton3: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Что-то"
        config.baseForegroundColor = UIColor.black
        config.background.backgroundColor = UIColor.gray
        config.background.cornerRadius = 10
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 35, bottom: 10, trailing: 35)
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var nothingButton4: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Магазин"
        config.baseForegroundColor = UIColor.black
        config.background.backgroundColor = UIColor.gray
        config.background.cornerRadius = 10
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 35, bottom: 10, trailing: 35)
        
        let button = UIButton(configuration: config)
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.shopButtonTapped()
        }), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var quitButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Выйти"
        config.baseForegroundColor = UIColor.black
        config.background.backgroundColor = UIColor.gray
        config.background.cornerRadius = 10
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 80, bottom: 10, trailing: 80)
        
        let button = UIButton(configuration: config)
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.quitButtonTapped()
        }), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: false)

        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        MonaLisaImageView.layer.cornerRadius = MonaLisaImageView.frame.size.width / 2
        MonaLisaImageView.clipsToBounds = true
    }
    
    @objc func basketButtonTapped() {
        let trashViewController = BasketViewController()
        navigationController?.pushViewController(trashViewController, animated: true)
    }
    
    @objc func quitButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func shopButtonTapped() {
        let shopViewController = ShopViewController()
        navigationController?.pushViewController(shopViewController, animated: true)
    }
}

extension ProfileViewController {
    
    func setupLayout() {
        
        let nothingStackView1 = UIStackView(arrangedSubviews: [nothingButton1, nothingButton2])
        nothingStackView1.translatesAutoresizingMaskIntoConstraints = false
        nothingStackView1.axis = .horizontal
        nothingStackView1.spacing = 10
        
        let nothingStackView2 = UIStackView(arrangedSubviews: [nothingButton3, nothingButton4])
        nothingStackView2.translatesAutoresizingMaskIntoConstraints = false
        nothingStackView2.axis = .vertical
        nothingStackView2.spacing = 10
        
        view.addSubview(MonaLisaImageView)
        view.addSubview(nameLabel)
        view.addSubview(phoneLabel)
        view.addSubview(basketButton)
        view.addSubview(nothingStackView1)
        view.addSubview(nothingStackView2)
        view.addSubview(quitButton)
        
        NSLayoutConstraint.activate([
            
            MonaLisaImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            MonaLisaImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            MonaLisaImageView.heightAnchor.constraint(equalToConstant: 200),
            MonaLisaImageView.widthAnchor.constraint(equalTo: MonaLisaImageView.heightAnchor),
            
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: MonaLisaImageView.bottomAnchor, constant: 10),
            
            phoneLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            
            basketButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            basketButton.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 10),
            
            nothingStackView1.topAnchor.constraint(equalTo: basketButton.bottomAnchor, constant: 10),
            nothingStackView1.leadingAnchor.constraint(equalTo: basketButton.leadingAnchor),
            nothingStackView1.trailingAnchor.constraint(equalTo: basketButton.trailingAnchor),
            
            nothingStackView2.topAnchor.constraint(equalTo: nothingStackView1.bottomAnchor, constant: 10),
            nothingStackView2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            quitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            quitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
            
        ])
        
    }
}
