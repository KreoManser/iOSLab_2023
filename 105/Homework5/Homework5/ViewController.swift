//
//  ViewController.swift
//  Homework5
//
//  Created by kerik on 07.10.2023.
//

import UIKit
extension Decimal {
    /// Function to convert String to Decimal
    /// - Parameter string: string value
    /// - Returns: decimal value with "." instead of ","
    static func ConvertStringWithComma(string: String?) -> Decimal {
        return Decimal(string: string!.replacingOccurrences(of: ",", with: ".")) ?? 0
    }
}

class ViewController: UIViewController {
    /// Reference to CalculatorView
    lazy var calculatorView: CalculatorView = CalculatorView(viewWidth: view.frame)
    /// Reference to CalculatorModel
    private var calculatorModel: CalculatorModel = CalculatorModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(calculatorView)
        calculatorView.calculatorHandler = self
        ConfigureCalculatorViewOnView()
        view.backgroundColor = .black
    }
    
}
extension ViewController {
    
    /// Configure CalculatorView on root view
    private func ConfigureCalculatorViewOnView() {
        NSLayoutConstraint.activate([
            calculatorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            calculatorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            calculatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calculatorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
extension ViewController: CalculatorHandler {
    /// Function from CalculatorHandler for CalculatorModel and CalculatorView relationships
    /// - Parameters:
    ///   - oprator: maths operator
    ///   - firstNumber: first entered number
    ///   - secondNumber: second entered number
    /// - Returns: calculation result
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

