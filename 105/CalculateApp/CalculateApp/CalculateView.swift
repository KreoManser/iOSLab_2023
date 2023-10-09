//
//  CalculateView.swift
//  CalculateApp
//
//  Created by Mac on 2023-10-08.
//

import UIKit

enum OperationType{
    case plus
    case minus
    case multiply
    case divide
    case noOperation
}

class CalculateView: UIView {
    
    private var numberButtons: [UIButton] = []
    private var currentFirstNumber: Double?
    private var currentSecondNumber: Double?
    
    lazy var currentNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 50)
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Declaration Operation Up Buttons
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setOperationUpButton(title: "AC")
        return button
    }()
    
    lazy var signButton: UIButton = {
        let button = UIButton()
        button.setOperationUpButton(title: "⁺/₋")
        return button
    }()
    
    lazy var percentButton: UIButton = {
        let button = UIButton()
        button.setOperationUpButton(title: "%")
        return button
    }()
    
    // MARK: - Declaration Number Buttons
    lazy var oneButton: UIButton = {
        let button = UIButton()
        button.setNumberButton(title: "1")
        numberButtons.append(button)
        return button
    }()
    
    lazy var twoButton: UIButton = {
        let button = UIButton()
        button.setNumberButton(title: "2")
        numberButtons.append(button)
        return button
    }()
    
    lazy var threeButton: UIButton = {
        let button = UIButton()
        button.setNumberButton(title: "3")
        numberButtons.append(button)
        return button
    }()
    
    lazy var fourButton: UIButton = {
        let button = UIButton()
        button.setNumberButton(title: "4")
        numberButtons.append(button)
        return button
    }()
    
    lazy var fiveButton: UIButton = {
        let button = UIButton()
        button.setNumberButton(title: "5")
        numberButtons.append(button)
        return button
    }()
    
    lazy var sixButton: UIButton = {
        let button = UIButton()
        button.setNumberButton(title: "6")
        numberButtons.append(button)
        return button
    }()
    
    lazy var sevenButton: UIButton = {
        let button = UIButton()
        button.setNumberButton(title: "7")
        numberButtons.append(button)
        return button
    }()
    
    lazy var eigthButton: UIButton = {
        let button = UIButton()
        button.setNumberButton(title: "8")
        numberButtons.append(button)
        return button
    }()
    
    lazy var nineButton: UIButton = {
        let button = UIButton()
        button.setNumberButton(title: "9")
        numberButtons.append(button)
        return button
    }()
    
    lazy var zeroButton: UIButton = {
        let button = UIButton()
        button.setNumberButton(title: "0")
        numberButtons.append(button)
        return button
    }()
    
    lazy var dotButton: UIButton = {
        let button = UIButton()
        button.setNumberButton(title: ".")
        return button
    }()
    
    // MARK: - Declaration Operation Rigth Buttons
    lazy var divisionButton: UIButton = {
        let button = UIButton()
        button.setOperationRigthButton(title: "÷")
        return button
    }()
    
    lazy var multiplicationButton: UIButton = {
        let button = UIButton()
        button.setOperationRigthButton(title: "×")
        return button
    }()
    
    lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setOperationRigthButton(title: "-")
        return button
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setOperationRigthButton(title: "+")
        return button
    }()
    
    lazy var equallyButton: UIButton = {
        let button = UIButton()
        button.setOperationRigthButton(title: "=")
        return button
    }()
    
    // MARK: - Declaration Operation Horizontal Buttons
    lazy var leftBracketButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "(")
        return button
    }()
    
    lazy var rightBracketButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: ")")
        return button
    }()
    
    lazy var mcButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "mc")
        return button
    }()
    
    lazy var mPlusButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "m+")
        return button
    }()
    
    lazy var mMinusButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "m-")
        return button
    }()
    
    lazy var mrButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "mr")
        return button
    }()
    
    lazy var secoNDButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "2ⁿᵈ")
        return button
    }()
    
    lazy var secondDegreeButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "x²")
        return button
    }()
    
    lazy var thirdDegreeButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "x³")
        return button
    }()
    
    lazy var xInYDegreeButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "xʸ")
        return button
    }()
    
    lazy var exponentInXDegreeButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "eˣ")
        return button
    }()
    
    lazy var tenInXDegreeButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "10ˣ")
        return button
    }()
    
    lazy var oneDivitionXButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "¹/ₓ")
        return button
    }()
    
    lazy var secondRootOfXButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "²√ₓ")
        return button
    }()
    
    lazy var thirdRootOfXButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "³√ₓ")
        return button
    }()
    
    lazy var yRootOfXButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "ʸ√ₓ")
        return button
    }()
    
    lazy var lnButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "ln")
        return button
    }()
    
    lazy var logTenButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "log₁₀")
        return button
    }()
    
    lazy var factorialXButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "x!")
        return button
    }()
    
    lazy var sinButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "sin")
        return button
    }()
    
    lazy var cosButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "cos")
        return button
    }()
    
    lazy var tanButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "tan")
        return button
    }()
    
    lazy var exponentButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "e")
        return button
    }()
    
    lazy var eeButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "EE")
        return button
    }()
    
    lazy var radButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "Rad")
        return button
    }()
    
    lazy var sinhButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "sinh")
        return button
    }()
    
    lazy var coshButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "cosh")
        return button
    }()
    
    lazy var tanhButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "tanh")
        return button
    }()
    
    lazy var piButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "π")
        return button
    }()
    
    lazy var randButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "Rand")
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupLayout()
        addActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Constraints
