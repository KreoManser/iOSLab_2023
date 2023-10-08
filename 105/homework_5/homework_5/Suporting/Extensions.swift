//
//  Extensions.swift
//  homework_5
//
//  Created by marwa awwad mohamed awwad on 07.10.2023.
//

import Foundation

extension Double{
    /// Converts a Double to an Int.
    var toInt: Int?{
        return Int(self)
    }
}
extension String{
    /// Converts a String to a Double.
    var toDoubel: Double?{
        return Double(self)
    }
}
// Extension on FloatingPoint to check if it's an integer value
extension FloatingPoint{
    /// Checks if the FloatingPoint value is an integer.
    var isInteger: Bool{
        return rounded() == self
    }
}

