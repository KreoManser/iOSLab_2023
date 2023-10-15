import UIKit

// Класс (View), отвечающий за отображение
class CalculateView: UIView {
    
    // Слабая ссылка на контроллер
    weak var calculatorController: CalculatorViewController?
    
    // Замыкание для обновления resultLabel
    lazy var updateResultLabel: (String) -> Void = { [weak self] result in
        self?.resultLabel.text = result
    }
    
    // Метка для отображения результата
    lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 85, weight: .light)
        label.text = "0"
        label.textAlignment = .right
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // Конфигурация и создание кнопки "AC"
    lazy var clearButton: UIButton = {
        let action = UIAction { _ in
            self.calculatorController?.operatorButtonPressed("AC")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "AC")
        button.backgroundColor = .lightGray
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    // Конфигурация и создание кнопки "+/-"
    lazy var plusAndMinusButton: UIButton = {
        let action = UIAction { _ in
            self.calculatorController?.operatorButtonPressed("+/-")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "+/-")
        button.backgroundColor = .lightGray
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    // Конфигурация и создание кнопки "%"
    lazy var percentButton: UIButton = {
        let action = UIAction { _ in
            self.calculatorController?.operatorButtonPressed("%")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "%")
        button.backgroundColor = .lightGray
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    // Конфигурация и создание кнопки "/"
    lazy var divisionButton: UIButton = {
        let action = UIAction { _ in
            self.calculatorController?.operatorButtonPressed("/")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "/")
        button.backgroundColor = .orange
        return button
    }()
    
    // Конфигурация и создание кнопки "x"
    lazy var multiplyButton: UIButton = {
        let action = UIAction { _ in
            self.calculatorController?.operatorButtonPressed("x")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "x")
        button.backgroundColor = .orange
        return button
    }()
    
    // Конфигурация и создание кнопки "+"
    lazy var addiButton: UIButton = {
        let action = UIAction { _ in
            self.calculatorController?.operatorButtonPressed("+")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "+")
        button.backgroundColor = .orange
        return button
    }()
    
    // Конфигурация и создание кнопки "-"
    lazy var subtractButton: UIButton = {
        let action = UIAction { _ in
            self.calculatorController?.operatorButtonPressed("-")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "-")
        button.backgroundColor = .orange
        return button
    }()
    
    // Конфигурация и создание кнопки "="
    lazy var equalButton: UIButton = {
        let action = UIAction { _ in
            self.calculatorController?.operatorButtonPressed("=")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "=")
        button.backgroundColor = .orange
        return button
    }()
    
    // Конфигурация и создание кнопки "1"
    lazy var oneButton: UIButton = {
        let action = UIAction { _ in
            self.calculatorController?.digitButtonPressed("1")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "1")
        button.backgroundColor = .darkGray
        return button
    }()
    
    // Конфигурация и создание кнопки "2"
    lazy var twoButton: UIButton = {
        let action = UIAction { _ in
            self.calculatorController?.digitButtonPressed("2")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "2")
        button.backgroundColor = .darkGray
        return button
    }()
    
    // Конфигурация и создание кнопки "3"
    lazy var threeButton: UIButton = {
        let action = UIAction { _ in
            self.calculatorController?.digitButtonPressed("3")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "3")
        button.backgroundColor = .darkGray
        return button
    }()
    
    // Конфигурация и создание кнопки "4"
    lazy var fourButton: UIButton = {
        let action = UIAction { _ in
            self.calculatorController?.digitButtonPressed("4")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "4")
        button.backgroundColor = .darkGray
        return button
    }()
    
    // Конфигурация и создание кнопки "5"
    lazy var fiveButton: UIButton = {
        let action = UIAction { _ in
            self.calculatorController?.digitButtonPressed("5")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "5")
        button.backgroundColor = .darkGray
        return button
    }()
    
    // Конфигурация и создание кнопки "6"
    lazy var sixButton: UIButton = {
        let action = UIAction { _ in
            self.calculatorController?.digitButtonPressed("6")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "6")
        button.backgroundColor = .darkGray
        return button
    }()
    
    // Конфигурация и создание кнопки "7"
    lazy var sevenButton: UIButton = {
        let action = UIAction { _ in
            self.calculatorController?.digitButtonPressed("7")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "7")
        button.backgroundColor = .darkGray
        return button
    }()
    
    // Конфигурация и создание кнопки "8"
    lazy var eightButton: UIButton = {
        let action = UIAction { _ in
            self.calculatorController?.digitButtonPressed("8")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "8")
        button.backgroundColor = .darkGray
        return button
    }()
    
    // Конфигурация и создание кнопки "9"
    lazy var nineButton: UIButton = {
        let action = UIAction { _ in
            self.calculatorController?.digitButtonPressed("9")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "9")
        button.backgroundColor = .darkGray
        return button
    }()
    
    // Конфигурация и создание кнопки "0"
    lazy var zeroButton: UIButton = {
           let action = UIAction { _ in
               self.calculatorController?.digitButtonPressed("0")
           }
           let button = UIButton(primaryAction: action)
           button.setTitle("0", for: .normal)
           button.backgroundColor = .darkGray
           button.translatesAutoresizingMaskIntoConstraints = false
           button.widthAnchor.constraint(equalToConstant: 160).isActive = true
           button.layer.cornerRadius = 40
           button.setTitleColor(.white, for: .normal)
           button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
           button.contentHorizontalAlignment = .left
           button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
           return button
       }()
    
    // Конфигурация и создание кнопки ","
    lazy var commaButton: UIButton = {
        let action = UIAction { _ in
            self.calculatorController?.digitButtonPressed(",")
        }
        
        let button = UIButton(primaryAction: action)
        configureButton(button, ",")
        button.backgroundColor = .darkGray
        return button
    }()
    
    // Инициализатор
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black

        // Создание и конфигурация горизонтальных стеков для кнопок
        let buttonRow1 = UIStackView(arrangedSubviews: [
            clearButton, plusAndMinusButton, percentButton, divisionButton
        ])
        configureForStackViewButtonHorizontal(buttonRow1)

        let buttonRow2 = UIStackView(arrangedSubviews: [
            sevenButton, eightButton, nineButton, multiplyButton
        ])
        configureForStackViewButtonHorizontal(buttonRow2)

        let buttonRow3 = UIStackView(arrangedSubviews: [
            fourButton, fiveButton, sixButton, subtractButton
        ])
        configureForStackViewButtonHorizontal(buttonRow3)

        let buttonRow4 = UIStackView(arrangedSubviews: [
            oneButton, twoButton, threeButton, addiButton
        ])
        configureForStackViewButtonHorizontal(buttonRow4)

        let buttonRow5 = UIStackView(arrangedSubviews: [
            zeroButton, commaButton, equalButton
        ])
        configureForStackViewButtonHorizontal(buttonRow5)

        // Создание главного вертикального стека
        let mainStackView = UIStackView(arrangedSubviews: [
            resultLabel, buttonRow1, buttonRow2, buttonRow3, buttonRow4, buttonRow5
        ])

        mainStackView.axis = .vertical
        mainStackView.spacing = 15
        mainStackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(mainStackView)

        NSLayoutConstraint.activate([
            mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
        ])
    }
    
    // Конфигурация кнопок
    private var configureButton: (UIButton, String) -> Void = { button, symbol in
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(symbol, for: .normal)
        let buttonSize: CGFloat = 80
        button.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        button.layer.cornerRadius = buttonSize / 2
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.setTitleColor(.white, for: .normal)
    }

    // Конфигурация горизонтальных стеков для кнопок
    private var configureForStackViewButtonHorizontal: (UIStackView) -> Void  = { stackView in
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 15
    }
    
    // Инициализатор, не используется в данном контексте
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Функция для обновления текста в resultLabel
    func updateResultLabel(_ result: String) {
        resultLabel.text = "\(result)"
    }
}
