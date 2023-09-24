//
//  ViewController.swift
//  HomeWork3
//
//  Created by Faki Doosuur Doris on 22.09.2023.
//

import UIKit

class ViewController: UIViewController {
    ///adding first label
    lazy var myLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    ///adding second label
    lazy var mySecondLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    ///adding a new image view
    lazy var myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "shein front picture.jpeg")
        imageView.contentMode = .scaleAspectFill
        imageView.imageViewCorners()
        imageView.center = self.view.center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    ///adding first textfield
    lazy var myTextField: UITextField = {
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
    lazy var secondTextField: UITextField = {
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
     lazy var myButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1.0
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.self.backgroundColor = .white
        self.view = view
        ///adding the extra subviews
        view.addSubview(myImageView)
        view.addSubview(myLabel)
        view.addSubview(myTextField)
        view.addSubview(mySecondLabel)
        view.addSubview(secondTextField)
        view.addSubview(myButton)
        self.navigationItem.hidesBackButton = true
        
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
    
    @objc func buttonTapped(_ sender: UIButton!) {
        print("button was tapped")
        let secondViewController = SecondViewController()
        self.navigationController?.pushViewController(secondViewController, animated: true)
        //show(secondViewController, sender: self)
        }
}
extension UIImageView {
    func imageViewCorners() {
        layer.cornerRadius = 20
        layer.borderWidth = 1.0
        layer.masksToBounds = false
        self.clipsToBounds = true
    }
}
extension UIImageView {
   func maskCircle() {
      self.contentMode = UIView.ContentMode.scaleAspectFill
      self.layer.cornerRadius = 100
      layer.borderWidth = 1.0
      self.layer.masksToBounds = false
      self.clipsToBounds = true
  }
}
