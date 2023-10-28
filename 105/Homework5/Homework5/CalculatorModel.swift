//
//  CalculatorModel.swift
//  Homework5
//
//  Created by kerik on 08.10.2023.
//

import Foundation
extension String {
    static func DecimalToString(value: Decimal) -> String {
        return String(describing: value).replacingOccurrences(of: ".", with: ",")
    }
}

/// Maths operators
enum Operators {
    case plus
    case minus
    case multiply
    case divide
    case none
}

struct CalculatorModel {
    /// Сlosure that returns the sum of two numbers
    let plusOperation: (Decimal, Decimal) -> String = { firstNumber,
        secondNumber in
        return String.DecimalToString(value: (firstNumber + secondNumber))
    }
    
    /// Сlosure that returns the difference of two numbers
    let minusOperation: (Decimal, Decimal) -> String = { firstNumber,
        secondNumber in
        return String.DecimalToString(value: (firstNumber - secondNumber))
    }
    
    /// Сlosure that returns the multiply of two numbers
    let multiplyOperation: (Decimal, Decimal) -> String = { firstNumber,
        secondNumber in
        return String.DecimalToString(value: (firstNumber * secondNumber))
    }
    
    
    /// Сlosure that returns the divide of two numbers
    let divideOperation: (Decimal, Decimal) -> String = { firstNumber,
        secondNumber in
        if secondNumber != 0 {
            return String.DecimalToString(value: (firstNumber / secondNumber))
        }
        else {
            return "Ошибка"
        }
    }
}
