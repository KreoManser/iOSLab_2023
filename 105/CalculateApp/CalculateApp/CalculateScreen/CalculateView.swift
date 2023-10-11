//
//  CalculateView.swift
//  CalculateApp
//
//  Created by Mac on 2023-10-08.
//

import UIKit

/// Set view of Calculate Screen
class CalculateView: UIView {
    // MARK: - Declaration support variables
    private var numberButtons: [UIButton] = []
    private var currentFirstNumber: Double?
    private var currentSecondNumber: Double? = 0
    private var currentOperatiton: OperationType = .noOperation
    weak var calculateProtocol: CalculateProtocol?
    
    // MARK: - Declaration UI
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
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setOperationUpButton(title: "AC")
        return button
    }()
    
    private lazy var signButton: UIButton = {
        let button = UIButton()
        button.setOperationUpButton(title: "⁺/₋")
        return button
    }()
    
    private lazy var percentButton: UIButton = {
        let button = UIButton()
        button.setOperationUpButton(title: "%")
        return button
    }()
    
    // MARK: - Declaration Number Buttons
    private lazy var oneButton: UIButton = {
        let button = UIButton()
        button.setNumberButton(title: "1")
        numberButtons.append(button)
        return button
    }()
    
    private lazy var twoButton: UIButton = {
        let button = UIButton()
        button.setNumberButton(title: "2")
        numberButtons.append(button)
        return button
    }()
    
    private lazy var threeButton: UIButton = {
        let button = UIButton()
        button.setNumberButton(title: "3")
        numberButtons.append(button)
        return button
    }()
    
    private lazy var fourButton: UIButton = {
        let button = UIButton()
        button.setNumberButton(title: "4")
        numberButtons.append(button)
        return button
    }()
    
    private lazy var fiveButton: UIButton = {
        let button = UIButton()
        button.setNumberButton(title: "5")
        numberButtons.append(button)
        return button
    }()
    
    private lazy var sixButton: UIButton = {
        let button = UIButton()
        button.setNumberButton(title: "6")
        numberButtons.append(button)
        return button
    }()
    
    private lazy var sevenButton: UIButton = {
        let button = UIButton()
        button.setNumberButton(title: "7")
        numberButtons.append(button)
        return button
    }()
    
    private lazy var eigthButton: UIButton = {
        let button = UIButton()
        button.setNumberButton(title: "8")
        numberButtons.append(button)
        return button
    }()
    
    private lazy var nineButton: UIButton = {
        let button = UIButton()
        button.setNumberButton(title: "9")
        numberButtons.append(button)
        return button
    }()
    
    private lazy var zeroButton: UIButton = {
        let button = UIButton()
        button.setNumberButton(title: "0")
        numberButtons.append(button)
        return button
    }()
    
    private lazy var dotButton: UIButton = {
        let button = UIButton()
        button.setNumberButton(title: ".")
        return button
    }()
    
    // MARK: - Declaration Operation Rigth Buttons
    private lazy var divisionButton: UIButton = {
        let button = UIButton()
        button.setOperationRigthButton(title: "÷")
        return button
    }()
    
    private lazy var multiplicationButton: UIButton = {
        let button = UIButton()
        button.setOperationRigthButton(title: "×")
        return button
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setOperationRigthButton(title: "-")
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setOperationRigthButton(title: "+")
        return button
    }()
    
    private lazy var equallyButton: UIButton = {
        let button = UIButton()
        button.setOperationRigthButton(title: "=")
        return button
    }()
    
    // MARK: - Declaration Operation Horizontal Buttons
    private lazy var leftBracketButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "(")
        return button
    }()
    
    private lazy var rightBracketButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: ")")
        return button
    }()
    
    private lazy var mcButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "mc")
        return button
    }()
    
    private lazy var mPlusButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "m+")
        return button
    }()
    
    private lazy var mMinusButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "m-")
        return button
    }()
    
    private lazy var mrButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "mr")
        return button
    }()
    
    private lazy var secoNDButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "2ⁿᵈ")
        return button
    }()
    
    private lazy var secondDegreeButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "x²")
        return button
    }()
    
    private lazy var thirdDegreeButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "x³")
        return button
    }()
    
    private lazy var xInYDegreeButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "xʸ")
        return button
    }()
    
    private lazy var exponentInXDegreeButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "eˣ")
        return button
    }()
    
    private lazy var tenInXDegreeButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "10ˣ")
        return button
    }()
    
    private lazy var oneDivitionXButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "¹/ₓ")
        return button
    }()
    
    private lazy var secondRootOfXButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "²√ₓ")
        return button
    }()
    
    private lazy var thirdRootOfXButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "³√ₓ")
        return button
    }()
    
    private lazy var yRootOfXButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "ʸ√ₓ")
        return button
    }()
    
    private lazy var lnButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "ln")
        return button
    }()
    
    private lazy var logTenButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "log₁₀")
        return button
    }()
    
    private lazy var factorialXButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "x!")
        return button
    }()
    
    private lazy var sinButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "sin")
        return button
    }()
    
    private lazy var cosButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "cos")
        return button
    }()
    
    private lazy var tanButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "tan")
        return button
    }()
    
    private lazy var exponentButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "e")
        return button
    }()
    
    private lazy var eeButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "EE")
        return button
    }()
    
    private lazy var radButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "Rad")
        return button
    }()
    
    private lazy var sinhButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "sinh")
        return button
    }()
    
    private lazy var coshButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "cosh")
        return button
    }()
    
    private lazy var tanhButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "tanh")
        return button
    }()
    
    private lazy var piButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "π")
        return button
    }()
    
    private lazy var randButton: UIButton = {
        let button = UIButton()
        button.setOperationHorizontalButton(title: "Rand")
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupLayout(orintation: "portrait")
        addActions()
        setTargetToLabel()
        setNextTargetToLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Constraints
extension CalculateView {
    /// Add constraints to CalculateView
    /// - Parameter orintation: orintation of view
    func setupLayout(orintation: String) {
        /// Array to add later stackViews from createLinesConsicedOfStackView
        let stackViews: [UIStackView]
        
        /// Set stackViews with unvisible/visible add buttons in horisontal format
        if orintation == "portrait" {
            stackViews = createLinesConsicedOfStackView(changeVisible: makeUnvisible)
        } else {
            stackViews = createLinesConsicedOfStackView(changeVisible: makeVisible)
        }
        
        /// Main vertical stackView with all horisontal stackViews
        let mainStackView = createStackView(views: stackViews, orintation: .vertical)
        
        /// Add elements to subview
        addSubview(mainStackView)
        addSubview(currentNumberLabel)
        
        /// Activate constraints
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            currentNumberLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            currentNumberLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            currentNumberLabel.heightAnchor.constraint(equalToConstant: 70),
            currentNumberLabel.bottomAnchor.constraint(equalTo: mainStackView.topAnchor, constant: 10),
            
            stackViews[0].heightAnchor.constraint(equalTo: deleteButton.widthAnchor, multiplier: 0.9),
            stackViews[1].heightAnchor.constraint(equalTo: deleteButton.widthAnchor, multiplier: 0.9),
            stackViews[2].heightAnchor.constraint(equalTo: deleteButton.widthAnchor, multiplier: 0.9),
            stackViews[3].heightAnchor.constraint(equalTo: deleteButton.widthAnchor, multiplier: 0.9),
            stackViews[4].heightAnchor.constraint(equalTo: deleteButton.widthAnchor, multiplier: 0.9),
            
            randButton.trailingAnchor.constraint(equalTo: eeButton.trailingAnchor),
            piButton.leadingAnchor.constraint(equalTo: exponentButton.leadingAnchor),
            zeroButton.trailingAnchor.constraint(equalTo: twoButton.trailingAnchor),
            dotButton.trailingAnchor.constraint(equalTo: threeButton.trailingAnchor)
        ])
    }
    
    /// Func that hels to create mainStackView
    /// - Parameter changeVisible: Func that do visible/unvisible
    /// - Returns: Array with stackViews(lines) fo mainStackView
    private func createLinesConsicedOfStackView(changeVisible: (_ array: [UIButton]) -> Void) -> [UIStackView] {
        /// Create arrays with main buttons
        let firstLineMain = [deleteButton, signButton, percentButton, divisionButton]
        let secondLineMain = [sevenButton, eigthButton, nineButton, multiplicationButton]
        let thirdLineMain = [fourButton, fiveButton, sixButton, minusButton]
        let fourthLineMain = [oneButton, twoButton, threeButton, plusButton]
        let fifthLineMain = [zeroButton, dotButton, equallyButton]
        
        /// Create arrays with additional buttons
        let firstLineAdd = [leftBracketButton, rightBracketButton, mcButton, mPlusButton, mMinusButton, mrButton]
        let secondLineAdd = [secoNDButton, secondDegreeButton, thirdDegreeButton, xInYDegreeButton, exponentInXDegreeButton, tenInXDegreeButton]
        let thirdLineAdd = [oneDivitionXButton, secondRootOfXButton, thirdRootOfXButton, yRootOfXButton, lnButton, logTenButton]
        let fourthLineAdd = [factorialXButton, sinButton, cosButton, tanButton, exponentButton, eeButton]
        let fifthLineAdd = [radButton, sinhButton, coshButton, tanhButton, piButton, randButton]
        
        /// Set visible
        changeVisible(firstLineAdd)
        changeVisible(secondLineAdd)
        changeVisible(thirdLineAdd)
        changeVisible(fourthLineAdd)
        changeVisible(fifthLineAdd)
        
        /// Create stackViews with horizontal lines
        let firstLineStackView = createStackView(views: firstLineAdd + firstLineMain)
        let secondLineStackView = createStackView(views: secondLineAdd + secondLineMain)
        let thirdLineStackView = createStackView(views: thirdLineAdd + thirdLineMain)
        let fourthLineStackView = createStackView(views: fourthLineAdd + fourthLineMain)
        let fifthLineStackView = createStackView(views: fifthLineAdd + fifthLineMain)
        
        /// Set distribution
        firstLineStackView.distribution = .fillEqually
        secondLineStackView.distribution = .fillEqually
        thirdLineStackView.distribution = .fillEqually
        fourthLineStackView.distribution = .fillEqually
        
        /// Stack view with all elements
        let stackViews = [firstLineStackView, secondLineStackView, thirdLineStackView, fourthLineStackView, fifthLineStackView]
        
        return stackViews
    }
    
    /// Suppor func to create stackView from line
    /// - Parameter views: elements (buttons) that will be in stackView
    /// - Returns: stackView from line with default settings
    private func createStackView(views: [UIView], orintation: NSLayoutConstraint.Axis = .horizontal) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = orintation
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        return stackView
    }
    
    /// Add additional buttons unvisiible
    /// - Parameter array: buttons that will be unvisible
    private func makeUnvisible(array: [UIButton]) {
        for button in array {
            button.isHidden = true
        }
    }
    
    /// Add additional buttons visisible
    /// - Parameter array: buttons that will be visible
    private func makeVisible(array: [UIButton]) {
        for button in array {
            button.isHidden = false
        }
    }
}

