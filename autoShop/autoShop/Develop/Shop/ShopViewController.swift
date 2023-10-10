//
//  ViewController.swift
//  autoShop
//
//  Created by Артур Миннушин on 10.10.2023.
//

import UIKit

protocol ShopController: AnyObject {
    func callMeFromView()
}

class ShopViewController: UIViewController, ShopController {

    let shopView: ShopView = ShopView(frame: .zero)
    let dataManager = DataBase()
    let tableViewDataSource = ShopTableViewDataSource()
    
    override func loadView() {
        view = shopView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shopView.shopController = self
        tableViewDataSource.dataSource = dataManager.getData()
        setupNavBar()
    }
    
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        shopView.configureTable(dataSource: tableViewDataSource)
    }

    func setupNavBar() {
        let addAction = UIAction { _ in
            let vc = BacketViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .trash, primaryAction: addAction, menu: nil)
    }
    
    func callMeFromView() {
        
    }
}

