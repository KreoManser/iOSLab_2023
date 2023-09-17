//
//  ViewController.swift
//  homework_2
//
//  Created by Данил on 17.09.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var loginImageView: UIImageView!

    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    let correctLogin: String = "Admin";
    let correctPassword: String = "123";
    
    override func viewDidLoad() {
        loginImageView.layer.cornerRadius = 15;
        loginImageView.image = UIImage(named: "auth");
        
        super.viewDidLoad();
        
    }
    
    @IBAction func authentification(_ sender: Any) {
        let password = passwordTextField.text;
        let phone = phoneTextField.text;
        
        passwordTextField.text = "";
        phoneTextField.text = "";
        
        if (password == correctPassword && phone == correctLogin){
            let storyboard = UIStoryboard(name: "Main", bundle: nil);
            let vc = storyboard.instantiateViewController(withIdentifier: "AccountViewController");
            navigationController?.pushViewController(vc, animated: true);
        } else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ErrorViewController");
            present(vc, animated: true);
        }
        
    }
}

