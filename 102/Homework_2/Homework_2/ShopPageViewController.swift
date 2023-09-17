//
//  ShopPageViewController.swift
//  Homework_2
//
//  Created by Камил Хайрутдинов on 17.09.2023.
//

import UIKit

class ShopPageViewController: UIViewController {

    // MARK: - IBActions
    @IBAction func ShoppingBasketButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "showShoppingBasketPageViewFromShopPage", sender: nil)
    }
    
    @IBAction func exitToShopViewController(_ segue: UIStoryboardSegue) { }
    
    // MARK: - Live cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
