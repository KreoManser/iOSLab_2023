//
//  ProfileViewController.swift
//  HW2
//
//  Created by Dmitry on 17.09.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        avatarImage.image = UIImage(named: "dog")
        self.avatarImage.layer.cornerRadius = self.avatarImage.frame.size.width / 2
        self.avatarImage.clipsToBounds = true
        self.avatarImage.layer.borderColor = UIColor.white.cgColor
        self.avatarImage.layer.borderWidth = 5
    }
    
    @IBAction func backToLogInScreen(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
}
