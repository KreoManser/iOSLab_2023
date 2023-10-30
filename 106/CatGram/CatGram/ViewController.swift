//
//  ViewController.swift
//  CatGram
//
//  Created by Нияз Ризванов on 28.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var mainProfileView = MainProfileCatGramView(frame: .zero)
    
    override func loadView() {
        super.loadView()
        view = mainProfileView
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainProfileView.controller = self
        mainProfileView.setupNavigationBar()
    }
}
