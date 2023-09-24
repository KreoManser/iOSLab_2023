//
//  ProfileViewController.swift
//  homework_3
//
//  Created by Кирилл Щёлоков on 24.09.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Variables
    
    lazy var profileImageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var telephoneLabel : UILabel = {
        let telephonelabel = UILabel()
        return telephonelabel
    }()
    
    lazy var nameLabel : UILabel = {
        let nameLabel = UILabel()
        return nameLabel
    }()
    
    lazy var busketButton : UIButton = {
        let busketButton = UIButton()
        return busketButton
    }()
    
    lazy var smthButton1 : UIButton = {
        let smthButton1 = UIButton()
        return smthButton1
    }()
    
    lazy var shopButton : UIButton = {
        let shopButton = UIButton()
        return shopButton
    }()
    
    lazy var smthButton2 : UIButton = {
        let smthButton2 = UIButton()
        return smthButton2
    }()
    
    lazy var smthButton3 : UIButton = {
        let smthButton3 = UIButton()
        return smthButton3
    }()
    
    lazy var logOutButton : UIButton = {
        let logOutButton = UIButton()
        return logOutButton
    }()
    
    // MARK: - SetUp
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp(){
        view.backgroundColor = .white
        setUpProfileImageView()
        setUpNameLabel()
        setUpTelephoneLable()
        setUpBusketButton()
        setUpShopButton()
        setUpSmthButton1()
        setUpSmthButton2()
        setUpSmthButton3()
        setUpLogOutButton()
    }
    
    private func setUpProfileImageView(){
        view.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.image = UIImage(named: "telegramPhoto")
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 52),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 200),
            profileImageView.heightAnchor.constraint(equalToConstant: 200),
        ])
        view.layoutIfNeeded()
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
    }
    
    private func setUpNameLabel(){
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Кирилл"
        nameLabel.font = UIFont.systemFont(ofSize: 30)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 3),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setUpTelephoneLable(){
        view.addSubview(telephoneLabel)
        telephoneLabel.translatesAutoresizingMaskIntoConstraints = false
        telephoneLabel.text = "8 800 555 3535"
        telephoneLabel.font = UIFont.systemFont(ofSize: 30)
        telephoneLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            telephoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            telephoneLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        ])
    }
    
    private func setUpBusketButton(){
        applyButtonConfig(busketButton, "Корзина")
        
        NSLayoutConstraint.activate([
            busketButton.topAnchor.constraint(equalTo: telephoneLabel.bottomAnchor, constant: 19),
            busketButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            busketButton.widthAnchor.constraint(equalToConstant: 223),
            busketButton.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        busketButton.addTarget(self, action: #selector(busketButtonAction), for: .touchUpInside)
    }
    
    private func setUpShopButton(){
        applyButtonConfig(shopButton, "Магазин")
        
        NSLayoutConstraint.activate([
            shopButton.topAnchor.constraint(equalTo: busketButton.bottomAnchor, constant: 15),
            shopButton.trailingAnchor.constraint(equalTo: busketButton.trailingAnchor),
            shopButton.widthAnchor.constraint(equalToConstant: 100),
            shopButton.heightAnchor.constraint(equalToConstant: 27)
        ])
        
        shopButton.addTarget(self, action: #selector(shopButtonAction), for: .touchUpInside)
    }
    
    private func setUpSmthButton1(){
        applyButtonConfig(smthButton1, "Что-то")
        
        NSLayoutConstraint.activate([
            smthButton1.topAnchor.constraint(equalTo: busketButton.bottomAnchor, constant: 15),
            smthButton1.leadingAnchor.constraint(equalTo: busketButton.leadingAnchor),
            smthButton1.widthAnchor.constraint(equalToConstant: 100),
            smthButton1.heightAnchor.constraint(equalToConstant: 27)
        ])
    }
    
    private func setUpSmthButton2(){
        applyButtonConfig(smthButton2, "Что-то")
        
        NSLayoutConstraint.activate([
            smthButton2.topAnchor.constraint(equalTo: smthButton1.bottomAnchor, constant: 15),
            smthButton2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            smthButton2.widthAnchor.constraint(equalToConstant: 100),
            smthButton2.heightAnchor.constraint(equalToConstant: 27)
        ])
    }
    
    private func setUpSmthButton3(){
        applyButtonConfig(smthButton3, "Что-то")
        
        NSLayoutConstraint.activate([
            smthButton3.topAnchor.constraint(equalTo: smthButton2.bottomAnchor, constant: 15),
            smthButton3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            smthButton3.widthAnchor.constraint(equalToConstant: 100),
            smthButton3.heightAnchor.constraint(equalToConstant: 27)
        ])
    }
    
    private func setUpLogOutButton(){
        applyButtonConfig(logOutButton, "Выйти")
        
        NSLayoutConstraint.activate([
            logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -7),
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.widthAnchor.constraint(equalToConstant: 223),
            logOutButton.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        logOutButton.addTarget(self, action: #selector(logOutButtonAction), for: .touchUpInside)
    }
    
    private func applyButtonConfig(_ button: UIButton, _ title: String){
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .opaqueSeparator
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.layer.cornerRadius = 7
    }
    
    // MARK: - Actions
    
    @objc
    private func shopButtonAction(){
        navigationController?.pushViewController(ShopViewController(), animated: true)
    }
    
    @objc
    private func busketButtonAction(){
        navigationController?.pushViewController(BusketViewController(), animated: true)
    }
    
    @objc
    private func logOutButtonAction(){
        navigationController?.popViewController(animated: true)
    }
}
