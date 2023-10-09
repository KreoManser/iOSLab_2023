//
//  BasketViewController.swift
//  HomeWork_2
//
//  Created by Нияз Ризванов on 17.09.2023.
//

import UIKit

class BasketViewController: UIViewController {
    @IBOutlet weak var basket_element_5: UIView!
    @IBOutlet weak var basket_element_4: UIView!
    @IBOutlet weak var basket_element_3: UIView!
    @IBOutlet weak var basket_element_2: UIView!
    @IBOutlet weak var basket_element_1: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBasketElement(basket_element_1)
        configureBasketElement(basket_element_2)
        configureBasketElement(basket_element_3)
        configureBasketElement(basket_element_4)
        configureBasketElement(basket_element_5)
    }
    
    private func configureBasketElement(_ element: UIView) {
            element.layer.shadowColor = UIColor.black.cgColor
            element.layer.shadowOpacity = 0.5
            element.layer.shadowOffset = CGSize(width: 0, height: 2)
            element.layer.shadowRadius = 4
            element.layer.cornerRadius = 4
        }
}
