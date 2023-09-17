//
//  AccountViewController.swift
//  homework_2
//
//  Created by Данил on 17.09.2023.
//

import UIKit

class AccountViewController: UIViewController{
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func viewDidLoad() {
        userImageView.layer.cornerRadius = 15;
        userImageView.image = UIImage(named: "user");
        super.viewDidLoad();
    }
}


