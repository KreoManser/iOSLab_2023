//
//  CalculatorModel.swift
//  Homework5
//
//  Created by kerik on 08.10.2023.
//

import Foundation

class CalculatorModel {
    enum Operations {
        case noAction
        case addition
        case substraction
        case multiplication
        case division
    }

    var currentNumber = "0"
    var firstNumber = 0.0
    var secondNumber = 0.0
    var result = ""
    var currentOperation = Operations.noAction
    var displayView = ViewController()

    init(displayView: ViewController) {
        self.displayView = displayView
    }
    func updateDisplay(text: String) {
        print(text)
    }

    func makeCalculation(operation: Operations) {
        if currentOperation != .noAction {
            if currentNumber != "" {
                secondNumber = Double(currentNumber) ?? 0.0
                switch operation {
                case .addition:
                    result = String(firstNumber + secondNumber)
                default:
                    result = ""
                }
            }
            
        }
        else {
            firstNumber = Double(currentNumber) ?? 0.0
            currentNumber = ""
            updateDisplay(text: currentNumber)
            currentOperation = operation
        }
    }

    func addition() {
        makeCalculation(operation: .addition)
    }
    func substraction() {
        makeCalculation(operation: .substraction)
    }
    func multiplication() {
        makeCalculation(operation: .multiplication)
    }
    func division() {
        makeCalculation(operation: .division)
    }
    func acAction() {
        currentNumber = ""
        firstNumber = 0.0
        secondNumber = 0.0
        result = ""
        currentOperation = .noAction
        updateDisplay(text: currentNumber)
    }

}
