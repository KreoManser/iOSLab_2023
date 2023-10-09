//
//  ViewController.swift
//  HW_105
//
//  Created by Азат Зиганшин on 08.10.2023.
//

import UIKit

class CalculatorViewController: UIViewController {

    lazy var calculatorView: CalculatorView = CalculatorView(frame: .zero)
    var calculatorModel = CalculatorModel()
    
    override func loadView() {
        view = calculatorView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculatorModel.setupCalculator(calcView: calculatorView)
    }
}

