//
//  CalculatorView.swift
//  HomeWork_5
//
//  Created by Камил Хайрутдинов on 06.10.2023.
//

import UIKit

/// Protocol for view and model relationships
protocol CalculatorHandler: AnyObject {
    /// Сalculates the result of two peals with respect to the operator
    /// - Parameters:
    ///   - oprator: Mathematical operator
    ///   - firstNumber: First number form calculator
    ///   - secondNumber: Second number form calculator
    /// - Returns: Calculated result
    func calculate(oprator: Operators, firstNumber: String, secondNumber: String) -> String
}

/// Mathematical operators
enum Operators {
    case plus
    case minus
    case multiply
    case divide
    case none
}

/// Screen orientation
enum CurrentOrietation {
    case portrait
    case landscape
}

class CalculatorView: UIView {
    // MARK: - UI elements
    
    internal lazy var calculatorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 90)
        label.textColor = .white
        label.textAlignment = .right
        label.isUserInteractionEnabled = true
        return label
    }()
    
    internal lazy var mainButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            firstRowButtonStackView, secondRowButtonStackView,
            thirdRowButtonStackView, fourthRowButtonStackView,
            fifthRowButtonStackView
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: - First row buttons
    internal lazy var firstRowButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            leftBracketButton, rightBracketButton,
            mcButton, mPlusButton, mMinusButton,
            mrButton, clearButton, changeSignButton,
            percentButton, divideButton
        ])
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var leftBracketButton: UIButton = {
        let button = additionalButtonTemplate(title: "(" )
        return button
    }()
    
    private lazy var rightBracketButton: UIButton = {
        let button = additionalButtonTemplate(title: ")" )
        return button
    }()
    
    private lazy var mcButton: UIButton = {
        let button = additionalButtonTemplate(title: "mc" )
        return button
    }()
    
    private lazy var mPlusButton: UIButton = {
        let button = additionalButtonTemplate(title: "m+" )
        return button
    }()
    
    private lazy var mMinusButton: UIButton = {
        let button = additionalButtonTemplate(title: "m-" )
        return button
    }()
    
    private lazy var mrButton: UIButton = {
        let button = additionalButtonTemplate(title: "mr" )
        return button
    }()
    
    private lazy var clearButton: UIButton = {
        let button = mainButtonTemplate(title: "AC", titleColor: .black, backgroundColor: UIColor.calcLightGray)
        return button
    }()
    
    private lazy var changeSignButton: UIButton = {
        let button = mainButtonTemplate(title: "+/-", titleColor: .black, backgroundColor: UIColor.calcLightGray)
        return button
    }()
    
    private lazy var percentButton: UIButton = {
        let button = mainButtonTemplate(title: "%", titleColor: .black, backgroundColor: UIColor.calcLightGray)
        return button
    }()
    
    private lazy var divideButton: UIButton = {
        let button = mainButtonTemplate(title: "÷", titleColor: .white , backgroundColor: UIColor.calcVividGamboge)
        return button
    }()
    
    // MARK: - Second row button
    internal lazy var secondRowButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            secondButton, xDegreeTwoButton, xDegreeThreeButton,
            xDegreeYButton, eDegreeXButton, tenfoldXButton,
            sevenButton, eightButton, nineButton, multiplyButton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var secondButton: UIButton = {
        let button = additionalButtonTemplate(title: "2ⁿᵈ" )
        return button
    }()
    
    private lazy var xDegreeTwoButton: UIButton = {
        let button = additionalButtonTemplate(title: "x²" )
        return button
    }()
    
    private lazy var xDegreeThreeButton: UIButton = {
        let button = additionalButtonTemplate(title: "x³" )
        return button
    }()
    
    private lazy var xDegreeYButton: UIButton = {
        let button = additionalButtonTemplate(title: "xʸ" )
        return button
    }()
    
    private lazy var eDegreeXButton: UIButton = {
        let button = additionalButtonTemplate(title: "eˣ" )
        return button
    }()
    
    private lazy var tenfoldXButton: UIButton = {
        let button = additionalButtonTemplate(title: "10ˣ" )
        return button
    }()
    
    private lazy var sevenButton: UIButton = {
        let button = mainButtonTemplate(title: "7", titleColor: .white, backgroundColor: UIColor.calcDarkLiver)
        button.tag = 7
        return button
    }()
    
    private lazy var eightButton: UIButton = {
        let button = mainButtonTemplate(title: "8", titleColor: .white, backgroundColor: UIColor.calcDarkLiver)
        button.tag = 8
        return button
    }()
    
    private lazy var nineButton: UIButton = {
        let button = mainButtonTemplate(title: "9", titleColor: .white, backgroundColor: UIColor.calcDarkLiver)
        button.tag = 9
        return button
    }()
    
    private lazy var multiplyButton: UIButton = {
        let button = mainButtonTemplate(title: "×", titleColor: .white , backgroundColor: UIColor.calcVividGamboge)
        return button
    }()
    
    // MARK: - Third row button
    internal lazy var thirdRowButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            oneDivideXButton, sqrtTwoXButton, sqrtThreeXButton,
            sqrtYXButton, lnButton, logTenButton,
            fourButton, fiveButton, sixButton, minusButton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var oneDivideXButton: UIButton = {
        let button = additionalButtonTemplate(title: "1/x" )
        return button
    }()
    
    private lazy var sqrtTwoXButton: UIButton = {
        let button = additionalButtonTemplate(title: "2√x" )
        return button
    }()
    
    private lazy var sqrtThreeXButton: UIButton = {
        let button = additionalButtonTemplate(title: "3√x" )
        return button
    }()
    
    private lazy var sqrtYXButton: UIButton = {
        let button = additionalButtonTemplate(title: "y√x" )
        return button
    }()
    
    private lazy var lnButton: UIButton = {
        let button = additionalButtonTemplate(title: "ln" )
        return button
    }()
    
    private lazy var logTenButton: UIButton = {
        let button = additionalButtonTemplate(title: "log₁₀" )
        return button
    }()
    
    private lazy var fourButton: UIButton = {
        let button = mainButtonTemplate(title: "4", titleColor: .white, backgroundColor: UIColor.calcDarkLiver)
        button.tag = 4
        return button
    }()
    
    private lazy var fiveButton: UIButton = {
        let button = mainButtonTemplate(title: "5", titleColor: .white, backgroundColor: UIColor.calcDarkLiver)
        button.tag = 5
        return button
    }()
    
    private lazy var sixButton: UIButton = {
        let button = mainButtonTemplate(title: "6", titleColor: .white, backgroundColor: UIColor.calcDarkLiver)
        button.tag = 6
        return button
    }()
    
    private lazy var minusButton: UIButton = {
        let button = mainButtonTemplate(title: "-", titleColor: .white , backgroundColor: UIColor.calcVividGamboge)
        return button
    }() 
    
    // MARK: - Fourth row button
    internal lazy var fourthRowButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            factorialXButton, sinButton, cosButton,
            tanButton, eButton, eeButton, oneButton,
            twoButton, threeButton, plusButton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var factorialXButton: UIButton = {
        let button = additionalButtonTemplate(title: "x!" )
        return button
    }()
    
    private lazy var sinButton: UIButton = {
        let button = additionalButtonTemplate(title: "sin" )
        return button
    }()
    
    private lazy var cosButton: UIButton = {
        let button = additionalButtonTemplate(title: "cos" )
        return button
    }()
    
    private lazy var tanButton: UIButton = {
        let button = additionalButtonTemplate(title: "tan" )
        return button
    }()
    
    private lazy var eButton: UIButton = {
        let button = additionalButtonTemplate(title: "e" )
        return button
    }()
    
    private lazy var eeButton: UIButton = {
        let button = additionalButtonTemplate(title: "EE" )
        return button
    }()
    
    private lazy var oneButton: UIButton = {
        let button = mainButtonTemplate(title: "1", titleColor: .white, backgroundColor: UIColor.calcDarkLiver)
        button.tag = 1
        return button
    }()
    
    private lazy var twoButton: UIButton = {
        let button = mainButtonTemplate(title: "2", titleColor: .white, backgroundColor: UIColor.calcDarkLiver)
        button.tag = 2
        return button
    }()
    
    private lazy var threeButton: UIButton = {
        let button = mainButtonTemplate(title: "3", titleColor: .white, backgroundColor: UIColor.calcDarkLiver)
        button.tag = 3
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = mainButtonTemplate(title: "+", titleColor: .white , backgroundColor: UIColor.calcVividGamboge)
        return button
    }()
    
    // MARK: - Fifth row button
    internal lazy var fifthRowButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            radButton, sinhButton, coshButton,
            tanhButton, piButton, randButton,
            zeroButton, pointButton, equalButton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var radButton: UIButton = {
        let button = additionalButtonTemplate(title: "Rad")
        return button
    }()
    
    private lazy var sinhButton: UIButton = {
        let button = additionalButtonTemplate(title: "sinh" )
        return button
    }()
    
    private lazy var coshButton: UIButton = {
        let button = additionalButtonTemplate(title: "cosh" )
        return button
    }()
    
    private lazy var tanhButton: UIButton = {
        let button = additionalButtonTemplate(title: "tanh" )
        return button
    }()
    
    private lazy var piButton: UIButton = {
        let button = additionalButtonTemplate(title: "π" )
        return button
    }()
    
    private lazy var randButton: UIButton = {
        let button = additionalButtonTemplate(title: "Rand" )
        return button
    }()
    
    private lazy var zeroButton: UIButton = {
        let button = mainButtonTemplate(title: "0", titleColor: .white, backgroundColor: UIColor.calcDarkLiver)
        return button
    }()
    
    private lazy var pointButton: UIButton = {
        let button = mainButtonTemplate(title: ",", titleColor: .white, backgroundColor: UIColor.calcDarkLiver)
        return button
    }()
    
    private lazy var equalButton: UIButton = {
        let button = mainButtonTemplate(title: "=", titleColor: .white, backgroundColor: UIColor.calcVividGamboge)
        return button
    }()
    
    // MARK: - Variables
    
    /// Button array for comfortable work with buttons
    internal var buttons: [UIButton] = []
    
    /// Button array for comfortable work with buttons
    internal var additionalButtons: [UIButton] = []
    
    /// Main view frame
    internal var viewFrame: CGRect
    
    /// Button width constraint
    internal var buttonsWidthConstraint: NSLayoutConstraint?
    
    /// button height constraint
    internal var buttonsHeightConstraint: NSLayoutConstraint?
    
    /// Zero button width constraint
    internal var zeroButtonsWidthConstraint: NSLayoutConstraint?
    
    /// Zero button height constraint
    internal var zeroButtonsHeightConstraint: NSLayoutConstraint?

    /// Protocol for calculate in controller
    weak var calculatorHandler: CalculatorHandler?
    
    /// Bool variable for check operation button
    private var operationButtonIsPressed: Bool = false
    
    /// Divice current oriantation
    internal var currentOrietation: CurrentOrietation = .portrait
    
    /// First number to calculate
    private var firstNumber: String?
    
    /// Second number to calculate
    private var secondNumber: String?
    
    /// Current operator sing
    private var currentOperator: Operators?
    
    // MARK: - Init
    init(viewWidth: CGRect) {
        viewFrame = viewWidth
        super.init(frame: .zero)
        backgroundColor = .black
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(subviews: mainButtonStackView, calculatorLabel)
        configureUI()
        configureActions()
        ConfigureLabelSwipeGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CalculatorView {
    
    /// Adds UI elements to the view
    /// - Parameter subviews: UI elements
    internal func addSubviews(subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
    
    // MARK: - ConfigureUI
    /// Configure UI layout
    private func configureUI() {
        
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
            calculatorLabel.bottomAnchor.constraint(equalTo: mainButtonStackView.topAnchor, constant: -10),
            calculatorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            fifthRowButtonStackView.leadingAnchor.constraint(equalTo: mainButtonStackView.leadingAnchor),
            fifthRowButtonStackView.trailingAnchor.constraint(equalTo: mainButtonStackView.trailingAnchor),
            
            zeroButtonsWidthConstraint!,
            zeroButtonsHeightConstraint!,
            
            buttonsWidthConstraint!,
            buttonsHeightConstraint!,
            
            mainButtonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: (viewFrame.width - ((viewFrame.width - 60) + 30)) / 2),
            mainButtonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -((viewFrame.width - ((viewFrame.width - 60) + 30)) / 2)),
            
            mainButtonStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
    }
}

