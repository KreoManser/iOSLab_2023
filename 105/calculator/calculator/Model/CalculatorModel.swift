import Foundation;

/// Это класс модели, который хранит текущее и предыдущее значения, а также операцию для выполнения.
internal class CalculatorModel {
    /// Текущее значение, используемое в вычислениях.
    private var currentValue: Double = 0.0;
    
    /// Предыдущее значение, сохраненное перед выполнением операции.
    private var previousValue: Double = 0.0;
    
    /// Closure, представляющий операцию для выполнения.
    /// Принимает два аргумента типа Double (предыдущее и текущее значение) и возвращает Double в качестве результата операции.
    private var operation: ((Double, Double) -> Double)?;
    
    /// Устанавливает текущее значение.
    ///
    /// - Parameter value: Значение, которое следует установить.
    func setValue(_ value: Double) {
        currentValue = value;
    }
    
    /// Выполняет операцию и сохраняет ее результат для последующих вычислений.
    ///
    /// - Parameter operation: Closure, представляющий операцию для выполнения.
    func performOperation(operation: @escaping (Double, Double) -> Double) {
        self.operation = operation;
        previousValue = currentValue;
        currentValue = 0.0;
    }
    
    /// Выполняет ранее установленную операцию и возвращает результат.
    ///
    /// - Returns: Результат операции, или nil, если операция не была установлена.
    func calculate() -> Double? {
        guard let operation = operation else {
            return nil;
        }
        return operation(previousValue, currentValue);
    }
}
