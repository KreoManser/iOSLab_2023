//
//  ViewController.swift
//  AppleCalculator
//
//  Created by Faki Doosuur Doris on 07.10.2023.
//

import UIKit

class CalculatorViewController: UIViewController {
    //using MVC approach
    let calculatorModel = CalculatorModel()
    ///Label to display the current result of the calculator
    private lazy var myLabel: UILabel = {
        let someView = UILabel()
        someView.textAlignment = .justified
        someView.textColor = .white
        someView.text = "0"
        someView.font = UIFont.boldSystemFont(ofSize: 36)
        someView.backgroundColor = .systemPink
        someView.translatesAutoresizingMaskIntoConstraints = false
        return someView
    }()
    ///variable which is going to label to display current input and the current result.
    private var currentInput: String = ""
    
    ///Button varaibles for digits.
    private lazy var button1: UIButton = {
        let someView = UIButton()
        someView.setTitle("1", for: .normal)
        someView.setTitleColor(.black, for: .normal)
        someView.backgroundColor = .systemGray5
        someView.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        someView.translatesAutoresizingMaskIntoConstraints = false
        return someView
    }()
    private lazy var button2: UIButton = {
        let someView = UIButton()
        someView.setTitle("2", for: .normal)
        someView.setTitleColor(.black, for: .normal)
        someView.backgroundColor = .white
        someView.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        someView.translatesAutoresizingMaskIntoConstraints = false
        return someView
    }()
    private lazy var button3: UIButton = {
        let someView = UIButton()
        someView.setTitle("3", for: .normal)
        someView.setTitleColor(.black, for: .normal)
        someView.backgroundColor = .white
        someView.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        someView.translatesAutoresizingMaskIntoConstraints = false
        return someView
    }()
    private lazy var button4: UIButton = {
        let someView = UIButton()
        someView.setTitle("4", for: .normal)
        someView.setTitleColor(.black, for: .normal)
        someView.backgroundColor = .white
        someView.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        someView.translatesAutoresizingMaskIntoConstraints = false
        return someView
    }()
    private lazy var button5: UIButton = {
        let someView = UIButton()
        someView.setTitle("5", for: .normal)
        someView.setTitleColor(.black, for: .normal)
        someView.backgroundColor = .white
        someView.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        someView.translatesAutoresizingMaskIntoConstraints = false
        return someView
    }()
    private lazy var button6: UIButton = {
        let someView = UIButton()
        someView.setTitle("6", for: .normal)
        someView.setTitleColor(.black, for: .normal)
        someView.backgroundColor = .white
        someView.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        someView.translatesAutoresizingMaskIntoConstraints = false
        return someView
    }()
    private lazy var button7: UIButton = {
        let someView = UIButton()
        someView.setTitle("7", for: .normal)
        someView.setTitleColor(.black, for: .normal)
        someView.backgroundColor = .white
        someView.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        someView.translatesAutoresizingMaskIntoConstraints = false
        return someView
    }()
    private lazy var button8: UIButton = {
        let someView = UIButton()
        someView.setTitle("8", for: .normal)
        someView.setTitleColor(.black, for: .normal)
        someView.backgroundColor = .white
        someView.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        someView.translatesAutoresizingMaskIntoConstraints = false
        return someView
    }()
    private lazy var button9: UIButton = {
        let someView = UIButton()
        someView.setTitle("9", for: .normal)
        someView.setTitleColor(.black, for: .normal)
        someView.backgroundColor = .white
        someView.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        someView.translatesAutoresizingMaskIntoConstraints = false
        return someView
    }()
    private lazy var button0: UIButton = {
        let someView = UIButton()
        someView.setTitle("0", for: .normal)
        someView.setTitleColor(.black, for: .normal)
        someView.backgroundColor = .white
        someView.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        someView.translatesAutoresizingMaskIntoConstraints = false
        return someView
    }()
    
