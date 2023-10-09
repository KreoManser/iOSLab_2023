import Foundation

struct CalculatorModel {
    /// Closure of two numbers sum action
    let sumAction: (Decimal, Decimal) -> String = { firstNumb, secondNumb in
        return String(describing: firstNumb + secondNumb)
    }
    
    /// Closure of two numbers difference action
    let diffAction: (Decimal, Decimal) -> String = { firstNumb, secondNumb in
        return String(describing: firstNumb - secondNumb)
    }
    
    /// Closure of two numbers multiply action
    let multAction: (Decimal, Decimal) -> String = { firstNumb, secondNumb in
        return String(describing: firstNumb * secondNumb)
    }
    
    /// Closure of two numbers divide action
    let divAction: (Decimal, Decimal) -> String = { firstNumb, secondNumb in
        return String(describing: firstNumb / secondNumb)
    }
}
