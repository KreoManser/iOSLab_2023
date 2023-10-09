//
//  CalculatorViewController.swift
//  HomeWork_5
//
//  Created by Камил Хайрутдинов on 06.10.2023.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    // MARK: - Variables
    
    /// CalculatorView reference
    lazy var calculatorView: CalculatorView = CalculatorView(viewWidth: view.frame)
    
    /// calculator model
    private var calculatorModel: CalculatorModel = CalculatorModel()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatorView.calculatorHandler = self
        view.addSubview(calculatorView)
        ConfigureCalculatorViewOnView()
        view.backgroundColor = .black
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if UIDevice.current.orientation.isLandscape {
            calculatorView.configureUIInLandscapeOrientation()
            calculatorView.layoutIfNeeded()
        }
        else if UIDevice.current.orientation.isPortrait {
            calculatorView.configureUIInPortraitOrientation()
            calculatorView.layoutIfNeeded()
        }
    }
}

extension CalculatorViewController: CalculatorHandler {
    
    /// Funcion from CalculatorHandler for model and view relationships
    /// - Parameters:
    ///   - oprator: Mathematical operator
    ///   - firstNumber: First number from calculator
    ///   - secondNumber: Second number from calculator
    /// - Returns: Operation result
    func calculate(oprator: Operators, firstNumber: String, secondNumber: String) -> String {
        
        let firstNumber = Decimal.ConvertStringWithComma(string: firstNumber)
        let secondNumber = Decimal.ConvertStringWithComma(string: secondNumber)
   
        switch oprator {
        case .plus:
            return calculatorModel.plusOperation(firstNumber, secondNumber)
        case .minus:
            return calculatorModel.minusOperation(firstNumber, secondNumber)
        case .multiply:
            return calculatorModel.multiplyOperation(firstNumber, secondNumber)
        case .divide:
            return calculatorModel.divideOperation(firstNumber, secondNumber)
        case .none:
            return "0"
        }
    }
}
