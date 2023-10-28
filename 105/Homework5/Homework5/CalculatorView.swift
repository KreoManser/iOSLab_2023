//
//  CalculatorView.swift
//  Homework5
//
//  Created by kerik on 07.10.2023.
//

import UIKit

/// Protocol for view and model relationships
protocol CalculatorHandler: AnyObject {
    /// Сalculates the result with parametrs
    /// - Parameters:
    ///   - oprator: mathematical operator
    ///   - firstNumber: first number form calculator
    ///   - secondNumber: second number form calculator
    /// - Returns: calculated result
    func calculate(oprator: Operators, firstNumber: String, secondNumber: String) -> String
}

class CalculatorView: UIView {
    private lazy var calculatorLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 70)
        label.textColor = .white
        label.textAlignment = .right
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// StackView with all buttons
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            createHorizontalStackView(buttons: [
                clearButton,
                signButton,
                percentButton,
                divideButton], distibution: .fillEqually),
            createHorizontalStackView(buttons: [
                sevenButton,
                eightButton,
                nineButton,
                multiplyButton
            ], distibution: .fillEqually),
            createHorizontalStackView(buttons: [
                fourButton,
                fiveButton,
                sixButton,
                minusButton
            ], distibution: .fillEqually),
            createHorizontalStackView(buttons: [
                oneButton,
                twoButton,
                threeButton,
                plusButton
            ], distibution: .fillEqually),
            fifthRowButtonStackView
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var clearButton: UIButton = {
        let button = createButton(title: "AC", titleColor: .black, buttonColor: .systemGray)
        return button
    }()
    
    private lazy var signButton: UIButton = {
        let button = createButton(title: "+/-", titleColor: .black, buttonColor: .systemGray)
        return button
    }()
    
    private lazy var percentButton: UIButton = {
        let button = createButton(title: "%", titleColor: .black, buttonColor: .systemGray)
        
        return button
    }()
    
    private lazy var divideButton: UIButton = {
        let button = createButton(title: "÷", titleColor: .white , buttonColor: .systemOrange)
        return button
    }()
    
    private lazy var sevenButton: UIButton = {
        let button = createButton(title: "7", titleColor: .white, buttonColor: .darkGray)
        return button
    }()
    
    private lazy var eightButton: UIButton = {
        let button = createButton(title: "8", titleColor: .white, buttonColor: .darkGray)
        return button
    }()
    
    private lazy var nineButton: UIButton = {
        let button = createButton(title: "9", titleColor: .white, buttonColor: .darkGray)
        return button
    }()
    
    private lazy var multiplyButton: UIButton = {
        let button = createButton(title: "×", titleColor: .white , buttonColor: UIColor.systemOrange)
        return button
    }()
    
    private lazy var fourButton: UIButton = {
        let button = createButton(title: "4", titleColor: .white, buttonColor: .darkGray)
        return button
    }()
    
    private lazy var fiveButton: UIButton = {
        let button = createButton(title: "5", titleColor: .white, buttonColor: .darkGray)
        return button
    }()
    
    private lazy var sixButton: UIButton = {
        let button = createButton(title: "6", titleColor: .white, buttonColor: .darkGray)
        return button
    }()
    
    private lazy var minusButton: UIButton = {
        let button = createButton(title: "-", titleColor: .white , buttonColor: UIColor.systemOrange)
        return button
    }()
    
    private lazy var oneButton: UIButton = {
        let button = createButton(title: "1", titleColor: .white, buttonColor: .darkGray)
        return button
    }()
    
    private lazy var twoButton: UIButton = {
        let button = createButton(title: "2", titleColor: .white, buttonColor: .darkGray)
        return button
    }()
    
    private lazy var threeButton: UIButton = {
        let button = createButton(title: "3", titleColor: .white, buttonColor: .darkGray)
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = createButton(title: "+", titleColor: .white , buttonColor: UIColor.systemOrange)
        return button
    }()
    
    private lazy var zeroButton: UIButton = {
        let button = createButton(title: "0", titleColor: .white, buttonColor: .darkGray)
        return button
    }()
    
    private lazy var pointButton: UIButton = {
        let button = createButton(title: ",", titleColor: .white, buttonColor: .darkGray)
        return button
    }()
    
    private lazy var equalButton: UIButton = {
        let button = createButton(title: "=", titleColor: .white , buttonColor: UIColor.systemOrange)
        return button
    }()
    
    private lazy var fifthRowButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            zeroButton,
            pointButton,
            equalButton,
        ])
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    private var buttonsWidthConstraint: NSLayoutConstraint?
    private var buttonsHeightConstraint: NSLayoutConstraint?
    private var zeroButtonsWidthConstraint: NSLayoutConstraint?
    private var zeroButtonsHeightConstraint: NSLayoutConstraint?
    
    /// Protocol for calculate in controller
    weak var calculatorHandler: CalculatorHandler?
    
    /// First number to calculate
    private var firstNumber: String?
    
    /// Second number to calculate
    private var secondNumber: String?
    
    /// Current operator sign
    private var currentOperator: Operators?
    
    private var viewFrame: CGRect
    var buttons: [UIButton] = []
    
    init(viewWidth: CGRect) {
        viewFrame = viewWidth
        
        super.init(frame: .zero)
        backgroundColor = .black
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(subviews: calculatorLabel ,buttonStackView)
        setLayout()
        setActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CalculatorView {
    
    /// Button creation function
    /// - Parameters:
    ///   - title: button title
    ///   - titleColor: title color
    ///   - buttonColor: button color
    /// - Returns: a button with the specified name and color
    private func createButton(title: String, titleColor: UIColor, buttonColor: UIColor) -> UIButton {
        var config = UIButton.Configuration.filled()
        config.attributedTitle = AttributedString(
            title,
            attributes: AttributeContainer(
                [NSAttributedString.Key.font:
                    UIFont.systemFont(ofSize: 30, weight: .bold)]
            )
        )
        let button = UIButton(configuration: config)
        button.setTitle(title , for: .normal)
        button.tintColor = buttonColor
        button.setTitleColor(titleColor, for: .normal)
        button.layer.masksToBounds = true
        buttons.append(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    /// Horizontal StackView creation function
    /// - Parameters:
    ///   - buttons: array of buttons
    ///   - distibution: buttons distibution
    /// - Returns: stackView with buttons
    private func createHorizontalStackView(buttons: [UIButton], distibution: UIStackView.Distribution) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = distibution
        return stackView
    }
    
    /// Add UI elements to the view
    private func addSubviews(subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
    
    /// Setup UI Layout
    private func setLayout() {
        
        buttons.forEach { button in
            if button.title(for: .normal) == "0" {
                zeroButtonsWidthConstraint = button.widthAnchor.constraint(equalToConstant: ((viewFrame.width - 60) / 4) * 2 + 10)
                zeroButtonsHeightConstraint = button.heightAnchor.constraint(equalToConstant: (viewFrame.width - 60) / 4)
                button.layer.cornerRadius = zeroButtonsHeightConstraint!.constant / 2
            }
            else {
                buttonsWidthConstraint = button.widthAnchor.constraint(equalToConstant: (viewFrame.width - 60) / 4)
                buttonsHeightConstraint =  button.heightAnchor.constraint(equalToConstant: (viewFrame.width - 60) / 4)
                button.layer.cornerRadius = buttonsHeightConstraint!.constant / 2
            }
        }
        
        NSLayoutConstraint.activate([
            calculatorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            calculatorLabel.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -10),
            calculatorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -5),
            buttonStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            
            fifthRowButtonStackView.leadingAnchor.constraint(equalTo: buttonStackView.leadingAnchor),
            fifthRowButtonStackView.trailingAnchor.constraint(equalTo: buttonStackView.trailingAnchor),
            
            zeroButtonsWidthConstraint!,
            zeroButtonsHeightConstraint!,
            
            buttonsWidthConstraint!,
            buttonsHeightConstraint!,
            
        ])
    }
}
extension CalculatorView {
    /// Function to set actions for buttons
    func setActions() {
        /// Action for "clear button"
        let clearButtonAction: UIAction = UIAction { [weak self] _ in
            self?.calculatorLabel.text = ""
            self?.currentOperator = Operators.none
            self?.firstNumber = "0"
            self?.secondNumber = "0"
        }
        clearButton.addAction(clearButtonAction, for: .touchUpInside)
        
        /// Action for "sign button"
        let signButtonAction: UIAction = UIAction { [weak self] _ in
            let numberIsLessThanZero = self?.calculatorLabel.text!.contains("-")
            if !(numberIsLessThanZero!)
                && self?.calculatorLabel.text != "0"
                && self?.calculatorLabel.text != ""
            {
                self!.calculatorLabel.text!.insert("-", at: (self?.calculatorLabel.text!.startIndex)!)
            }
            
            else if numberIsLessThanZero!
                        && self?.calculatorLabel.text != "0"
                        && self?.calculatorLabel.text != "" {
                self?.calculatorLabel.text!.removeFirst()
            }
        }
        signButton.addAction(signButtonAction, for: .touchUpInside)
        
        /// Action for "percent button"
        let percentButtonAction: UIAction = UIAction { [weak self] _ in
            if (self?.calculatorLabel.text != "0" && self?.calculatorLabel.text != "" ) {
                self!.calculatorLabel.text! = String.DecimalToString(
                    value: (
                        Decimal.ConvertStringWithComma(string: self?.calculatorLabel.text!) / 100
                    )
                )
            }
        }
        percentButton.addAction(percentButtonAction, for: .touchUpInside)
        
        /// Action for "divide button"
        let divideButtonAction: UIAction = UIAction { [weak self] _ in
            self?.firstNumber = self?.calculatorLabel.text
            self?.currentOperator = Operators.divide
            self?.calculatorLabel.text = ""
        }
        divideButton.addAction(divideButtonAction, for: .touchUpInside)
        
        /// Actions for number buttons (0 - 9)
        let sevenButtonAction = setNumberButtonAction(number: "7")
        sevenButton.addAction(sevenButtonAction, for: .touchUpInside)
        
        let eightButtonAction = setNumberButtonAction(number: "8")
        eightButton.addAction(eightButtonAction, for: .touchUpInside)
        
        let nineButtonAction = setNumberButtonAction(number: "9")
        nineButton.addAction(nineButtonAction, for: .touchUpInside)
        
        let fourButtonAction = setNumberButtonAction(number: "4")
        fourButton.addAction(fourButtonAction, for: .touchUpInside)
        
        let fiveButtonAction = setNumberButtonAction(number: "5")
        fiveButton.addAction(fiveButtonAction, for: .touchUpInside)
        
        let sixButtonAction = setNumberButtonAction(number: "6")
        sixButton.addAction(sixButtonAction, for: .touchUpInside)
        
        let oneButtonAction = setNumberButtonAction(number: "1")
        oneButton.addAction(oneButtonAction, for: .touchUpInside)
        
        let twoButtonAction = setNumberButtonAction(number: "2")
        twoButton.addAction(twoButtonAction, for: .touchUpInside)
        
        let threeButtonAction = setNumberButtonAction(number: "3")
        threeButton.addAction(threeButtonAction, for: .touchUpInside)
        
        let zeroButtonAction = setNumberButtonAction(number: "0")
        zeroButton.addAction(zeroButtonAction, for: .touchUpInside)
        
        /// Action for "multiply button"
        let multiplyButtonAction: UIAction = UIAction { [weak self] _ in
            self?.firstNumber = self?.calculatorLabel.text
            self?.currentOperator = .multiply
            self?.calculatorLabel.text = ""
        }
        multiplyButton.addAction(multiplyButtonAction, for: .touchUpInside)
        
        /// Action for "minus button"
        let minusButtonAction: UIAction = UIAction { [weak self] _ in
            self?.firstNumber = self?.calculatorLabel.text
            self?.currentOperator = .minus
            self?.calculatorLabel.text = ""
        }
        minusButton.addAction(minusButtonAction, for: .touchUpInside)
        
        /// Action for "plus button"
        let plusButtonAction: UIAction = UIAction { [weak self] _ in
            self?.firstNumber = self?.calculatorLabel.text
            self?.currentOperator = .plus
            self?.calculatorLabel.text = ""
        }
        plusButton.addAction(plusButtonAction, for: .touchUpInside)
        
        /// Action for "point button"
        let pointButtonAction: UIAction = UIAction { [weak self] _ in
            let textIsContainsPoint = self!.calculatorLabel.text?.contains(where: { $0 == "," })
            if self!.calculatorLabel.text != "0" && !(textIsContainsPoint!){
                self!.calculatorLabel.text = self!.calculatorLabel.text! + ","
            }
        }
        pointButton.addAction(pointButtonAction, for: .touchUpInside)
        
        /// Action for "equal button"
        let equalButtonAction: UIAction = UIAction { [weak self] _ in
            self?.secondNumber = self?.calculatorLabel.text
            guard let currentOperator = self?.currentOperator,
                  let firstNumber = self?.firstNumber,
                  let secondNumber = self?.secondNumber else { return }
            self?.calculatorLabel.text = self?.calculatorHandler?.calculate(oprator: currentOperator, firstNumber: firstNumber, secondNumber: secondNumber)
        }
        equalButton.addAction(equalButtonAction, for: .touchUpInside)
    }
}

extension CalculatorView {
    /// Function to set actions for number buttons
    /// - Parameter number: number of button
    /// - Returns: action for button
    func setNumberButtonAction(number: String) -> UIAction {
        let action: UIAction = UIAction { [weak self] _ in
            if self?.calculatorLabel.text == "0" {
                self?.calculatorLabel.text = number
            }
            else {
                self?.calculatorLabel.text! += number
            }
        }
        return action
    }
}