    ///Button variables for arithmetic operations.
    private lazy var buttonPlus: UIButton = {
        let someView = UIButton()
        someView.setTitle("+", for: .normal)
        someView.setTitleColor(.black, for: .normal)
        someView.backgroundColor = .white
        someView.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        someView.translatesAutoresizingMaskIntoConstraints = false
        return someView
    }()
    private lazy var buttonMinus: UIButton = {
        let someView = UIButton()
        someView.setTitleColor(.black, for: .normal)
        someView.setTitle("-", for: .normal)
        someView.backgroundColor = .white
        someView.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        someView.translatesAutoresizingMaskIntoConstraints = false
        return someView
    }()
    private lazy var buttonMultiply: UIButton = {
        let someView = UIButton()
        someView.setTitle("*", for: .normal)
        someView.setTitleColor(.black, for: .normal)
        someView.backgroundColor = .white
        someView.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        someView.translatesAutoresizingMaskIntoConstraints = false
        return someView
    }()
    private lazy var buttonDivide: UIButton = {
        let someView = UIButton()
        someView.setTitle("/", for: .normal)
        someView.setTitleColor(.black, for: .normal)
        someView.backgroundColor = .white
        someView.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        someView.translatesAutoresizingMaskIntoConstraints = false
        return someView
    }()
    private lazy var buttonClear: UIButton = {
        let someView = UIButton()
        someView.setTitle("AC", for: .normal)
        someView.setTitleColor(.black, for: .normal)
        someView.backgroundColor = .white
        someView.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        someView.translatesAutoresizingMaskIntoConstraints = false
        return someView
    }()
    private lazy var buttonPoint: UIButton = {
        let someView = UIButton()
        someView.setTitle(".", for: .normal)
        someView.setTitleColor(.black, for: .normal)
        someView.backgroundColor = .white
        someView.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        someView.translatesAutoresizingMaskIntoConstraints = false
        return someView
    }()
    private lazy var buttonEquals: UIButton = {
        let someView = UIButton()
        someView.setTitle("=", for: .normal)
        someView.setTitleColor(.black, for: .normal)
        someView.backgroundColor = .white
        someView.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        someView.translatesAutoresizingMaskIntoConstraints = false
        return someView
    }()
    private lazy var buttonPercent: UIButton = {
        let someView = UIButton()
        someView.setTitle("%", for: .normal)
        someView.setTitleColor(.black, for: .normal)
        someView.backgroundColor = .white
        someView.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        someView.translatesAutoresizingMaskIntoConstraints = false
        return someView
    }()
    private lazy var buttonRepeat: UIButton = {
        let someView = UIButton()
        someView.setTitle("R", for: .normal)
        someView.setTitleColor(.black, for: .normal)
        someView.backgroundColor = .white
        someView.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        someView.translatesAutoresizingMaskIntoConstraints = false
        return someView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        ///add buttons subview to view
        addSubViews(button0,button1,button2,button3,button4,button5,button6,
                    button7,button8,button9,buttonPlus,buttonClear,buttonMinus,
                    buttonDivide,buttonMultiply,buttonPercent,myLabel,buttonEquals, buttonPoint,buttonRepeat)
        ///Configuration of all autolayout constriants.
        configureUI()
        
    }
    