// MARK: - Set Actions to Buttons
extension CalculateView {
    /// Create and set actions for buttons
    private func addActions() {
        /// Create action for number buttons
        let numberAction: UIAction = UIAction { [weak self] action in
            guard let button = action.sender as? UIButton else { return }
            guard let buttonTitle = button.titleLabel?.text else { return }
            
            if let currentTitle = self?.currentNumberLabel.text, currentTitle != "0", self?.currentSecondNumber != nil {
                self?.currentNumberLabel.text = currentTitle + buttonTitle
                self?.deleteButton.titleLabel?.text = " C"
            } else {
                self?.currentNumberLabel.text = buttonTitle
                self?.deleteButton.titleLabel?.text = " C"
            }
        }
        
        let pointAction: UIAction = UIAction { [weak self] action in
            guard let button = action.sender as? UIButton else { return }
            guard let buttonTitle = button.titleLabel?.text else { return }
            
            if let currentTitle = self?.currentNumberLabel.text, currentTitle != "0", self?.currentSecondNumber != nil {
                var isHasPoint = false
                for char in currentTitle {
                    if char == "." {
                        isHasPoint = true
                    }
                }
                if !isHasPoint {
                    self?.currentNumberLabel.text = currentTitle + buttonTitle
                    self?.deleteButton.titleLabel?.text = " C"
                }
            } else {
                self?.currentNumberLabel.text = buttonTitle
                self?.deleteButton.titleLabel?.text = " C"
            }
        }
        
        /// Create action for delete button
        let deleteAction: UIAction = UIAction { [weak self] _ in
            self?.currentNumberLabel.text = "0"
            self?.deleteButton.titleLabel?.text = "AC"
            self?.currentFirstNumber = nil
            self?.currentSecondNumber = 0
            self?.currentOperatiton = .noOperation
        }
        
        /// Create action for equally button
        let equallyAction: UIAction = UIAction { [weak self] _ in
            let operation = self?.currentOperatiton
            let firstNumber = String(self?.currentFirstNumber ?? 0.0)
            let secondNumber = self?.currentNumberLabel.text ?? "0"
            
            self?.currentNumberLabel.text = self?.calculateProtocol?.calculate(operation: operation ?? .noOperation, firstNumber: firstNumber, secondNumber: secondNumber)
            self?.currentFirstNumber = nil
            self?.currentSecondNumber = 0
            self?.currentOperatiton = .noOperation
        }
        
        /// Create actions for operation buttons
        let plusAction = createOperationAction(operation: .plus)
        let minusAction = createOperationAction(operation: .minus)
        let divideAction = createOperationAction(operation: .divide)
        let multiplyAction = createOperationAction(operation: .multiply)
        
        /// Set actions for all buttons
        deleteButton.addAction(deleteAction, for: .touchUpInside)
        plusButton.addAction(plusAction, for: .touchUpInside)
        minusButton.addAction(minusAction, for: .touchUpInside)
        divisionButton.addAction(divideAction, for: .touchUpInside)
        multiplicationButton.addAction(multiplyAction, for: .touchUpInside)
        equallyButton.addAction(equallyAction, for: .touchUpInside)
        for button in numberButtons {
            button.addAction(numberAction, for: .touchUpInside)
        }
        dotButton.addAction(pointAction, for: .touchUpInside)
    }
    
