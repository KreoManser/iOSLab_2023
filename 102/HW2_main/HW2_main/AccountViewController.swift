//
//  AccountViewController.swift
//  HW2_main
//
//  Created by Kseniya Skvortsova on 18.09.2023.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var basketButton: UIButton!
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var button4: UIButton!
    
    @IBOutlet weak var exitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        basketButton.layer.cornerRadius=basketButton.bounds.height/2
        button1.layer.cornerRadius=button1.bounds.height/2
        button2.layer.cornerRadius=button2.bounds.height/2
        button3.layer.cornerRadius=button3.bounds.height/2
        button4.layer.cornerRadius=button4.bounds.height/2
        exitButton.layer.cornerRadius=exitButton.bounds.height/2
        avatarImageView.layer.cornerRadius=avatarImageView.bounds.height/2
        
    }

    @IBAction func basketPushed(_ sender: UIButton) {
        performSegue(withIdentifier: "vc3", sender: Any?.self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
