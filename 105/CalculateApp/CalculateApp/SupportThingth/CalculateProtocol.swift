//
//  CalculateProtocol.swift
//  CalculateApp
//
//  Created by Mac on 2023-10-10.
//

import Foundation

/// Protocol that describes funcs of calculation and connect to CalculateViewController and CalculateView
protocol CalculateProtocol: AnyObject {
    /// Calculate
    /// - Parameters:
    ///   - operation: operation type
    ///   - firstNumber: first number
    ///   - secondNumber: secondNumber
    /// - Returns: result of calculation in string
    func calculate(operation: OperationType, firstNumber: String, secondNumber: String) -> String
    
    /// Change number to privious
    /// - Returns: privious number
    func changeBecauseOfHistory() -> String
    
    /// Do previous operation one more time
    /// - Returns: result of oparation
    func doOneMoreTime() -> String
}