    /// Support func to create action for operation buttons
    /// - Parameter operation: operation of button
    /// - Returns: created action of button
    private func createOperationAction(operation: OperationType) -> UIAction {
        let action: UIAction = UIAction { [weak self] _ in
            self?.currentFirstNumber = Double(self?.currentNumberLabel.text ?? "0")
            self?.currentOperatiton = operation
            self?.currentNumberLabel.text = ""
        }
        return action
    }
    
    /// Add possibility to swipe to previous number
    private func setTargetToLabel() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRigth(_:)))
        swipeGesture.direction = .right
        currentNumberLabel.addGestureRecognizer(swipeGesture)
        currentNumberLabel.isUserInteractionEnabled = true
    }
    
    /// - Parameter sender: sender
    @objc func handleSwipeRigth(_ sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            self.currentNumberLabel.text = calculateProtocol?.changeBecauseOfHistory()
        }
    }
    
    /// Add possibility to swipe to next number
    private func setNextTargetToLabel() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft(_:)))
        swipeGesture.direction = .left
        currentNumberLabel.addGestureRecognizer(swipeGesture)
        currentNumberLabel.isUserInteractionEnabled = true
    }
    
    /// - Parameter sender: sender
    @objc func handleSwipeLeft(_ sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            self.currentNumberLabel.text = calculateProtocol?.doOneMoreTime()
        }
    }
}
