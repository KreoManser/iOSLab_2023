//
//  HomePageViewController.swift
//  Homework_2
//
//  Created by Камил Хайрутдинов on 16.09.2023.
//

import UIKit

class HomePageViewController: UIViewController {

    var userName = ""
    var userPhoneNumber = ""
    var userImage: UIImage? = nil
    
    // MARK: - IBOulets
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userPhoneNumberLabel: UILabel!
    
    // MARK: - IBActions
    @IBAction func shoppingBasketButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "showShoppingBasketPage", sender: nil)
    }
    
    @IBAction func exitToHomeViewController(_ segue: UIStoryboardSegue) { }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///Делаю imageView круглым
        userImageView.layer.masksToBounds = true
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        
        userImageView.image = userImage
        userNameLabel.text = userName
        userPhoneNumberLabel.text = userPhoneNumber
        
    }
}
