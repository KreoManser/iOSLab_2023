import Foundation

/// CalculatorModel представляет модель калькулятора и управляет его логикой
class CalculatorModel {
    
    /// текущее значение результата вычислений
    var countValue: Double = 0
    
    /// текущая операция ("+", "-", "*", "/")
    var currentOperation = ""
    
    /// флаг, указывающий, что это первое число для операции
    var firstNumber = true
    
    /// создание обьекта класса CalculatorView, который связан с этой моделью
    var calculatorView: CalculatorView

    /// инициализация обьекта класса CalculatorView
    /// - Parameter calculatorView:  вид калькулятора, связанный с моделью
    init(calculatorView: CalculatorView) {
        self.calculatorView = calculatorView
    }
    
    /// closure, вызываемое при нажатии на кнопку сложения
    var sumButtonAction: (() -> Void)?
    /// closure, вызываемое при нажатии на кнопку вычитания
    var minusButtonAction: (() -> Void)?
    /// closure, вызываемое при нажатии на кнопку деления
    var divButtonAction: (() -> Void)?
    /// closure, вызываемое при нажатии на кнопку умножения
    var multButtonAction: (() -> Void)?
    /// closure, вызываемое при нажатии на кнопку равенства
    var equalButtonAction: (() -> Void)?
    /// closure, вызываемое при нажатии на кнопку на кнопку AC (очистить всё)
    var acButtonAction: (() -> Void)?
    /// closure, вызываемое при нажатии на кнопку отмены (очистить ввод, т.е. текущий экран)
    var cancelButtonAction: (() -> Void)?
    
    /// обработчик нажатия на кнопку сложения
    @objc func sumButtonTap() {
        self.sumButtonAction?()
    }
    /// обработчик нажатия на кнопку вычитания
    @objc func minusButtonTap() {
        self.minusButtonAction?()
    }
    /// обработчик нажатия на кнопку деления
    @objc func divButtonTap() {
        self.divButtonAction?()
    }
    /// обработчик нажатия на кнопку умножения
    @objc func multButtonTap() {
        self.multButtonAction?()
    }
    /// обработчик нажатия на кнопку равенства
    @objc func equalButtonTap() {
        self.equalButtonAction?()
    }
    /// обработчик нажатия на кнопку AC (очистить всё)
    @objc func acButtonTap() {
        self.acButtonAction?()
    }
    /// обработчик нажатия на кнопку отмены (очистить ввод, т.е. текущий экран)
    @objc func cancelButtonTap() {
        self.cancelButtonAction?()
    }
    
    /// метод для установки действий кнопок калькулятора
    func setupButtonActions() {
        calculatorView.sumButton.addTarget(self, action: #selector(sumButtonTap), for: .touchUpInside)
        calculatorView.minusButton.addTarget(self, action: #selector(minusButtonTap), for: .touchUpInside)
        calculatorView.divButton.addTarget(self, action: #selector(divButtonTap), for: .touchUpInside)
        calculatorView.multButton.addTarget(self, action: #selector(multButtonTap), for: .touchUpInside)
        calculatorView.equalButton.addTarget(self, action: #selector(equalButtonTap), for: .touchUpInside)
        calculatorView.acButton.addTarget(self, action: #selector(acButtonTap), for: .touchUpInside)
        calculatorView.cancelButton.addTarget(self, action: #selector(cancelButtonTap), for: .touchUpInside)
    }
    
}

