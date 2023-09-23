//
//  ShopViewController.swift
//  HomeWork_3
//
//  Created by Камил Хайрутдинов on 24.09.2023.
//

import UIKit

class ShopViewController: UIViewController {

    // MARK: - Lise cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    // MARK: - Setup layot func
    private func setupLayout() {
        view.backgroundColor = UIColor(displayP3Red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
    }
    
}
