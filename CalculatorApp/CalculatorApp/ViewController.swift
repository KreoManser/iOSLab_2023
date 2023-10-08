//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Rustem on 08.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var calcView = CalcView(frame: .zero)
    
    override func loadView() {
        view = calcView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

