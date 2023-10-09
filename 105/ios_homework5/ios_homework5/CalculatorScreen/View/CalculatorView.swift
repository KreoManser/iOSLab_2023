import UIKit

/// View that displays a calculator interface with buttons and operations
class CalculatorView: UIView {
    
    /// Label that displays the current number input or result of calculations
    lazy var NumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 60.0)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    /// Button that inputs number "0"
    lazy var ZeroButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("0", for: .normal)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 30.0
        button.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
        return button
    }()
    
    /// Button that calculates the result of the current operation
    lazy var EqualsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.setTitle("=", for: .normal)
        button.layer.cornerRadius = 30.0
        button.addTarget(self, action: #selector(equalButtonTapped), for: .touchUpInside)
        return button
    }()
    
    /// Button that inputs a decimal point
    lazy var DotButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.setTitle(",", for: .normal)
        button.layer.cornerRadius = 30.0
        button.addTarget(self, action: #selector(decimalButtonTapped), for: .touchUpInside)
        return button
    }()
    
    /// Button that inputs number "1"
    lazy var OneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.setTitle("1", for: .normal)
        button.layer.cornerRadius = 30.0
        button.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
        return button
    }()
    
    /// Button that inputs number "2"
    lazy var TwoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.setTitle("2", for: .normal)
        button.layer.cornerRadius = 30.0
        button.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
        return button
    }()
    
    /// Button that inputs number "3"
    lazy var ThreeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.setTitle("3", for: .normal)
        button.layer.cornerRadius = 30.0
        button.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
        return button
    }()
    
    /// Button that performs the operation of adding two numbers
    lazy var PlusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.setTitle("+", for: .normal)
        button.layer.cornerRadius = 30.0
        button.addTarget(self, action: #selector(operation), for: .touchUpInside)
        return button
    }()
    
    /// Button that inputs number "4"
    lazy var FourButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.setTitle("4", for: .normal)
        button.layer.cornerRadius = 30.0
        button.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
        return button
    }()
    
    /// Button that inputs number "5"
    lazy var FiveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.setTitle("5", for: .normal)
        button.layer.cornerRadius = 30.0
        button.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
        return button
    }()
    
    /// Button that inputs number "6"
    lazy var SixButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.setTitle("6", for: .normal)
        button.layer.cornerRadius = 30.0
        button.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
        return button
    }()
    
    /// Button that performs the operation of subtracting two numbers
    lazy var MinusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.setTitle("-", for: .normal)
        button.layer.cornerRadius = 30.0
        button.addTarget(self, action: #selector(operation), for: .touchUpInside)
        return button
    }()
    
    /// Button that inputs number "7"
    lazy var SevenButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.setTitle("7", for: .normal)
        button.layer.cornerRadius = 30.0
        button.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
        return button
    }()
    
    /// Button that inputs number "8"
    lazy var EightButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.setTitle("8", for: .normal)
        button.layer.cornerRadius = 30.0
        button.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
        return button
    }()
    
    /// Button that inputs number "9"
    lazy var NineButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.setTitle("9", for: .normal)
        button.layer.cornerRadius = 30.0
        button.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
        return button
    }()
    
    /// Button that performs the operation of multiplying two numbers
    lazy var MultiplicationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.setTitle("x", for: .normal)
        button.layer.cornerRadius = 30.0
        button.addTarget(self, action: #selector(operation), for: .touchUpInside)
        return button
    }()
    
    /// Button that clears the calculator and resets any functions
    lazy var AllClearButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("AC", for: .normal)
        button.layer.cornerRadius = 30.0
        button.backgroundColor = .lightGray
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(clearAll), for: .touchUpInside)
        return button
    }()
    
    lazy var PlusAndMinusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .lightGray
        button.setTitle("+/-", for: .normal)
        button.layer.cornerRadius = 30.0
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var PercentButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .lightGray
        button.setTitle("%", for: .normal)
        button.layer.cornerRadius = 30.0
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    /// Button that performs the operation of dividing two numbers
    lazy var DivisionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.setTitle("÷", for: .normal)
        button.layer.cornerRadius = 30.0
        button.addTarget(self, action: #selector(operation), for: .touchUpInside)
        return button
    }()
  
    var firstNumber = String()
    var secondNumber = String()
    var lastNumber = String()
    var keyPressed = String()
    var isTypingNumber: Bool = false
    var operationTapped = String()
    var isOperationTapped: Bool = false
    var previousOperator = String()
    var midAnswer = Double()
    
    /// Func that inputs the number from 1 to 9
    /// - Parameter sender: button of number from 1 to 9
    @objc func numberButtonTapped(_ sender: UIButton) {
        let keyPressed = sender.currentTitle!
        if let lastDigit = lastNumber.last, String(lastDigit) == keyPressed {
            lastNumber += keyPressed
        } else {
            if lastNumber == "0" {
                lastNumber = keyPressed
            } else {
                lastNumber += keyPressed
            }
        }
        NumberLabel.text = lastNumber
    }
    
    /// Func that inputs a decimal point
    /// - Parameter sender: "," button
    @objc func decimalButtonTapped(_ sender: UIButton) {
        if !lastNumber.contains(".") {
            lastNumber += "."
            NumberLabel.text = lastNumber
        }
    }
    
    /// Func hat implements the operation of addition, subtraction, multiplication and division
    /// - Parameter sender: "+", "-", "x", "÷" button
    @objc func operation(_ sender: UIButton) {
        if (!isOperationTapped) {
            firstNumber = lastNumber
            lastNumber = "0"
            isTypingNumber = true
            isOperationTapped = true
            operationTapped = sender.currentTitle!
            NumberLabel.text = firstNumber
            previousOperator = operationTapped

        } else {
            if (previousOperator == "+") {
                midAnswer = Double(firstNumber)! + Double(lastNumber)!
            }
            else if (previousOperator == "-") {
                midAnswer = Double(firstNumber)! - Double(lastNumber)!
            }
            else if (previousOperator == "x") {
                midAnswer = Double(firstNumber)! * Double(lastNumber)!
            }
            else if (previousOperator == "/") {
                 midAnswer = Double(firstNumber)! / Double(lastNumber)!
            }

            firstNumber = String(midAnswer)
            lastNumber = "0"
            operationTapped = sender.currentTitle!
            previousOperator = operationTapped
            NumberLabel.text = firstNumber
        }
    }
    
    /// Func that calculates the result of the current operation
    /// - Parameter sender: "=" button
    @objc func equalButtonTapped(_ sender: UIButton) {
        var result: Double = 0.0

        secondNumber = lastNumber

        if (operationTapped == "+") {

            result = Double(firstNumber)! + Double(secondNumber)!
            if result == round(result) {
                NumberLabel.text = String(format: "%.0f", result)
            } else {
                NumberLabel.text = String(format: "%.2f", result).trimmingCharacters(in: ["0", "."])
            }
        }
        else if (operationTapped == "-") {

            result = Double(firstNumber)! - Double(secondNumber)!
            if result == round(result) {
                NumberLabel.text = String(format: "%.0f", result)
            } else {
                NumberLabel.text = String(format: "%.2f", result).trimmingCharacters(in: ["0", "."])
            }
        }
        else if (operationTapped == "x") {

            result = Double(firstNumber)! * Double(secondNumber)!
            if result == round(result) {
                NumberLabel.text = String(format: "%.0f", result)
            } else {
                NumberLabel.text = String(format: "%.2f", result).trimmingCharacters(in: ["0", "."])
            }
        }
        else if (operationTapped == "÷") {
            result = Double(firstNumber)! / Double(secondNumber)!
            if result == round(result) {
                NumberLabel.text = String(format: "%.0f", result)
            } else {
                NumberLabel.text = String(format: "%.2f", result).trimmingCharacters(in: ["0", "."])
            }
        }

        lastNumber = String(result)
        isOperationTapped = false
    }
    
    /// Func that clears the calculator and resets any functions
    /// - Parameter sender: "AC" button
    @objc func clearAll(_ sender: UIButton) {
        firstNumber = "0"
        secondNumber = "0"
        lastNumber = "0"
        isTypingNumber = false
        isOperationTapped = false
        NumberLabel.text = "0"
    }
                       
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(NumberLabel)
        addSubview(ZeroButton)
        addSubview(DotButton)
        addSubview(EqualsButton)
        addSubview(OneButton)
        addSubview(TwoButton)
        addSubview(ThreeButton)
        addSubview(PlusButton)
        addSubview(FourButton)
        addSubview(FiveButton)
        addSubview(SixButton)
        addSubview(MinusButton)
        addSubview(SevenButton)
        addSubview(EightButton)
        addSubview(NineButton)
        addSubview(MultiplicationButton)
        addSubview(AllClearButton)
        addSubview(PlusAndMinusButton)
        addSubview(PercentButton)
        addSubview(DivisionButton)
        
    }
    
    /// Func that sets up the layout constraints for the subviews of the CalculatorView
    /// - Parameter view: CalculatorView
    func setupLayout(view: UIView){
        
        NSLayoutConstraint.activate([
            
            NumberLabel.bottomAnchor.constraint(equalTo: DivisionButton.topAnchor, constant: -25),
            NumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            NumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            NumberLabel.heightAnchor.constraint(equalToConstant: 70),
            
            ZeroButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            ZeroButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            //ZeroButton.widthAnchor.constraint(equalToConstant: 85),
            ZeroButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.37),
            ZeroButton.heightAnchor.constraint(equalToConstant: 60),
            
            DotButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            DotButton.trailingAnchor.constraint(equalTo: EqualsButton.leadingAnchor, constant: -25),
            DotButton.leadingAnchor.constraint(equalTo: ZeroButton.trailingAnchor, constant: 25),
            DotButton.widthAnchor.constraint(equalToConstant: 60),
            DotButton.heightAnchor.constraint(equalToConstant: 60),
            
            EqualsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            EqualsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            EqualsButton.widthAnchor.constraint(equalToConstant: 60),
            EqualsButton.heightAnchor.constraint(equalToConstant: 60),
            
            OneButton.bottomAnchor.constraint(equalTo: ZeroButton.topAnchor, constant: -15),
            OneButton.leadingAnchor.constraint(equalTo: ZeroButton.leadingAnchor),
            OneButton.widthAnchor.constraint(equalToConstant: 60),
            OneButton.heightAnchor.constraint(equalToConstant: 60),
            
            TwoButton.bottomAnchor.constraint(equalTo: ZeroButton.topAnchor, constant: -15),
            TwoButton.trailingAnchor.constraint(equalTo: ZeroButton.trailingAnchor),
            TwoButton.widthAnchor.constraint(equalToConstant: 60),
            TwoButton.heightAnchor.constraint(equalToConstant: 60),
            
            ThreeButton.bottomAnchor.constraint(equalTo: ZeroButton.topAnchor, constant: -15),
            ThreeButton.trailingAnchor.constraint(equalTo: PlusButton.leadingAnchor, constant: -25),
            ThreeButton.leadingAnchor.constraint(equalTo: TwoButton.trailingAnchor, constant: 25),
            ThreeButton.widthAnchor.constraint(equalToConstant: 60),
            ThreeButton.heightAnchor.constraint(equalToConstant: 60),
            
            PlusButton.bottomAnchor.constraint(equalTo: ZeroButton.topAnchor, constant: -15),
            PlusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            PlusButton.widthAnchor.constraint(equalToConstant: 60),
            PlusButton.heightAnchor.constraint(equalToConstant: 60),
            
            FourButton.bottomAnchor.constraint(equalTo: OneButton.topAnchor, constant: -15),
            FourButton.leadingAnchor.constraint(equalTo: OneButton.leadingAnchor),
            FourButton.widthAnchor.constraint(equalToConstant: 60),
            FourButton.heightAnchor.constraint(equalToConstant: 60),
            
            FiveButton.bottomAnchor.constraint(equalTo: OneButton.topAnchor, constant: -15),
            FiveButton.trailingAnchor.constraint(equalTo: ZeroButton.trailingAnchor),
            FiveButton.widthAnchor.constraint(equalToConstant: 60),
            FiveButton.heightAnchor.constraint(equalToConstant: 60),
            
            SixButton.bottomAnchor.constraint(equalTo: OneButton.topAnchor, constant: -15),
            SixButton.trailingAnchor.constraint(equalTo: MinusButton.leadingAnchor, constant: -25),
            SixButton.leadingAnchor.constraint(equalTo: TwoButton.trailingAnchor, constant: 25),
            SixButton.widthAnchor.constraint(equalToConstant: 60),
            SixButton.heightAnchor.constraint(equalToConstant: 60),
            
            MinusButton.bottomAnchor.constraint(equalTo: OneButton.topAnchor, constant: -15),
            MinusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            MinusButton.widthAnchor.constraint(equalToConstant: 60),
            MinusButton.heightAnchor.constraint(equalToConstant: 60),
            
            SevenButton.bottomAnchor.constraint(equalTo: FourButton.topAnchor, constant: -15),
            SevenButton.leadingAnchor.constraint(equalTo: FourButton.leadingAnchor),
            SevenButton.widthAnchor.constraint(equalToConstant: 60),
            SevenButton.heightAnchor.constraint(equalToConstant: 60),
            
            EightButton.bottomAnchor.constraint(equalTo: FourButton.topAnchor, constant: -15),
            EightButton.trailingAnchor.constraint(equalTo: FiveButton.trailingAnchor),
            EightButton.widthAnchor.constraint(equalToConstant: 60),
            EightButton.heightAnchor.constraint(equalToConstant: 60),
            
            NineButton.bottomAnchor.constraint(equalTo: FourButton.topAnchor, constant: -15),
            NineButton.trailingAnchor.constraint(equalTo: MultiplicationButton.leadingAnchor, constant: -25),
            NineButton.leadingAnchor.constraint(equalTo: EightButton.trailingAnchor, constant: 25),
            NineButton.widthAnchor.constraint(equalToConstant: 60),
            NineButton.heightAnchor.constraint(equalToConstant: 60),
            
            MultiplicationButton.bottomAnchor.constraint(equalTo: FourButton.topAnchor, constant: -15),
            MultiplicationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            MultiplicationButton.widthAnchor.constraint(equalToConstant: 60),
            MultiplicationButton.heightAnchor.constraint(equalToConstant: 60),
            
            AllClearButton.bottomAnchor.constraint(equalTo: SevenButton.topAnchor, constant: -15),
            AllClearButton.leadingAnchor.constraint(equalTo: SevenButton.leadingAnchor),
            AllClearButton.widthAnchor.constraint(equalToConstant: 60),
            AllClearButton.heightAnchor.constraint(equalToConstant: 60),
            
            PlusAndMinusButton.bottomAnchor.constraint(equalTo: SevenButton.topAnchor, constant: -15),
            PlusAndMinusButton.trailingAnchor.constraint(equalTo: EightButton.trailingAnchor),
            PlusAndMinusButton.widthAnchor.constraint(equalToConstant: 60),
            PlusAndMinusButton.heightAnchor.constraint(equalToConstant: 60),
            
            PercentButton.bottomAnchor.constraint(equalTo: SevenButton.topAnchor, constant: -15),
            PercentButton.trailingAnchor.constraint(equalTo: DivisionButton.leadingAnchor, constant: -25),
            PercentButton.leadingAnchor.constraint(equalTo: PlusAndMinusButton.trailingAnchor, constant: 25),
            PercentButton.widthAnchor.constraint(equalToConstant: 60),
            PercentButton.heightAnchor.constraint(equalToConstant: 60),
            
            DivisionButton.bottomAnchor.constraint(equalTo: SevenButton.topAnchor, constant: -15),
            DivisionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            DivisionButton.widthAnchor.constraint(equalToConstant: 60),
            DivisionButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
