//
//  CalculatorButton.swift
//  homework_5
//
//  Created by marwa awwad mohamed awwad on 07.10.2023.
//

import Foundation
import UIKit

/// Enum defining different types of calculator buttons
enum CalculatorButton {
    
    case allCelear
    case plusMinus
    case persentage
    case divide
    case multiply
     case subtract
    case add
    case equal
    case number(Int)
    case decimal
 
    
    /// Initializer to handle the button type/
    init(calcButton: CalculatorButton){
        switch calcButton{
            
        case .allCelear,.plusMinus,.persentage,.divide,.multiply,.subtract,.add, .equal, .decimal:
            self = calcButton
            
        case .number(let int ):
            if int.description.count == 1 {
                self = calcButton
            }else{
                fatalError ("CalculatorButton. number Int was not 1 digit during init")
            }
      
        }
    }
  
}
/// Extension to provide properties for button title and colors
extension CalculatorButton {
    var title: String{
        switch self{
            
        case .allCelear:
            return "AC"
        case .plusMinus:
            return "+/-"
        case .persentage:
            return "%"
        case .divide:
            return "/"
        case .multiply:
            return "x"
        case .subtract:
            return "-"
        case .add:
            return "+"
        case .equal:
            return "="
        case .number(let int ):
            return int.description
        case .decimal:
            return "."
        }
    }
    /// Get the color associated with the button/
    var color: UIColor{
        
        switch self{
        case .allCelear , .plusMinus, .persentage:
            return .lightGray
        case .divide , .multiply , .subtract , .add , .equal:
            return .systemOrange
            
        case .number, .decimal:
            return .darkGray
            

    
        }
    }
    /// Get the selected color for the button (if applicable)
    var selectedColor: UIColor? {
        switch self {
        case .allCelear , .plusMinus, .persentage, .equal, .number, .decimal:
            return nil
        case .divide , .multiply , .subtract , .add :
            return .white
        
        }
    }
}
