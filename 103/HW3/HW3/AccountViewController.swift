//
//  AccountViewController.swift
//  HW3
//
//  Created by Kseniya Skvortsova on 30.09.2023.
//

import UIKit

class AccountViewController: UIViewController {
    
    private lazy var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "avatar")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.text = "Cherry"
        view.font = UIFont(name: "Blaka-Regular", size: 40)
        view.textColor = .yellow
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var phoneLabel: UILabel = {
        let view = UILabel()
        view.text = "88005553535"
        view.font = UIFont(name: "Blaka-Regular", size: 40)
        view.textColor = .yellow
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bucketButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .white
        config.title = "Bucket"
        config.baseForegroundColor = .black

        return UIButton(
            configuration: config,
            primaryAction: UIAction { [weak self] _ in
                self?.bucketButtonTapped()
            })
    }()
    
    private lazy var button1: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .white
        config.title = "button1"
        config.baseForegroundColor = .black

        return UIButton(
            configuration: config,
            primaryAction: UIAction { [weak self] _ in
                self?.button1ButtonTapped()
            })
    }()
    
    private lazy var button2: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .white
        config.title = "button2"
        config.baseForegroundColor = .black

        return UIButton(
            configuration: config,
            primaryAction: UIAction { [weak self] _ in
                self?.button2ButtonTapped()
            })
    }()
    
    private lazy var button3: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .white
        config.title = "button3"
        config.baseForegroundColor = .black

        return UIButton(
            configuration: config,
            primaryAction: UIAction { [weak self] _ in
                self?.button3ButtonTapped()
            })
    }()
    
    private lazy var shopButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .white
        config.title = "Shop"
        config.baseForegroundColor = .black

        return UIButton(
            configuration: config,
            primaryAction: UIAction { [weak self] _ in
                self?.shopButtonTapped()
            })
    }()
    
    private lazy var exitButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .white
        config.title = "Exit"
        config.baseForegroundColor = .black

        return UIButton(
            configuration: config,
            primaryAction: UIAction { [weak self] _ in
                self?.exitButtonTapped()
            })
    }()
    
    private func bucketButtonTapped() {
        let nextVC = BucketViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func shopButtonTapped() {
        let nextVC = ShopViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func exitButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func button1ButtonTapped(){}
    private func button2ButtonTapped(){}
    private func button3ButtonTapped(){}

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        configureUI()
    }
}

// MARK: - Autolayout
extension AccountViewController{
    private func addSubviews(_ subviews: UIView...) {
        subviews.forEach { view.addSubview($0) }
    }
    
    private func configureUI() {
        bucketButton.translatesAutoresizingMaskIntoConstraints = false
        shopButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        button1.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        button3.translatesAutoresizingMaskIntoConstraints = false
        
        let headStackView = UIStackView(arrangedSubviews: [nameLabel,phoneLabel,bucketButton])
        headStackView.axis = .vertical
        headStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalStackView = UIStackView(arrangedSubviews: [button1, button2])
        horizontalStackView.axis = .horizontal
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.spacing = 10
        
        let verticalStackView = UIStackView(arrangedSubviews: [button3, shopButton])
        verticalStackView.axis = .vertical
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.spacing = 10
        
        addSubviews(avatarImageView, headStackView, verticalStackView, horizontalStackView, exitButton)
        
        avatarImageView.layer.cornerRadius = 100
        avatarImageView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: 200),
            avatarImageView.topAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            avatarImageView.heightAnchor
                .constraint(equalTo: avatarImageView.widthAnchor, multiplier: 1),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    
            headStackView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10),
            headStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            headStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            nameLabel.heightAnchor.constraint(equalToConstant: nameLabel.font.lineHeight),
            phoneLabel.heightAnchor.constraint(equalToConstant: phoneLabel.font.lineHeight),
            
            horizontalStackView.topAnchor.constraint(equalTo: headStackView.bottomAnchor, constant: 10),
            horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            verticalStackView.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 10),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            
            exitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80)
        ])
    }
}
