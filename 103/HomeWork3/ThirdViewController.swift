//
//  ThirdViewController.swift
//  HomeWork3
//
//  Created by Faki Doosuur Doris on 24.09.2023.
//

import UIKit

class ThirdViewController: UIViewController {
    
    lazy var someLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = "My Cart"
        myLabel.textColor = .black
        myLabel.font = .systemFont(ofSize: 20)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        return myLabel
    }()
    
    lazy var imageView: UIImageView = {
        let mySecondImageView: UIImageView
        mySecondImageView = UIImageView()
        mySecondImageView.contentMode = .scaleAspectFit
        mySecondImageView.image = UIImage(named: "boot.jpeg")
        mySecondImageView.translatesAutoresizingMaskIntoConstraints = false
        return mySecondImageView
    }()
    
    lazy var secondLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = "Boot for fall - $399"
        myLabel.textColor = .black
        myLabel.font = .systemFont(ofSize: 15)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        return myLabel
    }()
    
    lazy var button1: UIButton = {
        let someButton = UIButton()
        someButton.backgroundColor = .black
        someButton.setTitle("Go To Shop", for: .normal)
        someButton.setTitleColor(.white, for: .normal)
        someButton.layer.masksToBounds = false
        someButton.layer.cornerRadius = 10
        someButton.clipsToBounds = true
        someButton.layer.borderWidth = 1.0
        someButton.addTarget(self, action: #selector(exitButton), for: .touchUpInside)
        someButton.translatesAutoresizingMaskIntoConstraints = false
        return someButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(someLabel)
        self.view.addSubview(imageView)
        self.view.addSubview(secondLabel)
        self.view.addSubview(button1)
        
        self.view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            someLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 15),
            someLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -270),
            
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            
            secondLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            
            button1.widthAnchor.constraint(equalToConstant: 250),
            button1.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 15),
            button1.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30)
        ])
    }
    @objc func exitButton(_ sender: UIButton) {
        print("Move to shop")
        let fourthtViewController = FourthViewController()
        show(fourthtViewController, sender: self)
    }
}
