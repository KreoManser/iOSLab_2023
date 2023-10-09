//
//  ButtonFuncModel.swift
//  CalculatorApp
//
//  Created by Rustem on 09.10.2023.
//

import UIKit

public class ButtonFuncModel{
    
    /// changing color of pressed if its action buttons
    lazy var isPressed: (CalcButtonCell) -> Void = { cell in
        switch(cell.calculatorButton){
        case .divide, .multiply, .subtract, .add:
            UIView.animate(withDuration: 0.25){
                cell.backgroundColor = .white
                cell.titleLabel.textColor = .systemOrange
            }
        case .allClear, .plusMinus, .percentage, .equals:
            UIView.animate(withDuration: 0.5){
                cell.backgroundColor = .white
                cell.backgroundColor = cell.calculatorButton.color
            }
        default:
            UIView.animate(withDuration: 0.5){
                cell.backgroundColor = .lightGray
                cell.backgroundColor = cell.calculatorButton.color
            }
        }
    }
    
    /// changing colors back
    var isDeselected: (CalcButtonCell) -> Void = { cell in
        switch(cell.calculatorButton){
        case .divide, .multiply, .subtract, .add:
            UIView.animate(withDuration: 0.25){
                cell.backgroundColor = .systemOrange
                cell.titleLabel.textColor = .white
            }
        default:
            print("button deselected")
        }
    }
    
    /// restricting nums from being selected
    var shouldBeSselected: (CalcButtonCell) -> Bool = { cell in
        switch(cell.calculatorButton){
        case .number(_), .decimal:
            return false
        default:
            return true
        }
    }
    
    /// it returns sum of two numbers
    var add: (Double, Double) -> Double = { firstNumber, secondNumber in
        return firstNumber + secondNumber
    }
    /// return firstnumber minus secondnumber
    var subtract: (Double, Double) -> Double = { firstNumber, secondNumber in
        return firstNumber - secondNumber
    }
    /// returns multiplication of numbers
    var multiply: (Double, Double) -> Double = { firstNumber, secondNumber in
        return firstNumber * secondNumber
    }
    /// return division of numbers
    var divide: (Double, Double) -> Double = { firstNumber, secondNumber in
        if(secondNumber != 0){
            return firstNumber/secondNumber
        }
        return 0
    }
    /// returns remainder (first num % second num)
    var percentage: (Double, Double) -> Double = { firstNumber, secondNumber in
        if(secondNumber==0){
            return 0
        }
        return firstNumber
            .truncatingRemainder(dividingBy: secondNumber)
    }
}
