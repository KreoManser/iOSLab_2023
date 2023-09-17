//
//  ShopViewController.swift
//  102
//
//  Created by Кирилл Щёлоков on 17.09.2023.
//

import UIKit

class ShopViewController: UIViewController {

    @IBOutlet weak var returnButton: UIButton!
    
    @IBOutlet weak var firstProductImageView: UIImageView!
    @IBOutlet weak var secondProductImageView: UIImageView!
    @IBOutlet weak var thirdProductImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        returnButton.layer.cornerRadius = 12
        
        firstProductImageView.image = UIImage(named: "homeImage")
        secondProductImageView.image = UIImage(named: "sunImage")
        thirdProductImageView.image = UIImage(named: "dogImage")
        // Do any additional setup after loading the view.
    }
    

    
}
