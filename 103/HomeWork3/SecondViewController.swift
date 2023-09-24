//
//  secondViewController.swift
//  HomeWork3
//
//  Created by Faki Doosuur Doris on 23.09.2023.
//

import UIKit

class SecondViewController: UIViewController {
    ///adding the user's name
    lazy var mynameLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = "Faki Doosuur Doris"
        myLabel.font = .systemFont(ofSize: 17)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
       return myLabel
    }()
    ///adding the phoneNUmber's label
    lazy var myNumberLabel: UILabel = {
        let mySecondLabel = UILabel()
        mySecondLabel.text = "+79625675641"
        mySecondLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        mySecondLabel.textColor = .systemGray3
        mySecondLabel.translatesAutoresizingMaskIntoConstraints = false
        return mySecondLabel
    }()
    ///adding the profile image
    lazy var imageView: UIImageView = {
        let mySecondImageView: UIImageView
        mySecondImageView = UIImageView()
        mySecondImageView.contentMode = .scaleAspectFit
        mySecondImageView.image = UIImage(named: "profile1.jpeg")
        mySecondImageView.translatesAutoresizingMaskIntoConstraints = false
        return mySecondImageView
    }()
    
    ///button that takes you to mycart  page
    lazy var button1: UIButton = {
        let someButton = UIButton()
        someButton.backgroundColor = .black
        someButton.setTitle("Go To Cart", for: .normal)
        someButton.setTitleColor(.white, for: .normal)
        someButton.layer.masksToBounds = false
        someButton.layer.cornerRadius = 10
        someButton.clipsToBounds = true
        someButton.layer.borderWidth = 1.0
        someButton.addTarget(self, action: #selector(showMyCart), for: .touchUpInside)
        someButton.translatesAutoresizingMaskIntoConstraints = false
        return someButton
    }()
    ///button to logout of profile
    lazy var button2: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1.0
        button.addTarget(self, action: #selector(exitButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        imageView.center = self.view.center
        self.view.addSubview(imageView)
        imageView.maskCircle()
        self.view.addSubview(mynameLabel)
        self.view.addSubview(myNumberLabel)
        self.view.addSubview(button1)
        self.view.addSubview(button2)
        self.navigationItem.hidesBackButton = true
        
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
    @objc func exitButton(_ sender: UIButton) {
        print("exit from profile")
        let firstViewController = ViewController()
        show(firstViewController, sender: self)
    }
    
    @objc func showMyCart(_ sender: UIButton) {
        print("Moved to cart")
        let thirdViewController = ThirdViewController()
        show(thirdViewController, sender: self)
    }
}
