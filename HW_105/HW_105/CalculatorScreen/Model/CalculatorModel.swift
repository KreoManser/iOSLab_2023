//
//  CalculatorModel.swift
//  HW_105
//
//  Created by Азат Зиганшин on 09.10.2023.
//

import Foundation
import UIKit

/// Types of calculator operations
enum Operation {
        case addition
        case subtraction
        case multiplication
        case division
        case none
}

class CalculatorModel {
    var firstNumber: String = "0"
    var secondNumber: String = ""
    var isFirstNumber: Bool = true
    var currentOperation: Operation = Operation.none
    
    /// Сonfigures all the logic of the calculator, sets each button action
    /// - Parameter calcView: calculator view to be configured
    func setupCalculator(calcView: CalculatorView) {
        
        let digits: [UIButton] = [calcView.oneButton, calcView.twoButton, calcView.threeButton, calcView.fourButton, calcView.fiveButton, calcView.sixButton, calcView.sevenButton, calcView.eightButton, calcView.nineButton, calcView.zeroButton]
        let operations: [UIButton] = [calcView.plusButton, calcView.minusButton, calcView.multiplicationButton, calcView.divisionButton]
        
        /// Displays the pressed digit on the calculator screen
        let digitAction: ((String) -> Void) =  { [weak self] digit in
            guard var first = self?.firstNumber else {return}
            guard var second = self?.secondNumber else {return}
            
            if (self?.isFirstNumber == true) {
                if (first == "0") {
                    first = digit
                    calcView.displayLabel.text = first
                }
                else {
                    first = first + digit
                    calcView.displayLabel.text = first
                }
            }
            else {
                second = second + digit
                calcView.displayLabel.text = second
            }
            
            self?.firstNumber = first
            self?.secondNumber = second
        }
        
        /// Saves the current operation when the user clicks on some operation in the calculator
        let operationAction: ((String) -> Void) = { [weak self] operation in
            self?.isFirstNumber = false
            switch operation {
            case "+":
                self?.currentOperation = Operation.addition
            case "-":
                self?.currentOperation = Operation.subtraction
            case "÷":
                self?.currentOperation = Operation.division
            case "×":
                self?.currentOperation = Operation.multiplication
            default:
                return
            }
        }
        
        /// Displays the result of calculations on the calculator screen
        let equalAction: (() -> Void) = { [weak self] in
            guard let first = self?.firstNumber else {return}
            guard let second = self?.secondNumber else {return}
            guard let firstFloat = Float(first) else {return}
            guard let secondFloat = Float(second) else {return}
            var result: Float
            switch self?.currentOperation {
            case .addition:
                result = firstFloat + secondFloat
            case .subtraction:
                result = firstFloat - secondFloat
            case .multiplication:
                result = firstFloat * secondFloat
            case .division:
                result = firstFloat / secondFloat
            default:
                return
            }
            let stringResult = setupResult(number: result)
            calcView.displayLabel.text = stringResult
            self?.firstNumber = stringResult
            self?.secondNumber = ""
            self?.isFirstNumber = true
        }
        
        /// Resets the calculator
        let ACAction = { [weak self] in
            self?.firstNumber = "0"
            self?.secondNumber = ""
            self?.isFirstNumber = true
            self?.currentOperation = Operation.none
            calcView.displayLabel.text = "0"
        }
        
        /// Adds an action to the button of each digit
        digits.forEach { digitButton in
            digitButton.addAction(UIAction{ _ in digitAction((digitButton.titleLabel?.text)!)}, for: .touchUpInside)
        }
        
        /// Adds an action to the button of each operation
        operations.forEach { operationButton in
            operationButton.addAction(UIAction{ _ in operationAction((operationButton.titleLabel?.text)!)}, for: .touchUpInside)
        }
        calcView.ACButton.addAction(UIAction{_ in ACAction()}, for: .touchUpInside)
        calcView.equalButton.addAction(UIAction{_ in equalAction()}, for: .touchUpInside)
        
        /// Auxiliary function to remove the extra 0 after the decimal point in float
        /// - Parameter number: Number for setup
        /// - Returns: Updated string number
        func setupResult(number: Float) -> String {
            if (number == Float(Int(number))) {
                return String(Int(number))
            }
            else {
                return String(number)
            }
        }
    }
}
