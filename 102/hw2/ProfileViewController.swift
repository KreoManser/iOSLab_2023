//
//  ProfileViewController.swift
//  hw2
//
//  Created by Ruslan on 20.09.2023.
//

import UIKit

class ProfileViewController: UIViewController {


    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBAction func toTrashBasket(_ sender: Any) {
        performSegue(withIdentifier: "toTrashBasket", sender: self)
    }
    
    
    @IBAction func exitToProfileViewController(segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()

        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2 
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
