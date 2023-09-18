//
//  ProfileViewController.swift
//  ios_homework2
//
//  Created by Аделя Миннехузина on 18.09.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var ProfileImageView: UIImageView!
    
    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var PhoneNumberLabel: UILabel!
    
    @IBOutlet weak var TrashButton: UIButton!
    
    @IBOutlet weak var FirstSomeButton: UIButton!
    
    @IBOutlet weak var SecondSomeButton: UIButton!
    
    @IBOutlet weak var ThirdSomeButton: UIButton!
    
    @IBOutlet weak var FourthSomeButton: UIButton!
    
    @IBOutlet weak var BackButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        
    }
    
    
    @IBAction func TrashButtonDidTap(_ sender: Any) {
    }
    
    @IBAction func BackButtonDidTap(_ sender: Any) {
    }
    
}

