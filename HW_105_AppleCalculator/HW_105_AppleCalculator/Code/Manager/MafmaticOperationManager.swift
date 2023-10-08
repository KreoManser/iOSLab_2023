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
    let plusClosure: (Int, Int) -> Int = { firstEllement, SecondeEllemnt in
        return firstEllement + SecondeEllemnt
    }
    /// Cllosure для операции вычитания
    let minusClosure: (Int, Int) -> Int = { firstEllement, SecondeEllemnt in
        return firstEllement - SecondeEllemnt
    }
    /// Cllosure для операции умножения
    let miltiplactionClosure: (Int, Int) -> Int = { firstEllement, SecondeEllemnt in
        return firstEllement * SecondeEllemnt
    }
    /// Cllosure для операции деления
    let divisionClosure: (Int, Int) -> Int = { firstEllement, SecondeEllemnt in
        return firstEllement / SecondeEllemnt
    }
}
