//
//  MySecondViewController.swift
//  HomeWork2
//
//  Created by Alina on 17.09.2023.
//

import UIKit

class MySecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: Any){
        navigationController?.popViewController(animated: true)
    }

    

}
