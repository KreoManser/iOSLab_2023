//
//  BasketCarsViewController.swift
//  AutoRepairShop
//
//  Created by Нияз Ризванов on 10.10.2023.
//

import UIKit

class BasketCarsViewController: UIViewController {

    lazy var basketCarsView = BasketCarsView(frame: .zero)
    
    override func loadView() {
        super.loadView()
        view = basketCarsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        basketCarsView.basketCarsController = self
    }
    
}

extension BasketCarsViewController: AddDelegateViewController {
    func updateData(for task: Car) {
        
    }
    
}
