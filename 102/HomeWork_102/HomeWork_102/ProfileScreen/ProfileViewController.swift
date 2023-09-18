//
//  profileViewController.swift
//  HomeWork_102
//
//  Created by Артур Миннушин on 17.09.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var basketButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.layer.cornerRadius = 100
        basketButton.layer.cornerRadius = 8
        navigationItem.leftBarButtonItem = UIBarButtonItem (
            title: "",
            style: .plain,
            target: self, action: nil
        )
    }
    
    @IBAction func backToLoginViewController(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goToBacketViewController(_ sender: UIButton) {
        let storyborad = UIStoryboard(name: "Basket", bundle: nil)
        let basketViewController = storyborad.instantiateViewController(withIdentifier: "BasketViewController") as! BasketViewController
        
        navigationController?.pushViewController(basketViewController, animated: true)
    }
    
    @IBAction func goToShopViewController(_ sender: UIButton) {
        let storyborad = UIStoryboard(name: "Shop", bundle: nil)
        let shopViewController = storyborad.instantiateViewController(withIdentifier: "ShopViewController") as! ShopViewController
        
        navigationController?.pushViewController(shopViewController, animated: true)
    }
}
