//
//  MyFirstViewController.swift
//  HomeWork2
//
//  Created by Alina on 17.09.2023.
//

import UIKit

class MyFirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "123"{
            performSegue(withIdentifier: <#T##String#>, sender: nil)
        }
    }

}
