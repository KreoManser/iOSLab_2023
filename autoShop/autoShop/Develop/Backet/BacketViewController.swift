//
//  BacketViewController.swift
//  autoShop
//
//  Created by Артур Миннушин on 10.10.2023.
//

import UIKit

protocol BacketController: AnyObject {
    func callMeFromView()
}

class BacketViewController: UIViewController, BacketController {

    let backetView: BacketView = BacketView(frame: .zero)
    let dataManager = DataBaseBaket()
    
    override func loadView() {
        view = backetView
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        backetView.configureData(dataSource: dataManager.getData())
    }

    
    func callMeFromView() {
        
    }
}
