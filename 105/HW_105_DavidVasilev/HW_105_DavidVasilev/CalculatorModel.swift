import Foundation
class CalculatorModel{
    
    let addition : (Double, Double) -> String = {firstValue,secondValue in
        var result = firstValue + secondValue
        return typeDefinition(result: result)
    }
    
    let substraction : (Double, Double) -> String = {firstValue,secondValue in
        var result = firstValue - secondValue
        return typeDefinition(result: result)
    }
    
    let division : (Double, Double) -> String = {firstValue,secondValue in
        var result = firstValue / secondValue
        return typeDefinition(result: result)
    }
    
    let multiplication : (Double, Double) -> String = {firstValue,secondValue in
        var result = firstValue * secondValue
        return typeDefinition(result: result)
    }
    /// closure  definition type for using outside this class
    let type : (Double) -> String = { result in
        return typeDefinition(result: result)
    }
    ///removes digits after the decimal point if the number is an integer
    static func typeDefinition(result: Double) -> String {
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(result))
        } else {
            return String(result)
        }
    }
}
