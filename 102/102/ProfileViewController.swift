//
//  ProfileViewController.swift
//  102
//
//  Created by Кирилл Щёлоков on 17.09.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var basketButton: UIButton!
    @IBOutlet weak var sthButton1: UIButton!
    @IBOutlet weak var sthButton2: UIButton!
    @IBOutlet weak var sthButton3: UIButton!
    @IBOutlet weak var sthButton4: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var shopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = 100
        profileImageView.image = UIImage(named: "telegramPhoto")
        
        basketButton.layer.cornerRadius = 8
        sthButton1.layer.cornerRadius = 8
        sthButton2.layer.cornerRadius = 8
        sthButton3.layer.cornerRadius = 8
        sthButton4.layer.cornerRadius = 8
        logoutButton.layer.cornerRadius = 8
        
    }
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue){
        
    }
    
    @IBAction func busketButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "busketSeque", sender: nil)
    }
    
    @IBAction func shopButtonAtion(_ sender: Any) {
        performSegue(withIdentifier: "shopSegue", sender: nil)
    }
    
}
