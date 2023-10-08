//
//  CalculatorOperation.swift
//  homework_5
//
//  Created by marwa awwad mohamed awwad on 07.10.2023.
//

import Foundation

/// Enum defining basic calculator operations
enum CalculatorOperation  {
    case divide
    case multiply
    case subtract
    case add
   
     /// Get the title representation of the operation/
    var title: String{
        switch self{
            
        case .divide:
            return "/"
        case .multiply:
            return "x"
        case .subtract:
            return "-"
        case .add:
            return "+"
            
    
        }
    } 
}