    func configureUI() {
        let digitsButtons: [UIButton] = [ buttonClear, buttonPoint, buttonPercent,
                                          button7, button8, button9, button4, button5,
                                          button6, button1, button2, button3]
        
        let operationButtons: [UIButton] = [buttonPlus, buttonMinus,  buttonDivide, buttonMultiply]
        
        let buttonSpacing = CGFloat(5)
        let buttonSize: CGFloat = (view.bounds.width - 4 * buttonSpacing) / 4.0 - 2 * buttonSpacing
        
        ///empty array of layoutconstriants.
        var constraints: [NSLayoutConstraint] = []
        
        /// Constraints for my label
        constraints += [
            myLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            myLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            myLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            myLabel.heightAnchor.constraint(equalToConstant: 100),
            
            button0.heightAnchor.constraint(equalToConstant: buttonSize),
            button0.widthAnchor.constraint(equalToConstant: buttonSize * 2),
            button0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
            button0.topAnchor.constraint(equalTo: buttonMultiply.bottomAnchor, constant: 5),
            
            buttonEquals.heightAnchor.constraint(equalToConstant: buttonSize),
            buttonEquals.widthAnchor.constraint(equalToConstant: buttonSize),
            buttonEquals.leadingAnchor.constraint(equalTo: buttonRepeat.trailingAnchor, constant: 7),
            buttonEquals.topAnchor.constraint(equalTo: buttonMultiply.bottomAnchor, constant: 5),
            
            buttonRepeat.heightAnchor.constraint(equalToConstant: buttonSize),
            buttonRepeat.widthAnchor.constraint(equalToConstant: buttonSize ),
            buttonRepeat.leadingAnchor.constraint(equalTo: button0.trailingAnchor, constant: 6),
            buttonRepeat.topAnchor.constraint(equalTo: button3.bottomAnchor, constant: 5),
        ]
        
        for (index, button) in digitsButtons.enumerated() {
            constraints += [
                button.heightAnchor.constraint(equalToConstant: buttonSize),
                button.widthAnchor.constraint(equalToConstant: buttonSize),
                button.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:buttonSpacing + CGFloat(index % 3) * (buttonSize + buttonSpacing)),
                button.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: buttonSpacing + CGFloat(index / 3) * (buttonSize + buttonSpacing)),
            ]
        }
        
        for (index, button) in operationButtons.enumerated() {
            constraints += [
                button.heightAnchor.constraint(equalToConstant: buttonSize),
                button.widthAnchor.constraint(equalToConstant: buttonSize),
                button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
                button.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: buttonSpacing + CGFloat(index) * (buttonSize + buttonSpacing))
            ]
        }
        
        ///Adding targets to buttons with number variables.
        for buttons in digitsButtons {
            buttons.addTarget(self, action: #selector(digitButtonTapped(_:)), for: .touchUpInside)
        }
        for buttons in operationButtons {
            buttons.addTarget(self, action: #selector(operationButtonTapped(_:)), for: .touchUpInside)
        }
        

        button0.addTarget(self, action: #selector(zeroButtonTapped), for: .touchUpInside)
        buttonEquals.addTarget(self, action: #selector(equalsButtonTapped), for: .touchUpInside)
        buttonRepeat.addTarget(self, action: #selector(repeatButtonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate(constraints)
    }
    
    
    @objc func digitButtonTapped(_ sender: UIButton) {
        print("button tapped!")
        if let digit = sender.titleLabel?.text {
            if digit == "AC" {
                currentInput = "0"
                calculatorModel.clear()
            } else if digit == "%" {
                if Double(currentInput) != nil {
                    let res = (Double(currentInput)! / 100)
                    currentInput = String(res)
                }
            } else if digit == "."{
                if !currentInput.contains(".") {
                    calculatorModel.isDecimalInput = true
                    currentInput += digit
                }
            } else {
                currentInput += digit
                calculatorModel.inputNumber(Double(digit) ?? 0.0)
            }
            update()
            
        }
    }
    
    @objc func operationButtonTapped(_ sender: UIButton) {
        if let operatorSign = sender.titleLabel?.text {
            calculatorModel.inputOperator(operatorSign)
            currentInput = "0"
            update()
        }
      }
    @objc func zeroButtonTapped(_ sender: UIButton) {
        if currentInput != "0"{
            currentInput += "0"
        }
        update()
    }
    @objc func equalsButtonTapped() {
        if let result = calculatorModel.performOperation() {
                currentInput = String(format: "%.2f", result)
                calculatorModel.clear()
            } else {
                currentInput = "Error"
            }
            update()
    }

    @objc func repeatButtonTapped() {
        print("tapped")
        calculatorModel.repeatLastOperation()
        update()
    }

    
    
    
        ///Function to update myLabel to either show the result of the last calculation or what the user has typed if he has.
        func update() {
            myLabel.text = currentInput.isEmpty ? "\(calculatorModel.getResult())": currentInput
        }
        
    }

extension CalculatorViewController {
    private func addSubViews(_ subviews: UIView...) {
        subviews.forEach {view.addSubview($0)}
    }
}
