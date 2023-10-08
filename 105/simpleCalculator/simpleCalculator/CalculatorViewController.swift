import UIKit

/// CalculatorViewController класс, контролирующий взаимодействия классов calculatorView и calculatorModel
class CalculatorViewController: UIViewController {
    
    /// создаение обьектов двух классов: calculatorView и calculatorModel
    lazy var calculatorView: CalculatorView = CalculatorView(frame: .zero)
    lazy var calculatorModel: CalculatorModel = CalculatorModel(calculatorView: calculatorView)
    
    /// установка вместо дефолтного view созданный calculatorView
    override func loadView() {
        view = calculatorView
    }
    
    /// инициализация методов и обьектов
    override func viewDidLoad() {
        super.viewDidLoad()
        
//       инициализация кнопок и их действий
        calculatorModel.setupButtonActions()
        
//       closure, действие при нажатии на кнопку сложения
        calculatorModel.sumButtonAction = { [weak self] in
            guard let self else { return }
            
            if let inputNumber = Double(self.calculatorView.inputTextField.text ?? "0") {
                self.calculatorModel.countValue += inputNumber
                self.calculatorView.inputTextField.text = ""
                self.calculatorModel.currentOperation = "+"
                self.calculatorModel.firstNumber = false
            }
        }
//        closure, действие при нажатии на кнопку вычитания
        calculatorModel.minusButtonAction = { [weak self] in
            guard let self else { return }
            
            if let inputNumber = Double(self.calculatorView.inputTextField.text ?? "0") {
                if self.calculatorModel.firstNumber {
                    self.calculatorModel.countValue = inputNumber
                    self.calculatorModel.firstNumber = false
                } else {
                    self.calculatorModel.countValue -= inputNumber
                }
                self.calculatorView.inputTextField.text = ""
                self.calculatorModel.currentOperation = "-"
            }
        }
//        closure, действие при нажатии на кнопку деления
        calculatorModel.divButtonAction = { [weak self] in
            guard let self else { return }
            
            if let inputNumber = Double(self.calculatorView.inputTextField.text ?? "0"), inputNumber != 0 {
                if self.calculatorModel.firstNumber {
                    self.calculatorModel.countValue = inputNumber
                    self.calculatorModel.firstNumber = false
                } else {
                    self.calculatorModel.countValue /= inputNumber
                }
                self.calculatorView.inputTextField.text = ""
                self.calculatorModel.currentOperation = "/"
            } else {
                self.calculatorView.inputTextField.text = "Не определено"
            }
        }
//        closure, действие при нажатии на кнопку умножения
        calculatorModel.multButtonAction = { [weak self] in
            guard let self else { return }
            
            if let inputNumber = Double(self.calculatorView.inputTextField.text ?? "0") {
                if self.calculatorModel.firstNumber {
                    self.calculatorModel.countValue = inputNumber
                    self.calculatorModel.firstNumber = false
                } else {
                    self.calculatorModel.countValue *= inputNumber
                }
                self.calculatorView.inputTextField.text = ""
                self.calculatorModel.currentOperation = "*"
            }
        }
//        closure, действие при нажатии на кнопку равенства
        calculatorModel.equalButtonAction = { [weak self] in
            guard let self else { return }
            
            if let inputNumber = Double(self.calculatorView.inputTextField.text ?? "0") {
                switch self.calculatorModel.currentOperation {
                case "+":
                    self.calculatorModel.countValue += inputNumber
                case "-":
                    self.calculatorModel.countValue -= inputNumber
                case "*":
                    self.calculatorModel.countValue *= inputNumber
                case "/":
                    if inputNumber != 0 {
                        self.calculatorModel.countValue /= inputNumber
                    } else {
                        self.calculatorView.inputTextField.text = "Не определено"
                    }
                default:
                    break
                }
                self.calculatorView.inputTextField.text = String(self.calculatorModel.countValue)
                self.calculatorModel.firstNumber = true
            }
        }
//        closure, действие при нажатии на кнопку AC (очистить всё)
        calculatorModel.acButtonAction = { [weak self] in
            guard let self else { return }
            
            self.calculatorModel.countValue = 0
            self.calculatorModel.firstNumber = true
            self.calculatorView.inputTextField.text = ""
        }
//        closure, действие при нажатии на кнопку отмены (очистить ввод, т.е. текущий экран)
        calculatorModel.cancelButtonAction = { [weak self] in
            guard let self else { return }
            self.calculatorView.inputTextField.text = ""
        }
        
    }
    
}
    
 
