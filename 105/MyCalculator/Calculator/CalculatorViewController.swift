//
//  CalculatorViewController.swift
//  MyCalculator
//
//  Created by Ruslan Kozlov on 04.10.2023.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    lazy var calculatorView = UICalculatorView(frame: .zero)
    lazy var currentOrientation = UIDevice.current.orientation
    
    let calculate = Calculate()
    
//    weak var calculatorDelegate: UICalculatorViewDelegate?

    
    override func loadView() {
        view = calculatorView
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calculatorView.setupLayout(for: UIDevice.current.orientation)
       
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        calculatorDelegate?.clickProcessing(dictionaryButton: calculatorView.dictionaryButton)
        
    }
}
