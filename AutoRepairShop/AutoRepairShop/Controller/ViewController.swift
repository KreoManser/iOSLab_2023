//
//  ViewController.swift
//  AutoRepairShop
//
//  Created by Нияз Ризванов on 10.10.2023.
//

import UIKit
protocol AddDelegateViewController: AnyObject{
    func updateData(for task: Car)
}

class ViewController: UIViewController {
    lazy var shopCarsView = ShopCarsView(frame: .zero)
    
    override func loadView() {
        super.loadView()
        view = shopCarsView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shopCarsView.shopCarsController = self
        
        shopCarsView.setupNavigationBar()
    }
    private weak var delegate: AddDelegateViewController?
    private var currentCar: Car!
    
//    init(car: Car, delegate: AddDelegateViewController?){
//        super.init(nibName: nil, bundle: nil)
//        self.currentCar = car
//        self.delegate = delegate
//        //titleTextField.text = task.title
//        // descriptionTextField.text = task.description
//        
//    }
    
    func addBasket() {
        navigationController?.pushViewController(BasketCarsViewController(), animated: true)
    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}


