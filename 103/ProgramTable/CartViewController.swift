//
//  CartViewController.swift
//  ProgramTable
//
//  Created by Timur on 24.09.2023.
//

import UIKit

class CartViewController: UIViewController{
    
    var emptyLabel: UILabel = {
        let emptyLabel = UILabel()
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.text = "Пусто!"
        emptyLabel.font = UIFont.systemFont(ofSize: 30)
        return emptyLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Корзина"
        view.backgroundColor = .white
        view.addSubview(emptyLabel)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.topItem?.title = ""
        emptyLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emptyLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
