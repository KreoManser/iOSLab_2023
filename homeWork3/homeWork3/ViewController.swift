//
//  ViewController.swift
//  homeWork3
//
//  Created by marwa awwad mohamed awwad on 09.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var logo: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "logo")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loginTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Login"
        view.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var passwordTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "password"
        view.borderStyle = .roundedRect
        view.translatesAutoresizingMaskIntoConstraints = false
       
        return view
    }()
    



    let myButton = UIButton()
    
    func loginButton() {
        myButton.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        myButton.configuration = .tinted()
        myButton.configuration?.title = "Login"
        myButton.configuration?.baseForegroundColor = .white
        myButton.configuration?.baseBackgroundColor = .systemRed
        myButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
              view.addSubview(myButton)
    }
    
    @objc func loginButtonTapped() {
          let yourProfileVC = page()
        if loginTextField.text == "Admin" && passwordTextField.text == "1234"{
            navigationController?.pushViewController(yourProfileVC, animated: true)
        }
      }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(logo)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
       loginButton()
        configuration()
    }
}
extension ViewController{
    private func configuration(){
        myButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(myButton)
        
        
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            logo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            logo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            logo.bottomAnchor.constraint(equalTo: loginTextField.topAnchor, constant: -50),
            
            
            loginTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            loginTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
        
            
            passwordTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 400),
            passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            
            myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 500),
            myButton.heightAnchor.constraint(equalToConstant: 40),
            myButton.widthAnchor.constraint(equalToConstant: 215),
        
        ])
    }
}
