//
//  CalculatorLogic.swift
//  105
//
//  Created by Dmitry on 06.10.2023.
//

import Foundation
import UIKit

enum Operation {
    case equals
    case addition
    case subtraction
    case multiplication
    case division
    case percent
    /// Revers sign of a number
    case reverseSign
    /// Clears all calculations
    case clear
    
}

class CalculatorLogic {
    
    // MARK: - Variables
    
    var firstValue: Double = 0
    
    private var secondValue: Double = 0
    
    /// Stores operations history
    private var operationHistory: [Operation] = []
    
    weak var controller: ViewController?
    
    // MARK: - Methods
    
    
    /// Sets up controller
    func setViewController(controller: ViewController) {
        self.controller = controller
    }
    
    ///  Writing first number and adding operation type to
    ///  operationHistory array or calls makeCalculations
    ///  method if operationHistory containts operation
    func writeFirstValue(operation: Operation, introducedNumber: String) {
        if operationHistory.isEmpty && introducedNumber == "0" {
            return
        }
        if operation == .reverseSign {
            if introducedNumber != "0" {
                let number = -Double(introducedNumber)!
                controller?.updateViewLabel(text: number - number.rounded() == 0 ? String(Int(number)) : String(number))
            }
            return
        }
        if operation == .clear {
            controller?.updateViewLabel(text: "0")
            operationHistory = []
            return
        }
        if operationHistory.isEmpty {
            firstValue = Double(introducedNumber)!
        }
        if operationHistory.count == 1 {
            makeCalculations(operation: operationHistory.last!, introducedNumber: introducedNumber)
            operationHistory = []
            return
        }
        operationHistory.append(operation)
        controller?.updateViewLabel(text: "0")
    }
    
    /// Makes calculations if second value received
    /// and updates calculator view label by result
    func makeCalculations(operation: Operation, introducedNumber: String) {
        secondValue = Double(introducedNumber)!
        var result = 0.0
        switch operation {
        case .addition:
            result = firstValue + secondValue
        case .equals:
            return
        case .subtraction:
            result = firstValue - secondValue
        case .multiplication:
            result = firstValue * secondValue
        case .division:
            result = firstValue / secondValue
        case .percent:
            return
        case .reverseSign:
            return
        case .clear:
            return
        }
        controller?.updateViewLabel(text: result-result.rounded() == 0 ? String(Int(result)) : String(result))
    }
}
