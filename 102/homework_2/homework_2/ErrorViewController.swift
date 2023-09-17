//
//  ErrorViewController.swift
//  homework_2
//
//  Created by Данил on 17.09.2023.
//

import UIKit

class ErrorViewController: UIViewController{
    
    @IBOutlet weak var errorTextView: UITextView!
    
    @IBOutlet weak var errorImageView: UIImageView!
    
    override func viewDidLoad() {
        errorImageView.image = UIImage(named: "error");
        super.viewDidLoad();
    }
    
}
