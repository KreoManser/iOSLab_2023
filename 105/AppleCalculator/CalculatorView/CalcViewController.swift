//
//  CalcViewController.swift
//  AppleCalculator
//
//  Created by Faki Doosuur Doris on 11.10.2023.
//

import UIKit

class CalcViewController: UIViewController {
    
    private let calculatorModel = CalculatorModel()
    private var currentInput: String = "0"
    private var memory: Double?

    private lazy var myLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .white
        label.text = "0"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.backgroundColor = .systemPink
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var stackView: UIStackView!
    
    private let portraitButtonRows: [[String]] = [
        ["AC", ".", "%", "+"],
        ["7", "8", "9", "-"],
        ["4", "5", "6", "/"],
        ["1", "2", "3", "*"],
        ["0", "<-", "=", "abs"]
    ]
    private let landscapeButtonRows: [[String]] = [
           ["AC", ".", "%", "+", "π"],
           ["7", "8", "9", "-", "√"],
           ["4", "5", "6", "/", "3√"],
           ["1", "2", "3", "*", "M+"],
           ["0", "<-", "=", "(", ")"]
       ]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setupUI()
        ///To niotify for screen orientation  change so as  to add extra buttons in landscape.
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    private func setupUI() {
        
        stackView = createStackView(axis: .vertical)
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        let buttonRows: [[String]]

            if UIDevice.current.orientation.isLandscape {
                buttonRows = landscapeButtonRows
            } else {
                buttonRows = portraitButtonRows
            }
        
        for row in buttonRows {
            let rowStackView = createStackView(axis: .horizontal)
            rowStackView.spacing = 10
            rowStackView.alignment = .fill
            rowStackView.distribution = .fillEqually

            for buttonTitle in row {
                let button = createButton(title: buttonTitle)
                rowStackView.addArrangedSubview(button)
            }

            stackView.addArrangedSubview(rowStackView)
        }

        view.addSubview(myLabel)
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            myLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            myLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            myLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            myLabel.heightAnchor.constraint(equalToConstant: 100),

            stackView.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
    
    ///function to create stack view for buttons.
    private func createStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
       let stackView = UIStackView()
        stackView.axis = axis
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    ///function to create buttons.
    private func createButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    ///function to enable target addition when buttons are tapped.
    @objc func buttonTapped(_ sender: UIButton) {
        if let title = sender.titleLabel?.text {
            switch title {
            case "AC":
                currentInput = "0"
                calculatorModel.clear()
            case "%":
                if let number = Double(currentInput) {
                    let result = number / 100
                    currentInput = String(result)
                }
            case ".":
                if !currentInput.contains(".") {
                    calculatorModel.isDecimalInput = true
                    currentInput += "."
                    calculatorModel.inputNumber(Double(title) ?? 0.0)
                }
            case "=":
                if let result = calculatorModel.performOperation() {
                    currentInput = String(format: "%.2f", result)
                    calculatorModel.clear()
                } else {
                    currentInput = "Error"
                }
            case "π":
                currentInput = String(Double.pi)
            case "√":
                if let number = Double(currentInput), number >= 0 {
                    currentInput = String(sqrt(number))
                } else {
                    currentInput = "Error"
                }
            case "3√":
                if let number = Double(currentInput) {
                    currentInput = String(pow(number, 1.0 / 3.0))
                } else {
                    currentInput = "Error"
                }
            case "M+":
                if let number = Double(currentInput) {
                    memory = number
                }
            case "<-":
                if !currentInput.isEmpty {
                    currentInput.removeLast()
                }
            case "(", ")":
                currentInput += title
            case "+":
                calculatorModel.inputOperator("+")
                update()
            case "-":
                calculatorModel.inputOperator("-")
                update()
            case "*":
                calculatorModel.inputOperator("*")
                update()
            case "/":
                calculatorModel.inputOperator("/")
                update()
            case "abs":
                if let number = Double(currentInput) {
                        currentInput = String(abs(number))
                        update()
                    }
            default:
                currentInput += title
                calculatorModel.inputNumber(Double(title) ?? 0.0)
            }
        }
        update()
    }
    @objc func orientationDidChange() {
        let buttonRows: [[String]]
        
        if UIDevice.current.orientation.isLandscape {
            buttonRows = landscapeButtonRows
        } else {
            buttonRows = portraitButtonRows
        }
        
        /// Remove existing buttons from the stack view
        for subview in stackView.arrangedSubviews {
                stackView.removeArrangedSubview(subview)
                subview.removeFromSuperview()
        }
        
        /// Create and add buttons based on the new orientation
        for row in buttonRows {
            let rowStackView = createStackView(axis: .horizontal)
            rowStackView.spacing = 10
            rowStackView.alignment = .fill
            rowStackView.distribution = .fillEqually

            for buttonTitle in row {
                let button = createButton(title: buttonTitle)
                rowStackView.addArrangedSubview(button)
            }

            stackView.addArrangedSubview(rowStackView)
        }
    }

    ///to update mylabel with current input.
    func update() {
        myLabel.text = currentInput.isEmpty ? "\(calculatorModel.getResult())" : currentInput
    }
}


