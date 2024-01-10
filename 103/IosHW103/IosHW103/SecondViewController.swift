//
//  SecondViewController.swift
//  IosHW103
//
//  Created by Ильмир Шарафутдинов on 08.01.2024.
//

import UIKit

class SecondViewController: UIViewController {
    
    let namelabelConstant = "Ильмир"
    let phoneNumberlabelConstant = "8 800 555 3535"
    let nameLabelFontConstant = 24
    let phoneNumberLabelConstant = 17
    let exitButtonSetTitleConstant = "Выйти"
    let shopButtonSetTitleConstant = "Магазин"
    let basketButtonSetTitleConstant = "Корзина"
    let normalButtonSetTitleConstant = "что-то"
    let simpleButtonSetTitleConstant = "оп оп"
    let noNameButtonSetTitleConstant = "Магазин"
    
    let imageViewTopAncorConstant = 105
    let imageViewWidthConstant = 200
    
    let nameLabelTopAncorConstraints = 19
    let nameLabelWidthAncorConstraints = 16
    let phoneNumberAncorConstraints = 3
    let basketButtonAncorConstraints = 43
    let basketButtonHeightAncorConstraints = 33
    let basketButtonWidthAncorConstraints = 223
    
    let noNameButtonWidthAnchorConstraints = 100
    let noNameButtonHeightAnchorConstraints = 27
    let noNameButtonLeadingAnchorConstraints = 85
    let exitButtonBottomAnchorConstraints = 30


