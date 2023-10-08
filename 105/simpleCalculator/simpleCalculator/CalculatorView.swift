import UIKit

/// CalculatorView - это пользовательский вид, который представляет калькулятор и содержит кнопки и текстовое поле
class CalculatorView: UIView, UITextFieldDelegate {
    
    /// кнопка "Очистить все" (AC)
    lazy var acButton: UIButton = {
        let button = UIButton()
        button.setTitle("AC", for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    /// текстовое поле для ввода чисел
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .bezel
        textField.placeholder = "Введите число"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    /// кнопка для сложения
    lazy var sumButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    /// кнопка для разности
    lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    /// кнопка для деления
    lazy var divButton: UIButton = {
        let button = UIButton()
        button.setTitle("/", for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    /// кнопка для умножения
    lazy var multButton: UIButton = {
        let button = UIButton()
        button.setTitle("*", for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    /// кнопка для равенства
    lazy var equalButton: UIButton = {
        let button = UIButton()
        button.setTitle("=", for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    /// кнопка для отмены (очистить ввод, т.е. текущий экран)
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("C", for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    /// стек кнопок арифметических операций
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [acButton, sumButton, minusButton, divButton, multButton, equalButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    
    /// инициализатор для CalculatorView
    /// - Parameter frame: область, в которой будет отображаться CalculatorView
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        изменение цвета экрана
        backgroundColor = .white
        
//        добавление на экран кнопок и текстового поля для чисел
        addSubview(inputTextField)
        addSubview(buttonStackView)
        addSubview(cancelButton)
        
//        массив для активации constraint-ов
        NSLayoutConstraint.activate([
            
            inputTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            inputTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            inputTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            inputTextField.heightAnchor.constraint(equalToConstant: 100),

            buttonStackView.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 5),
            buttonStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            buttonStackView.heightAnchor.constraint(equalToConstant: 50),
            
            cancelButton.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 5),
            cancelButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: acButton.trailingAnchor),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
        
    }
    
    /// инициализатор для ошибки
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
