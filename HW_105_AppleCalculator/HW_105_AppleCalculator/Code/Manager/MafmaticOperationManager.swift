//
//  MafmaticOperationManager.swift
//  HW_105_AppleCalculator
//
//  Created by Артур Миннушин on 09.10.2023.
//

import Foundation

/// Класс модель для архитектуры mvc
class MafmaticOperationManager {
    
    /// Cllosure для операции сложения
    let plusClosure: (Decimal, Decimal) -> String = { firstEllement, secondeEllemnt in
        return "\(firstEllement + secondeEllemnt)"
    }
    /// Cllosure для операции вычитания
    let minusClosure: (Decimal, Decimal) -> String = { firstEllement, secondeEllemnt in
        return "\(firstEllement - secondeEllemnt)"
    }
    /// Cllosure для операции умножения
    let miltiplactionClosure: (Decimal, Decimal) -> String = { firstEllement, secondeEllemnt in
        return "\(firstEllement * secondeEllemnt)"
    }
    /// Cllosure для операции деления
    let divisionClosure: (Decimal, Decimal) -> String = { firstEllement, secondeEllemnt in
        if secondeEllemnt == 0 {
            return "Ошибка"
        }
        return "\(firstEllement / secondeEllemnt)"
    }
}