extension CalculateView {
    /// Func to set constraints for all views
    func setupLayout() {
        let firstLine = [deleteButton, signButton, percentButton, divisionButton]
        let secondLine = [sevenButton, eigthButton, nineButton, multiplicationButton]
        let thirdLine = [fourButton, fiveButton, sixButton, minusButton]
        let fourthLine = [oneButton, twoButton, threeButton, plusButton]
        let fifthLine = [zeroButton, dotButton, equallyButton]
        
        let firstLineStackView = createStackView(views: firstLine)
        let secondLineStackview = createStackView(views: secondLine)
        let thirdLineStackView = createStackView(views: thirdLine)
        let fourthLineStackView = createStackView(views: fourthLine)
        let fifrhLineStackView = createStackView(views: fifthLine)
        
        addSubview(currentNumberLabel)
        addSubview(firstLineStackView)
        addSubview(secondLineStackview)
        addSubview(thirdLineStackView)
        addSubview(fourthLineStackView)
        addSubview(fifrhLineStackView)
        
        setupCurrentNumberLabel()
        setupFirstLineStackView(stackView: firstLineStackView)
        setupLineConstrains(stackView: secondLineStackview, connectView: firstLineStackView)
        setupLineConstrains(stackView: thirdLineStackView, connectView: secondLineStackview)
        setupLineConstrains(stackView: fourthLineStackView, connectView: thirdLineStackView)
        setupLineConstrains(stackView: fifrhLineStackView, connectView: fourthLineStackView)
        
        NSLayoutConstraint.activate([
            fifrhLineStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    /// Support func to set constraints for label with current number
    private func setupCurrentNumberLabel() {
        NSLayoutConstraint.activate([
            currentNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            currentNumberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            currentNumberLabel.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    /// Support func to set constraints for first line (stackView) in calculator
    /// - Parameter stackView: stackView that concised of elements from first line
    private func setupFirstLineStackView(stackView: UIStackView) {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: currentNumberLabel.bottomAnchor, 
                                           constant: 15),
            stackView.leadingAnchor.constraint(equalTo: currentNumberLabel.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: currentNumberLabel.trailingAnchor),
            stackView.heightAnchor.constraint(equalTo: currentNumberLabel.heightAnchor, multiplier: 1)
        ])
    }
    
    /// Support general func to set constraints for lines
    /// - Parameters:
    ///   - stackView: ine (stackView) in calculator exept first that will get constraints
    ///   - connectView: ine (stackView) in calculator that helps to make constraints
    private func setupLineConstrains(stackView: UIStackView, connectView: UIStackView) {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: connectView.bottomAnchor, constant: 14),
            stackView.leadingAnchor.constraint(equalTo: connectView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: connectView.trailingAnchor),
            stackView.heightAnchor.constraint(equalTo: connectView.heightAnchor),
            zeroButton.trailingAnchor.constraint(equalTo: twoButton.trailingAnchor),
            dotButton.trailingAnchor.constraint(equalTo: threeButton.trailingAnchor)
        ])
    }
    
    /// Suppor func to create stackView from line
    /// - Parameter views: elements (buttons) that will be in stackView
    /// - Returns: stackView from line with default settings
    private func createStackView(views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        return stackView
    }
}

extension CalculateView {
    func addActions() {
        let numberAction: UIAction = UIAction { [weak self] action in
            guard let button = action.sender as? UIButton else { return }
            guard let buttonTitle = button.titleLabel?.text else { return }
            if let currentTitle = self?.currentNumberLabel.text, currentTitle != "0"{
                self?.currentNumberLabel.text = currentTitle + buttonTitle
                self?.deleteButton.titleLabel?.text = " C"
            } else if self?.currentFirstNumber != nil {
                self?.currentNumberLabel.text = buttonTitle
                self?.deleteButton.titleLabel?.text = " C"
            } else {
                self?.currentNumberLabel.text = buttonTitle
                self?.deleteButton.titleLabel?.text = " C"
            }
        }
        
        let deleteAction: UIAction = UIAction { [weak self] _ in
            self?.currentNumberLabel.text = "0"
            self?.deleteButton.titleLabel?.text = "AC"
            self?.currentFirstNumber = nil
            self?.currentSecondNumber = nil
        }
        
        let plusAction: UIAction = UIAction { [weak self] _ in
            if let firstNumber = self?.currentFirstNumber {
                if let secondNumber = self?.currentSecondNumber {
                    self?.currentFirstNumber = firstNumber + secondNumber
                    self?.currentNumberLabel.text = String(firstNumber + secondNumber)
                    self?.currentSecondNumber = nil
                } else {
                    self?.currentSecondNumber = Double(self?.currentNumberLabel.text ?? "0")
                }
            } else {
                self?.currentFirstNumber = Double(self?.currentNumberLabel.text ?? "0")
            }
            
        }
        
        for button in numberButtons {
            button.addAction(numberAction, for: .touchUpInside)
        }
        deleteButton.addAction(deleteAction, for: .touchUpInside)
        plusButton.addAction(plusAction, for: .touchUpInside)
        
        
        
    }
}
