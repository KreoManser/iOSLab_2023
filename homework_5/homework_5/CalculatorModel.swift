import Foundation

class CalculatorOperations {
    private var previousValue = 0
    private var value: String = "0"
    private var currentOperation: String?

    public var performOperation: ((String) -> Void)?
    public var appendDigit: ((String) -> Void)?
    public var clear: (() -> Void)?
    public var getResult: (() -> String)?

    init() {
        // Замыкание для добавления цифры к текущему значению
        appendDigit = { [weak self] digit in
            if self?.value == "0" {
                self?.value = digit
            } else {
                self?.value = "\(self?.value ?? "")\(digit)"
            }
        }

        // Замыкание для выполнения операции
        self.performOperation = { [weak self] operation in
            switch operation {
            case "+", "-", "x", "/":
                // Установка текущей операции и сохранение предыдущего значения
                self?.currentOperation = operation
                self?.previousValue = Int(self?.value ?? "0") ?? 0
                self?.value = "0"
                
            case "AC":
                // Очистка текущего значения
                self?.clear?()
                
            case "%":
                // Расчет процентов
                var percentValue: Double = 0
                
                if let currentValue = Double(self?.value ?? "0") {
                    if Double(self!.previousValue) == 0 {
                        percentValue = (currentValue / 100)
                    } else {
                        percentValue = (Double(self?.previousValue ?? 0) * (currentValue / 100))
                    }

                    self?.value = String(percentValue)
                }
                
            case "=":
                // Выполнение операции равно и расчет результата
                let currentValue = Double(self?.value ?? "0") ?? 0
                switch self?.currentOperation {
                case "+":
                    self?.value = "\(Double(self?.previousValue ?? 0) + currentValue)"
                    
                case "-":
                    self?.value = "\(Double(self?.previousValue ?? 0) - currentValue)"
                    
                case "x":
                    self?.value = "\(Double(self?.previousValue ?? 0) * currentValue)"
                    
                case "/":
                    if currentValue == 0 {
                        self?.value = "Error: division by zero"
                    } else {
                        self?.value = "\(Double(self?.previousValue ?? 0) / currentValue)"
                    }
                    
                default:
                    break
                }
                
            case "+/-":
                // Смена знака текущего значения
               if let currentValue = Int(self?.value ?? "0") {
                   self?.value = String(-currentValue)
               }
                
            default:
                break
            }
        }

        // Замыкание для очистки текущего значения
        self.clear = { [weak self] in
            self?.value = "0"
        }

        // Замыкание для получения текущего значения
        self.getResult = { [weak self] in
            return self?.value ?? "0"
        }
    }
}
