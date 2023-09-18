//
//  MyPageViewController.swift
//  HW_2
//
//  Created by Тимур Хайруллин on 17.09.2023.
//

import UIKit

class MyPageViewController: UIViewController {
    var name = ""
    var phoneNumber = ""
    var profileImage: UIImage? = nil
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        nameLabel.text = name
        phoneNumberLabel.text = phoneNumber
        profileImageView.image = profileImage
        
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
    
    @IBAction func goToShoppingBasket(_ sender: UIButton) {
        performSegue(withIdentifier: "goToShoppingBasket", sender: "")
    }
    @IBAction func unwindToMyProfilePage(_ segue: UIStoryboardSegue) {}
}
