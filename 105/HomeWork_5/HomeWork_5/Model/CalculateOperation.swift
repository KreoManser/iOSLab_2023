//
//  CalculateOperation.swift
//  HomeWork_5
//
//  Created by Нияз Ризванов on 08.10.2023.
//

import Foundation

/// Здесь написана вся логика
class CalculateOperation {
    /// Поле для сохранения значений
    private var previousValue = 0
    /// Результируещее поле для resultLabel
    private var value: String = "0"
    /// Поле для созранения названия операции
    private var curentOperation: String?
    
    /// Замыкание для выполнения операции
    public var performOperation: ((String) -> Void)?
    
    /// Замыкание для добавления цифры
    public var appendDigit: ((String) -> Void)?
    
    /// Замыкание для очистки
    public var clear: (() -> Void)?
    
    /// Замыкание для получения результата
    public var getResult: (() -> String)?
    
    /// Инициализация замыканий
    init() {
        
        appendDigit = { [weak self] digit in
            if self?.value == "0" {
                self?.value = digit
            } else {
                self?.value = "\(self?.value ?? "")\(digit)"
            }
        }
        
        self.performOperation = { [weak self] operation in
            switch operation {
            case "+", "-", "x", "/":
                self?.curentOperation = operation
                self?.previousValue = Int(self?.value ?? "0") ?? 0
                self?.value = "0"
            case "AC":
                self?.clear?()
            case "=":
                let currentValue = Int(self?.value ?? "0") ?? 0
                if self?.curentOperation == "+" {
                    self?.value = "\((self?.previousValue ?? 0) + currentValue)"
                } else if self?.curentOperation == "-" {
                    self?.value = "\((self?.previousValue ?? 0) - currentValue)"
                } else if self?.curentOperation == "x" {
                    self?.value = "\((self?.previousValue ?? 0) * currentValue)"
                } else if self?.curentOperation == "/" {
                    if currentValue == 0 {
                        self?.value = "Error: division by zero "
                    } else {
                        self?.value = "\((self?.previousValue ?? 0) / currentValue)"
                    }
                }
            default:
                break
            }
        }
        
         self.clear = { [weak self] in
            self?.value = "0"
        }
        
        self.getResult = {[weak self] in
            return self?.value ?? "0"
        }
    }

}
