//
//  ViewController.swift
//  105
//
//  Created by Dmitry on 06.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Variables
    
    private lazy var calculatorView = CalculatorView()
    
    private let calculatorManager = CalculatorLogic()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view = calculatorView
    }
    
    // MARK: - Controller life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatorManager.setViewController(controller: self)
        calculatorView.setUpController(controlller: self)
    }
    
    override func viewDidLayoutSubviews() {
        calculatorView.setUpCornerRadius()
    }
}

extension ViewController {
    
    // MARK: - Methods
    
    /// Sends received operation type and introducedNumber from calculatorView to calculatorManager
    func sendOperationTypeToCalcManager(operation: Operation, introducedNumber: String) {
        calculatorManager.writeFirstValue(operation: operation, introducedNumber: introducedNumber)
    }

    /// Updates calculatorView label by received string
    func updateViewLabel(text: String) {
        calculatorView.updateLabel(text: text)
    }
    
}

