//
//  AccountViewController.swift
//  HomeWork_2
//
//  Created by Нияз Ризванов on 14.09.2023.
//

import UIKit

class AccountViewController: UIViewController {
    @IBOutlet weak var photoAccount: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoAccount.layer.cornerRadius = photoAccount.frame.size.width / 2
    }
    
    @IBAction func buttonShop(_ sender: Any) {
        performSegue(withIdentifier: "switchingShop", sender: nil)
    }
    
    @IBAction func buttonBasket(_ sender: Any) {
        performSegue(withIdentifier: "switchingBasket", sender: nil)
    }
}
