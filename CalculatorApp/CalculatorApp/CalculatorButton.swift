//
//  CalculatorButton.swift
//  CalculatorApp
//
//  Created by Rustem on 08.10.2023.
//

import UIKit

/// enum of types of operations on button
enum CalculatorButton {
    case allClear
    case plusMinus
    case percentage
    case divide
    case multiply
    case subtract
    case add
    case equals
    case number(Int)
    case decimal
    
    init(calcButton: CalculatorButton) {
        
        switch calcButton {
        case .allClear, .plusMinus, .percentage, .divide, .multiply, .add, .equals, .decimal, .subtract:
            self = calcButton
        case .number(_):
            self = calcButton
        }
    }
}
/// an action to return
extension CalculatorButton {
    
    var title: String {
        switch self {
        case .allClear:
            return "AC"
        case .plusMinus:
            return "+/-"
        case .percentage:
            return "%"
        case .divide:
            return "÷"
        case .multiply:
            return "x"
        case .subtract:
            return "-"
        case .add:
            return "+"
        case .equals:
            return "="
        case .number(let int):
            return int.description
        case .decimal:
            return "."
        }
    }
    
    /// setting color to button
    var color: UIColor {
        switch self {
        case .allClear, .plusMinus, .percentage:
            return .lightGray
            
        case .divide, .multiply, .subtract, .add, .equals:
            return .systemOrange
            
        case .number, .decimal:
            return .darkGray
        }
    }
    
}
