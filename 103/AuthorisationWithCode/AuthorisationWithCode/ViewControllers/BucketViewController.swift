//
//  BucketViewController.swift
//  AuthorisationWithCode
//
//  Created by Mac on 2023-09-24.
//

import UIKit

class BucketViewController: UIViewController {
    // MARK: - Declaration objects
    private lazy var bucketLabel: UILabel = {
        let label = UILabel()
        label.setLable(title: "Корзина")
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private lazy var bucketStatusLabel: UILabel = {
        let label = UILabel()
        label.setLable(title: "Корзина пуста, оплатите")
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private lazy var payButton: UIButton = {
        let button = UIButton(type: .system)
        button.setButton(title: "Купить")
        button.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setButton(title: "Назад")
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Load view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setupLayout()
    }
}

// MARK: - ObjC
extension BucketViewController {
    /// переход не некст экран
    @objc func payButtonTapped() {
        let shopVC = ShopViewController()
        navigationController?.pushViewController(shopVC, animated: true)
    }
    
    /// переход на пред экран
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Constraints
extension BucketViewController {
    /// добавляет констрэины
    private func setupLayout() {
        setupBucketLabel()
        setupBucketStatusLabel()
        setupBucketStackView()
    }
    
    /// добавляет констрэины тексту
    private func setupBucketLabel() {
        view.addSubview(bucketLabel)
        
        NSLayoutConstraint.activate([
            bucketLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            bucketLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    /// добавляет констрэны статусу корзины
    private func setupBucketStatusLabel() {
        view.addSubview(bucketStatusLabel)
        
        NSLayoutConstraint.activate([
            bucketStatusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            bucketStatusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    /// добавляет констрэины стэк вью с кнопками
    private func setupBucketStackView() {
        let bucketStackView = UIStackView(arrangedSubviews: [payButton, backButton])
        bucketStackView.translatesAutoresizingMaskIntoConstraints = false
        bucketStackView.axis = .horizontal
        bucketStackView.spacing = 20
        
        view.addSubview(bucketStackView)
        
        NSLayoutConstraint.activate([
            payButton.widthAnchor.constraint(equalToConstant: 100),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            
            bucketStackView.heightAnchor.constraint(equalToConstant: 35),
            bucketStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bucketStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
