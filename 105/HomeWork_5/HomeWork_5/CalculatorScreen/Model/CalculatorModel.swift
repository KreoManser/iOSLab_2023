//
//  CalculatorModel.swift
//  HomeWork_5
//
//  Created by Камил Хайрутдинов on 08.10.2023.
//

import Foundation

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
    
    /// Сlosure that returns the product of two numbers
    let multiplyOperation: (Decimal, Decimal) -> String = { firstNumber,
        secondNumber in
        return String.DecimalToString(value: (firstNumber * secondNumber))
    }
    
    
    /// Сlosure that returns the quotient of two numbers
    let divideOperation: (Decimal, Decimal) -> String = { firstNumber,
        secondNumber in
        return String.DecimalToString(value: (firstNumber / secondNumber))
    }
}
