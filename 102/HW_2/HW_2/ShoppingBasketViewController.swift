//
//  ShoppingBasketViewController.swift
//  HW_2
//
//  Created by Тимур Хайруллин on 18.09.2023.
//

import UIKit

class ShoppingBasketViewController: UIViewController {
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: false)
        
        totalLabel.layer.cornerRadius = 5.0
        totalLabel.clipsToBounds = true
    }

}
