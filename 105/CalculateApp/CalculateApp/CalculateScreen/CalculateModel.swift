//
//  CalculateModel.swift
//  CalculateApp
//
//  Created by Mac on 2023-10-09.
//

import UIKit

struct Operation {
    let firstNumber: Double
    let secondNumber: Double
    let operation: OperationType
    let result: String
}

/// Class that describes how to calculate numbers
class CalculateModel {
    /// History of results
    var history: [Operation] = []
    
    /// Make calculation of two numbers
    /// - Parameters:
    ///   - operation: operation of calculation
    ///   - first: first number in string
    ///   - second: second number in string
    /// - Returns: result of calculation in string
    func makeCalculation(operation: OperationType, first: String, second: String) -> String {
        /// Change from double to Double for calculation
        let firstNumber = Double(first) ?? 0.0
        let secondNumber = Double(second) ?? 0.0
        
        /// Set operations and count
        switch operation {
        case .plus:
            let result = self.plusOperation(firstNumber, secondNumber)
            let operation = Operation(firstNumber: firstNumber, secondNumber: secondNumber, operation: operation, result: result)
            history.append(operation)
            return result
        case .minus:
            let result = self.minusOperation(firstNumber, secondNumber)
            let operation = Operation(firstNumber: firstNumber, secondNumber: secondNumber, operation: operation, result: result)
            history.append(operation)
            return result
        case .multiply:
            let result = self.multiplyOperation(firstNumber, secondNumber)
            let operation = Operation(firstNumber: firstNumber, secondNumber: secondNumber, operation: operation, result: result)
            history.append(operation)
            return result
        case .divide:
            let result = self.divideOperation(firstNumber, secondNumber)
            let operation = Operation(firstNumber: firstNumber, secondNumber: secondNumber, operation: operation, result: result)
            history.append(operation)
            return result
        case .noOperation:
            let operation = Operation(firstNumber: firstNumber, secondNumber: secondNumber, operation: operation, result: "0")
            history.append(operation)
            return "0"
        }
    }
    
    /// Count with plus
    private let plusOperation: (Double, Double) -> String = { firstNumber, secondNumber in
        return String(firstNumber + secondNumber)
    }
    
    /// Count with minus
    private let minusOperation: (Double, Double) -> String = { firstNumber, secondNumber in
        return String(firstNumber - secondNumber)
    }
    
    /// Count with multiply
    private let multiplyOperation: (Double, Double) -> String = { firstNumber, secondNumber in
        return String(firstNumber * secondNumber)
    }
    
    /// Count with divide
    private let divideOperation: (Double, Double) -> String = { firstNumber, secondNumber in
        if secondNumber != 0 {
            return String(firstNumber / secondNumber)
        } else { return "0" }
    }
}
