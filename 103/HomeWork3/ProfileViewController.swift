//
//  ProfileViewController.swift
//  HomeWork3
//
//  Created by Faki Doosuur Doris on 26.09.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    ///adding the user's name
    private lazy var mynameLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = "Faki Doosuur Doris"
        myLabel.font = .systemFont(ofSize: 17)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
       return myLabel
    }()
    ///adding the phoneNUmber's label
    private lazy var myNumberLabel: UILabel = {
        let mySecondLabel = UILabel()
        mySecondLabel.text = "+79625675641"
        mySecondLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        mySecondLabel.textColor = .systemGray3
        mySecondLabel.translatesAutoresizingMaskIntoConstraints = false
        return mySecondLabel
    }()
    ///adding the profile image
    private lazy var imageView: UIImageView = {
        let mySecondImageView: UIImageView
        mySecondImageView = UIImageView()
        mySecondImageView.contentMode = .scaleAspectFit
        mySecondImageView.image = UIImage(named: "cart2.jpeg")
        mySecondImageView.translatesAutoresizingMaskIntoConstraints = false
        return mySecondImageView
    }()
    
    ///button that takes you to mycart  page
    private lazy var button1: UIButton = {
        var someButton = UIButton.Configuration.tinted()
        someButton.title = "Go To Cart"
        someButton.baseForegroundColor = .black
        
        return UIButton(
            configuration: someButton,
            primaryAction: UIAction { [weak self] _ in
            self?.showMyCart()
            })
    }()
    ///button to logout of profile
    private lazy var button2: UIButton = {
        var button = UIButton.Configuration.plain()
        button.title = "LOG OUT"
        button.baseForegroundColor = .black
        
        return UIButton(
            configuration: button,
            primaryAction: UIAction { [weak self] _ in
            self?.exitButton()
            })
    }()
        override func viewDidLoad() {
           super.viewDidLoad()
           view.backgroundColor = .systemGray6
           navigationItem.hidesBackButton = true
            imageView.circlarImage()
           addVubViews(imageView, mynameLabel, myNumberLabel,  button1, button2)
           configureUI()
            
    }
    
    private func showMyCart() {
        print("Moved to cart")
        let thirdViewController = MycartViewController()
        navigationController?.pushViewController(thirdViewController, animated: true)
    }
    
    private func exitButton() {
        print("exit from profile")
        let firstViewController = LoginViewController()
        navigationController?.pushViewController(firstViewController, animated: true)
    }
}
extension  ProfileViewController {
    private func addVubViews(_ subviews: UIView...) {
        subviews.forEach { view.addSubview($0)}
    }
    private func configureUI() {
        button1.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 5),
            
            mynameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 15),
            mynameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            myNumberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 15),
            myNumberLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -5),
            
            button1.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 15),
            button1.widthAnchor.constraint(equalToConstant: 150),
            button1.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            
            button2.widthAnchor.constraint(equalToConstant: 250),
            button2.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 15),
            button2.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 250),
        ])
    }
}
extension UIImageView {
    func circlarImage() {
        layer.cornerRadius = 100
        layer.borderColor = UIColor(.black).cgColor
        layer.borderWidth = 1.0
        layer.masksToBounds = false
        self.clipsToBounds = true
    }
}
