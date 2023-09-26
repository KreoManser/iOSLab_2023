//
//  ViewController.swift
//  HomeWork3
//
//  Created by Faki Doosuur Doris on 26.09.2023.
//

import UIKit

class LoginViewController: UIViewController {
    ///adding first label
    private lazy var myLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    ///adding second label
    private lazy var mySecondLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    ///adding a new image view
    private lazy var myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "shein front picture.jpeg")
        imageView.contentMode = .scaleAspectFill
        imageView.imageViewCorners()
        imageView.center = self.view.center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    ///adding first textfield
    private lazy var myTextField: UITextField = {
        let txtField = UITextField()
        txtField.backgroundColor = .systemGray6
        txtField.placeholder = "Enter Username"
        txtField.borderStyle = UITextField.BorderStyle.roundedRect
        txtField.font = UIFont.systemFont(ofSize: 10)
        txtField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()
    ///adding the second textfield
    private lazy var secondTextField: UITextField = {
        let secondTxtField = UITextField()
        secondTxtField.backgroundColor = .systemGray6
        secondTxtField.placeholder = "Enter Password"
        secondTxtField.borderStyle = UITextField.BorderStyle.roundedRect
        secondTxtField.font = UIFont.systemFont(ofSize: 10)
        secondTxtField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        secondTxtField.translatesAutoresizingMaskIntoConstraints = false
        return secondTxtField
    }()
    ///adding button
     private lazy var myButton: UIButton = {
         var button = UIButton.Configuration.plain()
         button.title = "LOGIN"
         button.baseForegroundColor = .black
        
        return UIButton(
            configuration: button,
            primaryAction: UIAction { [weak self] _ in
                self?.buttonTapped()
            })
    }()
       override func viewDidLoad() {
        super.viewDidLoad()
           view.backgroundColor = .white
           addVubViews(myImageView, myLabel, mySecondLabel, myTextField, secondTextField, myButton)
           configureUI()
       }
    
    private func buttonTapped() {
        print("button was tapped")
        let secondViewController = ProfileViewController()
        navigationController?.pushViewController(secondViewController, animated: true)
    }
}

extension LoginViewController {
    private func addVubViews(_ subviews: UIView...) {
        subviews.forEach { view.addSubview($0)}
    }
    private func configureUI() {
        myButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            myImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            myImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 2),
            
            myLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -110),
            myLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            
            myTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 5),
            myTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80),
            myTextField.widthAnchor.constraint(equalToConstant: 300),
            
            mySecondLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -110),
            mySecondLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 130),
            
            secondTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 5),
            secondTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 160),
            secondTextField.widthAnchor.constraint(equalToConstant: 300),
            
            myButton.widthAnchor.constraint(equalToConstant: 100),
            myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 5),
            myButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 250),
        ])
    }
}

extension UIImageView {
    func imageViewCorners() {
        layer.cornerRadius = 20
        layer.borderWidth = 1.0
        layer.masksToBounds = false
        self.clipsToBounds = true
    }
    func maskCircle() {
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = 100
        layer.borderWidth = 1.0
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
}

