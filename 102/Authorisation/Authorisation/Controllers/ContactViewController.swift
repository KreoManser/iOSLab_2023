//
//  ContactViewController.swift
//  Authorisation
//
//  Created by Mac on 2023-09-18.
//

import UIKit

class ContactViewController: UIViewController {
    
    @IBOutlet weak var sergeyImageView: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBAction func exitButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sergeyImageView.layer.cornerRadius = 100
        numberLabel.alpha = 0.5
    }
    
}