    lazy var imageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "voy"))
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    lazy var namelabel: UILabel = {
        let login = UILabel()
        login.translatesAutoresizingMaskIntoConstraints = false
        
        return login
    }()
    
    lazy var phoneNumberlabel: UILabel = {
        let password = UILabel()
        password.translatesAutoresizingMaskIntoConstraints = false
        
        return password
    }()
    
    lazy var basketButton: UIButton = {
        let basket = UIButton()
        basket.translatesAutoresizingMaskIntoConstraints = false
        
        return basket
    }()
    
    lazy var shopButton: UIButton = {
        let shop = UIButton()
        shop.translatesAutoresizingMaskIntoConstraints = false
        
        return shop
    }()
    
    lazy var noNameButton: UIButton = {
        let entrance = UIButton()
        entrance.translatesAutoresizingMaskIntoConstraints = false
        
        return entrance
    }()
    
    lazy var normalButton: UIButton = {
        let entrance = UIButton()
        entrance.translatesAutoresizingMaskIntoConstraints = false
        
        return entrance
    }()
    
    lazy var simpleButton: UIButton = {
        let entrance = UIButton()
        entrance.translatesAutoresizingMaskIntoConstraints = false
        
        return entrance
    }()
    
    lazy var exitButton: UIButton = {
        let exit = UIButton()
        exit.translatesAutoresizingMaskIntoConstraints = false
        
        return exit
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
    
    func setupLayout() {
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = CGFloat(imageViewWidthConstant / 2)
        imageView.clipsToBounds = true
        
        namelabel.text = namelabelConstant
        namelabel.textAlignment = .center
        phoneNumberlabel.text = phoneNumberlabelConstant
        phoneNumberlabel.textAlignment = .center
        namelabel.font = UIFont.systemFont(ofSize: CGFloat(nameLabelFontConstant))
        phoneNumberlabel.font = UIFont.systemFont(ofSize: CGFloat(phoneNumberLabelConstant))
        
        exitButton.setTitle(exitButtonSetTitleConstant, for: .normal)
        shopButton.setTitle(shopButtonSetTitleConstant, for: .normal)
        basketButton.setTitle(basketButtonSetTitleConstant, for: .normal)
        normalButton.setTitle(normalButtonSetTitleConstant, for: .normal)
        simpleButton.setTitle(simpleButtonSetTitleConstant, for: .normal)
        noNameButton.setTitle(noNameButtonSetTitleConstant, for: .normal)
        
        exitButton.setTitleColor(.black, for: .normal)
        shopButton.setTitleColor(.black, for: .normal)
        basketButton.setTitleColor(.black, for: .normal)
        normalButton.setTitleColor(.black, for: .normal)
        simpleButton.setTitleColor(.black, for: .normal)
        noNameButton.setTitleColor(.black, for: .normal)
        
        exitButton.backgroundColor = .lightGray
        shopButton.backgroundColor = .lightGray
        basketButton.backgroundColor = .lightGray
        normalButton.backgroundColor = .lightGray
        simpleButton.backgroundColor = .lightGray
        noNameButton.backgroundColor = .lightGray
        exitButton.setTitleColor(.black, for: .normal)
        
        exitButton.addTarget(self, action: #selector(self.exitButtonAction), for: .touchUpInside)
        basketButton.addTarget(self, action: #selector(self.basketButtonAction), for: .touchUpInside)
        noNameButton.addTarget(self, action: #selector(self.noNameButtonAction), for: .touchUpInside)
        
        view.addSubview(imageView)
        view.addSubview(namelabel)
        view.addSubview(phoneNumberlabel)
        view.addSubview(exitButton)
        view.addSubview(shopButton)
        view.addSubview(basketButton)
        view.addSubview(normalButton)
        view.addSubview(simpleButton)
        view.addSubview(noNameButton)
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(imageViewTopAncorConstant)),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: CGFloat(imageViewWidthConstant)),
            imageView.heightAnchor.constraint(equalToConstant: CGFloat(imageViewWidthConstant)),
            
            namelabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: CGFloat(nameLabelTopAncorConstraints)),
            namelabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(nameLabelWidthAncorConstraints)),
            namelabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CGFloat(nameLabelWidthAncorConstraints)),

            phoneNumberlabel.topAnchor.constraint(equalTo: namelabel.bottomAnchor, constant: CGFloat(phoneNumberAncorConstraints)),
            phoneNumberlabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(nameLabelWidthAncorConstraints)),
            phoneNumberlabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CGFloat(nameLabelWidthAncorConstraints)),
            
            basketButton.topAnchor.constraint(equalTo: phoneNumberlabel.bottomAnchor, constant: CGFloat(basketButtonAncorConstraints)),
            basketButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            basketButton.widthAnchor.constraint(equalToConstant: CGFloat(basketButtonWidthAncorConstraints)),
            basketButton.heightAnchor.constraint(equalToConstant: CGFloat(basketButtonHeightAncorConstraints)),
            
            noNameButton.topAnchor.constraint(equalTo: basketButton.bottomAnchor, constant: CGFloat(nameLabelTopAncorConstraints)),
            noNameButton.widthAnchor.constraint(equalToConstant: CGFloat(noNameButtonWidthAnchorConstraints)),
            noNameButton.heightAnchor.constraint(equalToConstant: CGFloat(noNameButtonHeightAnchorConstraints)),
            noNameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(noNameButtonLeadingAnchorConstraints)),
           
            shopButton.topAnchor.constraint(equalTo: basketButton.bottomAnchor, constant: CGFloat(nameLabelTopAncorConstraints)),
            shopButton.widthAnchor.constraint(equalToConstant: CGFloat(noNameButtonWidthAnchorConstraints)),
            shopButton.heightAnchor.constraint(equalToConstant: CGFloat(noNameButtonHeightAnchorConstraints)),
            shopButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CGFloat(noNameButtonLeadingAnchorConstraints)),
            
            normalButton.topAnchor.constraint(equalTo: shopButton.bottomAnchor, constant: CGFloat(nameLabelTopAncorConstraints)),
            normalButton.centerXAnchor.constraint(equalTo:view.centerXAnchor),
            normalButton.widthAnchor.constraint(equalToConstant: CGFloat(noNameButtonWidthAnchorConstraints)),
            normalButton.heightAnchor.constraint(equalToConstant: CGFloat(noNameButtonHeightAnchorConstraints)),
            
            simpleButton.topAnchor.constraint(equalTo: normalButton.bottomAnchor, constant: CGFloat(nameLabelTopAncorConstraints)),
            simpleButton.centerXAnchor.constraint(equalTo:view.centerXAnchor),
            simpleButton.widthAnchor.constraint(equalToConstant: CGFloat(noNameButtonWidthAnchorConstraints)),
            simpleButton.heightAnchor.constraint(equalToConstant: CGFloat(noNameButtonHeightAnchorConstraints)),
            
            exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -CGFloat(exitButtonBottomAnchorConstraints)),
            exitButton.widthAnchor.constraint(equalToConstant: CGFloat(basketButtonWidthAncorConstraints)),
            exitButton.heightAnchor.constraint(equalToConstant: CGFloat(basketButtonHeightAncorConstraints))
        ])
    }
    
    @objc func exitButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func basketButtonAction() {
        let basketViewController = BasketViewController()
        self.navigationController?.pushViewController(basketViewController, animated: true)
    }
    
    @objc func noNameButtonAction() {
        let shopViewController = ShopViewController()
        self.navigationController?.pushViewController(shopViewController, animated: true)
    }
}
