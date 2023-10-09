//
//  CalculatorModel.swift
//  homework_5
//
//  Created by Кирилл Щёлоков on 08.10.2023.
//

import Foundation
import UIKit

class CalculatorModel {
    
    // MARK: - Properties
    
    private var numberString: String = "0"
    private var currentOperation: Operation?
    private var operand: Double?
    private var result: String?
    
    private struct OperationHistory {
        let operand: Double?
        let operation: Operation?
        let numberString: String
        let result: String?
    }
    
    private var operationHistoryStack = [OperationHistory]()
    private var undoStack = [OperationHistory]()
    
    // MARK: - Methods
    
    func saveHistory() {
        operationHistoryStack.append(OperationHistory(operand: operand, operation: currentOperation, numberString: numberString, result: result))
    }
    
    func undo(completion: @escaping (_ result: String) -> Void) {
        if !operationHistoryStack.isEmpty{
            undoStack.append(operationHistoryStack.last!)
            let history = operationHistoryStack.removeLast()
            numberString = history.numberString
            operand = history.operand
            currentOperation = history.operation
            completion(String((Double(history.numberString)) ?? operand ?? 0))
        } else {
            completion("0")
        }
    }
    
    func redo(completion: @escaping (_ result: String) -> Void) {
        if !undoStack.isEmpty  {
            let history = undoStack.removeLast()
            operationHistoryStack.append(history)
            numberString = history.numberString
            operand = history.operand
            currentOperation = history.operation
            completion(String((Double(result ?? history.numberString)) ?? operand ?? 0))
        } else {
            completion(result ?? "0")
        }
        
    }
    
    /// Method for memorizing operand
    /// - Parameter number: number, which was tapped
    func appendNumber(_ number: Double) {
        numberString = "\(number)"
        saveHistory()
    }
    
    /// Method for memorizing operation
    /// - Parameter operation: operation, which was tapped
    func performOperation(_ operation: Operation) {
        if let operand = Double(numberString) {
            self.operand = operand
            numberString = ""
        }
        currentOperation = operation
    }

    
    /// Method for calculating result
    /// - Parameter completion: closure for transplatation the result of calculation
    func calculateResult(completion: @escaping (_ result: String) -> Void) {
        if let operand1 = operand,
           let operand2 = Double(numberString),
           let operation = currentOperation {
            switch operation {
                case .addition:
                    result = String(operand1 + operand2)
                case .subtraction:
                    result = String(operand1 - operand2)
                case .multiplication:
                    result = String(operand1 * operand2)
                case .division:
                    guard operand2 != 0 else { 
                        result = "Ошибка!"
                        completion(result!)
                        return }
                    result = String(operand1 / operand2)
                }
        }
        undoStack.append(OperationHistory(operand: operand, operation: currentOperation, numberString: numberString, result: result))
        completion(result!)
        }
    
    func clear() {
        numberString = ""
        currentOperation = nil
        operand = nil
    }
    
    func clearOperation(){
        currentOperation = nil
    }
}

/// Enum with the list of calculate operations
enum Operation {
    case addition
    case subtraction
    case multiplication
    case division
}
