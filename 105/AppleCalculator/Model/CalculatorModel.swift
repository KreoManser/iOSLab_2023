//
//  File.swift
//  AppleCalculator
//
//  Created by Faki Doosuur Doris on 07.10.2023.
//

import Foundation

class CalculatorModel {
    
    ///To hold calculator's current result (first number)
    var currentResult: Double?
    ///To hold the operand  picked by the user(second number)
    private var secondNumber: Double?
    ///To hold the operation being chosen by the usesr
    var currentOperation: String?
    ///To check if the user entered a decimal input or not.
    var isDecimalInput = false
    ///To store last operation
    private var lastOperation: String?
    private var lastResult: Double?
    
    ////Stack to keep track of performed operations and their results
    private var operationStack: [(Double, String, Double)] = []
    private var undoStack: [(Double, String, Double)] = []
    
    init(currentResult: Double? = nil, secondNumber: Double? = nil, currentOperation: String? = nil) {
        self.currentResult = currentResult
        self.secondNumber = secondNumber
        self.currentOperation = currentOperation
    }
    
    
    
    func inputNumber(_ number: Double) {
        
        if currentOperation == nil {
                if self.currentResult == nil {
                    currentResult = number
                } else {
                    if isDecimalInput {
                        let numberOfDecimalPlaces = String(number).components(separatedBy: ".").last?.count ?? 0
                        currentResult = currentResult! + (number / pow(10.0, Double(numberOfDecimalPlaces)))
                    } else {
                        currentResult = currentResult! * 10 + number
                    }
                }
            } else {
                if secondNumber == nil {
                    secondNumber = number
                } else {
                    if isDecimalInput {
                        let numberOfDecimalPlaces = String(number).components(separatedBy: ".").last?.count ?? 0
                        secondNumber = secondNumber! + (number / pow(10.0, Double(numberOfDecimalPlaces)))
                    } else {
                        secondNumber = secondNumber! * 10 + number
                    }
                }
            }
    
        
    }
    
    
    
    func inputOperator(_ operatorSign: String) {
        if let first = currentResult, let second = secondNumber, let operation = currentOperation {
            operationStack.append((first, operation, second))
            undoStack.removeAll()
        }
        self.currentOperation = operatorSign
        
    }
    
    func performOperation( ) -> Double? {
        guard let first = currentResult, let second = secondNumber, let _ = currentOperation else {
            return nil
        }
        switch currentOperation {
        case "+":
            return first + second
        case "-":
            return first - second
        case "*":
            return first * second
        case "/":
            if second == 0 {
                return 0.0
            }
            return first / second
        default:
            return nil
        }
    }
    
    
    
    
    func getResult() -> String {
//        if let result = performOperation() {
//            return String(format:"%.2f", result)
//        } else {
//            return "Error"
//        }
        
        if let result = performOperation() {
                if result.truncatingRemainder(dividingBy: 1) == 0 {
                    return String(Int(result))
                } else {
                    return String(format: "%.2f", result)
                }
            } else {
                return "Error"
            }
        
    }
    
    func clear() {
        currentResult = nil
        currentOperation = nil
        secondNumber = nil
        isDecimalInput = false
        operationStack.removeAll()
        undoStack.removeAll()
    }
    
    
    func repeatLastOperation() {
        if let (first, operation, second) = operationStack.last {
            currentResult = first
            currentOperation = operation
            secondNumber = second
        }
    }
    
}