extension CalculatorView {
    // MARK: - configureActions
    
    /// Configure main buttons action
    func configureActions() {
        
        /// Action for clearButton
        let clearButtonAction: UIAction = UIAction { [weak self] _ in
            self?.calculatorLabel.text = "0"
            self?.firstNumber = "0"
            self?.labelHandler()
            self?.currentOperator = Operators.none
        }
        clearButton.addAction(clearButtonAction, for: .touchUpInside)
        
        /// Action for changeSingButton
        let changeSingButtonAction: UIAction = UIAction { [weak self] _ in
            let numberIsLessThenZero = self?.calculatorLabel.text!.contains("-")
            if !(numberIsLessThenZero!) 
                && self?.calculatorLabel.text != "0"
                && self?.calculatorLabel.text != ""
            {
                self!.calculatorLabel.text!.insert("-", at: (self?.calculatorLabel.text!.startIndex)!)
            }
            
            else if numberIsLessThenZero!
                        && self?.calculatorLabel.text != "0"
                        && self?.calculatorLabel.text != "" {
                self?.calculatorLabel.text!.removeFirst()
            }
        }
        changeSignButton.addAction(changeSingButtonAction, for: .touchUpInside)
        
        
        /// Action for divideButton
        let divideButtonAction: UIAction = UIAction { [weak self] _ in
            self?.firstNumber = self?.calculatorLabel.text
            self?.currentOperator = .divide
            self?.calculatorLabel.text = ""
        }
        divideButton.addAction(divideButtonAction, for: .touchUpInside)
        
        /// Action for sevenButton
        let sevenButtonAction: UIAction = UIAction { [weak self] _ in
            let tag = self?.sevenButton.tag
            if self?.calculatorLabel.text == "0" {
                self?.calculatorLabel.text = String(tag!)
            }
            else {
                self?.calculatorLabel.text! += String(tag!)
            }
            self?.labelHandler()
        }
        sevenButton.addAction(sevenButtonAction, for: .touchUpInside)
        
        /// Action for eightButton
        let eightButtonAction: UIAction = UIAction { [weak self] _ in
            let tag = self?.eightButton.tag
            if self?.calculatorLabel.text == "0" {
                self?.calculatorLabel.text = String(tag!)
            }
            else {
                self?.calculatorLabel.text! += String(tag!)
            }
            self?.labelHandler()
        }
        eightButton.addAction(eightButtonAction, for: .touchUpInside)
        
        /// Action for nineButton
        let nineButtonAction: UIAction = UIAction { [weak self] _ in
            let tag = self?.nineButton.tag
            if self?.calculatorLabel.text == "0" {
                self?.calculatorLabel.text = String(tag!)
            }
            else {
                self?.calculatorLabel.text! += String(tag!)
            }
            self?.labelHandler()
        }
        nineButton.addAction(nineButtonAction, for: .touchUpInside)
        
        /// Action for multiplyButton
        let multiplyButtonAction: UIAction = UIAction { [weak self] _ in
            self?.firstNumber = self?.calculatorLabel.text
            self?.currentOperator = .multiply
            self?.calculatorLabel.text = ""
        }
        multiplyButton.addAction(multiplyButtonAction, for: .touchUpInside)
        
        /// Action for fourButton
        let fourButtonAction: UIAction = UIAction { [weak self] _ in
            let tag = self?.fourButton.tag
            if self?.calculatorLabel.text == "0" {
                self?.calculatorLabel.text = String(tag!)
            }
            else {
                self?.calculatorLabel.text! += String(tag!)
            }
            self?.labelHandler()
        }
        fourButton.addAction(fourButtonAction, for: .touchUpInside)
        
        /// Action for fiveButton
        let fiveButtonAction: UIAction = UIAction { [weak self] _ in
            let tag = self?.fiveButton.tag
            if self?.calculatorLabel.text == "0" {
                self?.calculatorLabel.text = String(tag!)
            }
            else {
                self?.calculatorLabel.text! += String(tag!)      
            }
            self?.labelHandler()
        }
        fiveButton.addAction(fiveButtonAction, for: .touchUpInside)
        
        /// Action for sixButton
        let sixButtonAction: UIAction = UIAction { [weak self] _ in
            let tag = self?.sixButton.tag
            if self?.calculatorLabel.text == "0" {
                self?.calculatorLabel.text = String(tag!)
            }
            else {
                self?.calculatorLabel.text! += String(tag!)          
            }
            self?.labelHandler()
        }
        sixButton.addAction(sixButtonAction, for: .touchUpInside)
        
        /// Action for minusButton
        let minusButtonAction: UIAction = UIAction { [weak self] _ in
            self?.firstNumber = self?.calculatorLabel.text
            self?.currentOperator = .minus
            self?.calculatorLabel.text = ""
        }
        minusButton.addAction(minusButtonAction, for: .touchUpInside)
        
        /// Action for oneButton
        let oneButtonAction: UIAction = UIAction { [weak self] _ in
            let tag = self?.oneButton.tag
            if self?.calculatorLabel.text == "0" {
                self?.calculatorLabel.text = String(tag!)
            }
            else {
                self?.calculatorLabel.text! += String(tag!)
            }
            self?.labelHandler()
        }
        oneButton.addAction(oneButtonAction, for: .touchUpInside)
        
        /// Action for twoButton
        let twoButtonAction: UIAction = UIAction { [weak self] _ in
            let tag = self?.twoButton.tag
            if self?.calculatorLabel.text == "0" {
                self?.calculatorLabel.text = String(tag!)
            }
            else {
                self?.calculatorLabel.text! += String(tag!)
            }
            self?.labelHandler()
        }
        twoButton.addAction(twoButtonAction, for: .touchUpInside)
        
        /// Action for threeButton
        let threeButtonAction: UIAction = UIAction { [weak self] _ in
            let tag = self?.threeButton.tag
            if self?.calculatorLabel.text == "0" {
                self?.calculatorLabel.text = String(tag!)
            }
            else {
                self?.calculatorLabel.text! += String(tag!)
            }
            self?.labelHandler()
        }
        threeButton.addAction(threeButtonAction, for: .touchUpInside)
        
        /// Action for plusButton
        let plusButtonAction: UIAction = UIAction { [weak self] _ in
            self?.firstNumber = self?.calculatorLabel.text
            self?.currentOperator = .plus
            self?.calculatorLabel.text = ""
        }

        plusButton.addAction(plusButtonAction, for: .touchUpInside)
        
        /// Action for zeroButton
        let zeroButtonAction: UIAction = UIAction { [weak self] _ in
            if self!.calculatorLabel.text != "0" {
                let tag = self!.zeroButton.tag
                self!.calculatorLabel.text = self!.calculatorLabel.text! + String(tag)
            }
            self?.labelHandler()
        }
        zeroButton.addAction(zeroButtonAction, for: .touchUpInside)
        
        /// Action for pointButton
        let pointButtonAction: UIAction = UIAction { [weak self] _ in
            let textIsContainsPoint = self!.calculatorLabel.text?.contains(where: { $0 == "," })
            if self!.calculatorLabel.text != "0" && !(textIsContainsPoint!){
                self!.calculatorLabel.text = self!.calculatorLabel.text! + ","
            }
            self?.labelHandler()
        }
        pointButton.addAction(pointButtonAction, for: .touchUpInside)
        
        /// Action for equalButton
        let equalButtonAction: UIAction = UIAction { [weak self] _ in
            self?.secondNumber = self?.calculatorLabel.text
            guard let currentOperator = self?.currentOperator,
                  let firstNumber = self?.firstNumber,
                  let secondNumber = self?.secondNumber else { return }
            self?.calculatorLabel.text = self?.calculatorHandler?.calculate(oprator: currentOperator, firstNumber: firstNumber, secondNumber: secondNumber)
        }
        equalButton.addAction(equalButtonAction, for: .touchUpInside)
    }
    
