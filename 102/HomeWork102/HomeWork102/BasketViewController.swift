//
//  BasketViewController.swift
//  HomeWork102
//
//  Created by Ильмир Шарафутдинов on 04.01.2024.
//

import UIKit

class BasketViewController: UIViewController {

    @IBOutlet weak var viewIphonePro: UIView!
    @IBOutlet weak var viewIphoneDontPro: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func BasketItemIsHidden(_ sender: Any) {
        if viewIphonePro.isHidden == true && viewIphoneDontPro.isHidden == true {
            viewIphonePro.isHidden = false
        } else if viewIphonePro.isHidden == false && viewIphoneDontPro.isHidden == true {
            viewIphoneDontPro.isHidden = false
        } else if viewIphonePro.isHidden == true && viewIphoneDontPro.isHidden == false {
            viewIphoneDontPro.isHidden = true
        } else if viewIphonePro.isHidden == false && viewIphoneDontPro.isHidden == false {
            viewIphonePro.isHidden = true
        }
    }
}
