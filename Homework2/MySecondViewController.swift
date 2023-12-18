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
        
    }
    
    @IBAction func BackButton(_ sender: UIButton) {
        navigateToOtherScreen()
    }
    func navigateToOtherScreen() {
            let otherViewController = MyFirstViewController()
            navigationController?.pushViewController(otherViewController, animated: true)
    }

}
