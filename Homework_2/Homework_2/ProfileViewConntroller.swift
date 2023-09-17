//
//  ProfileViewConntroller.swift
//  Homework_2
//
//  Created by err on 17.09.2023.
//

import UIKit

class ProfileViewConntroller: UIViewController {

    
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        
    }
    
    @IBAction func exitButton(_ sender: Any) {
        dismiss(animated: true)
    }
   

}