    private func labelHandler() {
        let leght = (calculatorLabel.text!
            .replacingOccurrences(of: ",", with: "")
            .count)
        
        if calculatorLabel.text! == "0" {
            self.clearButton.setTitle("AC", for: .normal)
        }
        else {
            self.clearButton.setTitle("C", for: .normal)
        }
        if self.currentOrietation == .portrait {
            switch leght {
            case ...6:
                calculatorLabel.font = UIFont.systemFont(ofSize: 90)
            case 6...12:
                calculatorLabel.font = UIFont.systemFont(ofSize: CGFloat((90 - leght * 4)))
            default:
                break
            }
        }
    }
    
    /// Configure gesture for label
    private func ConfigureLabelSwipeGesture() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(calculatorLabelSwiped(_:)))
        swipe.direction = .left
        self.calculatorLabel.addGestureRecognizer(swipe)
    }
    
    /// Gesture logic
    /// - Parameter gesture: Swipe gesture
    @objc private func calculatorLabelSwiped(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            if(self.calculatorLabel.text!.count > 1) {
                self.calculatorLabel.text! =  String(self.calculatorLabel.text!.dropLast())
            }
            else if (self.calculatorLabel.text! != "0")
            {
                self.calculatorLabel.text! = "0"
            }
            labelHandler()
        }
    }
}
