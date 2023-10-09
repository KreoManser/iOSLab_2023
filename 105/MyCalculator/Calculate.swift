//
//  Calculate.swift
//  MyCalculator
//
//  Created by Ruslan Kozlov on 08.10.2023.
//

import Foundation
import UIKit


class Calculate {
    
    var onOperationPerformed: ((Int, Int) -> Int)?
        
    func performAddition(operand1: Int, operand2: Int) -> Int {
        
        if let operation = onOperationPerformed {
            return operation(operand1, operand2)
        }
        return 0
    }
}
