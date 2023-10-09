//
//  CalculatorView.swift
//  105
//
//  Created by Dmitry on 06.10.2023.
//

import UIKit

class CalculatorView: UIView {
    
    // MARK: - Variables
    
    weak var controller: ViewController?
    
    /// Distance between all buttons
    private let distanceBetweenButtons = UIScreen.main.bounds.width*0.04
    
    /// Distance between bottom numbers row and bottom edge 
    private let bottomDistance = UIScreen.main.bounds.height * 0.08
    
    /// Button width and height
    private let buttonSize = (UIScreen.main.bounds.width - UIScreen.main.bounds.width * 0.04 * 5) / 4
    
    lazy var introducedNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = .systemFont(ofSize: 90, weight: .light)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    lazy var zeroButton: UIButton = {
        let action = UIAction { _ in
            if self.introducedNumberLabel.text != "0" && self.introducedNumberLabel.text!.count < 9 {
                self.introducedNumberLabel.text? += "0"
            }
        }
        let button = UIButton(primaryAction: action)
        button.setTitle("0", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        return button
    }()
    
    lazy var commaButton: UIButton = {
        let action = UIAction { _ in
            if !(self.introducedNumberLabel.text!.contains(".")) && self.introducedNumberLabel.text!.count < 9 {
                self.introducedNumberLabel.text? += "."
                self.checkLabelLength()
            }
        }
        let button = UIButton(primaryAction: action)
        button.setTitleColor(.white, for: .normal)
        button.setTitle(",", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        return button
    }()
    
    lazy var oneButton: UIButton = {
        let action = UIAction { _ in
            if self.introducedNumberLabel.text == "0" {
                self.introducedNumberLabel.text = "1"
            } else if self.introducedNumberLabel.text!.count < 9 {
                self.introducedNumberLabel.text? += "1"
                self.checkLabelLength()
            }
        }
        let button = UIButton(primaryAction: action)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("1", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        return button
    }()
    
    lazy var twoButton: UIButton = {
        let action = UIAction { _ in
            if self.introducedNumberLabel.text == "0" {
                self.introducedNumberLabel.text = "2"
            } else if self.introducedNumberLabel.text!.count < 9 {
                self.introducedNumberLabel.text? += "2"
                self.checkLabelLength()
            }
        }
        let button = UIButton(primaryAction: action)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("2", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        return button
    }()
    
    lazy var threeButton: UIButton = {
        let action = UIAction { _ in
            if self.introducedNumberLabel.text == "0" {
                self.introducedNumberLabel.text = "3"
            } else if self.introducedNumberLabel.text!.count < 9 {
                self.introducedNumberLabel.text? += "3"
                self.checkLabelLength()
            }
        }
        let button = UIButton(primaryAction: action)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("3", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        return button
    }()
    
    lazy var fourButton: UIButton = {
        let action = UIAction { _ in
            if self.introducedNumberLabel.text == "0" {
                self.introducedNumberLabel.text = "4"
            } else if self.introducedNumberLabel.text!.count < 9 {
                self.introducedNumberLabel.text? += "4"
                self.checkLabelLength()
            }
        }
        let button = UIButton(primaryAction: action)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("4", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        return button
    }()
    
    lazy var fiveButton: UIButton = {
        let action = UIAction { _ in
            if self.introducedNumberLabel.text == "0" {
                self.introducedNumberLabel.text = "5"
            } else if self.introducedNumberLabel.text!.count < 9 {
                self.introducedNumberLabel.text? += "5"
                self.checkLabelLength()
            }
        }
        let button = UIButton(primaryAction: action)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("5", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        return button
    }()
    
    lazy var sixButton: UIButton = {
        let action = UIAction { _ in
            if self.introducedNumberLabel.text == "0" {
                self.introducedNumberLabel.text = "6"
            } else if self.introducedNumberLabel.text!.count < 9 {
                self.introducedNumberLabel.text? += "6"
                self.checkLabelLength()
            }
        }
        let button = UIButton(primaryAction: action)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("6", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        return button
    }()
    
    lazy var sevenButton: UIButton = {
        let action = UIAction { _ in
            if self.introducedNumberLabel.text == "0" {
                self.introducedNumberLabel.text = "7"
            } else if self.introducedNumberLabel.text!.count < 9 {
                self.introducedNumberLabel.text? += "7"
                self.checkLabelLength()
            }
        }
        let button = UIButton(primaryAction: action)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("7", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        return button
    }()
    
    lazy var eightButton: UIButton = {
        let action = UIAction { _ in
            if self.introducedNumberLabel.text == "0" {
                self.introducedNumberLabel.text = "8"
            } else if self.introducedNumberLabel.text!.count < 9 {
                self.introducedNumberLabel.text? += "8"
                self.checkLabelLength()
            }
        }
        let button = UIButton(primaryAction: action)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("8", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        return button
    }()
    
    lazy var nineButton: UIButton = {
        let action = UIAction { _ in
            if self.introducedNumberLabel.text == "0" {
                self.introducedNumberLabel.text = "9"
            } else if self.introducedNumberLabel.text!.count < 9 {
                self.introducedNumberLabel.text? += "9"
                self.checkLabelLength()
            }
        }
        let button = UIButton(primaryAction: action)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("9", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        return button
    }()
    
    lazy var equalsButton: UIButton = {
        let action = UIAction {_ in
            self.controller?.sendOperationTypeToCalcManager(operation: .equals, introducedNumber: self.introducedNumberLabel.text!)
        }
        let button = UIButton(primaryAction: action)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("=", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        return button
    }()
    
    lazy var additionButton: UIButton = {
        let action = UIAction {_ in
            self.controller?.sendOperationTypeToCalcManager(operation: .addition, introducedNumber: self.introducedNumberLabel.text!)
        }
        let button = UIButton(primaryAction: action)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("+", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        return button
    }()
    
    lazy var subtractionButton: UIButton = {
        let action = UIAction {_ in
            self.controller?.sendOperationTypeToCalcManager(operation: .subtraction, introducedNumber: self.introducedNumberLabel.text!)
        }
        let button = UIButton(primaryAction: action)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("–", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        return button
    }()
    
    lazy var multiplicationButton: UIButton = {
        let action = UIAction {_ in
            self.controller?.sendOperationTypeToCalcManager(operation: .multiplication, introducedNumber: self.introducedNumberLabel.text!)
        }
        let button = UIButton(primaryAction: action)
        button.setTitle("×", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        return button
    }()
    
    lazy var divisionButton: UIButton = {
        let action = UIAction {_ in
            self.controller?.sendOperationTypeToCalcManager(operation: .division, introducedNumber: self.introducedNumberLabel.text!)
        }
        let button = UIButton(primaryAction: action)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("÷", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        return button
    }()
    
    lazy var percentButton: UIButton = {
        let action = UIAction {_ in
            self.controller?.sendOperationTypeToCalcManager(operation: .percent, introducedNumber: self.introducedNumberLabel.text!)
        }
        let button = UIButton(primaryAction: action)
        button.setTitle("%", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35, weight: .medium)
        return button
    }()

    lazy var reversSignButton: UIButton = {
        let action = UIAction {_ in
            self.controller?.sendOperationTypeToCalcManager(operation: .reverseSign, introducedNumber: self.introducedNumberLabel.text!)
        }
        let button = UIButton(primaryAction: action)
        button.setTitle("+/-", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35, weight: .medium)
        return button
    }()
    
    lazy var clearButton: UIButton = {
        let action = UIAction {_ in
            self.controller?.sendOperationTypeToCalcManager(operation: .clear, introducedNumber: self.introducedNumberLabel.text!)
                }
        let button = UIButton(primaryAction: action)
        button.setTitle("AC", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35, weight: .medium)
        return button
    }()
    
    
    // MARK: - View life cycle methods
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubviews()
        setUpConstraints()
        self.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CalculatorView {
    
    // MARK: - Methods
    
    /// Adds all subviews to main view
    func addSubviews() {
        self.addSubview(zeroButton)
        self.addSubview(commaButton)
        self.addSubview(equalsButton)
        self.addSubview(oneButton)
        self.addSubview(twoButton)
        self.addSubview(threeButton)
        self.addSubview(fourButton)
        self.addSubview(fiveButton)
        self.addSubview(sixButton)
        self.addSubview(sevenButton)
        self.addSubview(eightButton)
        self.addSubview(nineButton)
        self.addSubview(multiplicationButton)
        self.addSubview(divisionButton)
        self.addSubview(percentButton)
        self.addSubview(reversSignButton)
        self.addSubview(subtractionButton)
        self.addSubview(additionButton)
        self.addSubview(clearButton)
        self.addSubview(introducedNumberLabel)
    }
    
    /// Sets up constraints on all UI elements
    func setUpConstraints() {
        setUpZeroButtonConstraints()
        setUpCommaButtonConstraints()
        setUpEqualsButtonConstraints()
        setUpOneButtonConsgtraints()
        setUpTwoButtonConstraints()
        setUpThreeButtonConstraints()
        setUpAdditionButtonConstraints()
        setUpFourButtonConstraints()
        setUpFiveButtonConstraints()
        setUpSixButtonConstraints()
        setUpSubtractionButtonConstraints()
        setUpSevenButtonConstraints()
        setUpEightButtonConstraints()
        setUpNineButtonConstraints()
        setUpMultiplicationButtonConstraints()
        setUpClearButtonConstraints()
        setUpReverseSignButtonConstraints()
        setUpPercentButtonConstraints()
        setUpDivisionButtonConstraints()
        setUpNumbersLabelConstraints()
    }
    
    func setUpZeroButtonConstraints() {
        NSLayoutConstraint.activate([
            zeroButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -bottomDistance),
            zeroButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: distanceBetweenButtons),
            zeroButton.widthAnchor.constraint(equalToConstant: buttonSize*2+distanceBetweenButtons),
            zeroButton.heightAnchor.constraint(equalToConstant: buttonSize),
        ])
    }
    
    func setUpCommaButtonConstraints() {
        NSLayoutConstraint.activate([
            commaButton.leadingAnchor.constraint(equalTo: zeroButton.trailingAnchor, constant: distanceBetweenButtons),
            commaButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -bottomDistance),
            commaButton.widthAnchor.constraint(equalToConstant: buttonSize),
            commaButton.heightAnchor.constraint(equalToConstant: buttonSize)
        ])
    }
    
    func setUpEqualsButtonConstraints() {
        NSLayoutConstraint.activate([
            equalsButton.leadingAnchor.constraint(equalTo: commaButton.trailingAnchor, constant: distanceBetweenButtons),
            equalsButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -bottomDistance),
            equalsButton.widthAnchor.constraint(equalToConstant: buttonSize),
            equalsButton.heightAnchor.constraint(equalToConstant: buttonSize)
        ])
    }
    
    func setUpOneButtonConsgtraints() {
        NSLayoutConstraint.activate([
            oneButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: distanceBetweenButtons),
            oneButton.bottomAnchor.constraint(equalTo: zeroButton.topAnchor, constant: -distanceBetweenButtons),
            oneButton.widthAnchor.constraint(equalToConstant: buttonSize),
            oneButton.heightAnchor.constraint(equalToConstant: buttonSize)
        ])
    }
    
    func setUpTwoButtonConstraints() {
        NSLayoutConstraint.activate([
        twoButton.leadingAnchor.constraint(equalTo: oneButton.trailingAnchor, constant: distanceBetweenButtons),
        twoButton.bottomAnchor.constraint(equalTo: zeroButton.topAnchor, constant: -distanceBetweenButtons),
        twoButton.widthAnchor.constraint(equalToConstant: buttonSize),
        twoButton.heightAnchor.constraint(equalToConstant: buttonSize),
        ])
    }
    
    func setUpThreeButtonConstraints() {
        NSLayoutConstraint.activate([
        threeButton.leadingAnchor.constraint(equalTo: twoButton.trailingAnchor, constant: distanceBetweenButtons),
        threeButton.bottomAnchor.constraint(equalTo: zeroButton.topAnchor, constant: -distanceBetweenButtons),
        threeButton.widthAnchor.constraint(equalToConstant: buttonSize),
        threeButton.heightAnchor.constraint(equalToConstant: buttonSize),
        ])
    }
    
    func setUpAdditionButtonConstraints() {
        NSLayoutConstraint.activate([
        additionButton.leadingAnchor.constraint(equalTo: threeButton.trailingAnchor, constant: distanceBetweenButtons),
        additionButton.bottomAnchor.constraint(equalTo: zeroButton.topAnchor, constant: -distanceBetweenButtons),
        additionButton.widthAnchor.constraint(equalToConstant: buttonSize),
        additionButton.heightAnchor.constraint(equalToConstant: buttonSize),
        ])
    }
    
    func setUpFourButtonConstraints() {
        NSLayoutConstraint.activate([
            fourButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: distanceBetweenButtons),
        fourButton.bottomAnchor.constraint(equalTo: oneButton.topAnchor, constant: -distanceBetweenButtons),
        fourButton.widthAnchor.constraint(equalToConstant: buttonSize),
        fourButton.heightAnchor.constraint(equalToConstant: buttonSize),
        ])
    }
    
    func setUpFiveButtonConstraints() {
        NSLayoutConstraint.activate([
            fiveButton.leadingAnchor.constraint(equalTo: fourButton.trailingAnchor, constant: distanceBetweenButtons),
            fiveButton.bottomAnchor.constraint(equalTo: twoButton.topAnchor, constant: -distanceBetweenButtons),
            fiveButton.widthAnchor.constraint(equalToConstant: buttonSize),
            fiveButton.heightAnchor.constraint(equalToConstant: buttonSize),
        ])
    }
    
    func setUpSixButtonConstraints() {
        NSLayoutConstraint.activate([
            sixButton.leadingAnchor.constraint(equalTo: fiveButton.trailingAnchor, constant: distanceBetweenButtons),
            sixButton.bottomAnchor.constraint(equalTo: threeButton.topAnchor, constant: -distanceBetweenButtons),
            sixButton.widthAnchor.constraint(equalToConstant: buttonSize),
            sixButton.heightAnchor.constraint(equalToConstant: buttonSize),
        ])
    }
    
    func setUpSubtractionButtonConstraints() {
        NSLayoutConstraint.activate([
            subtractionButton.leadingAnchor.constraint(equalTo: sixButton.trailingAnchor, constant: distanceBetweenButtons),
            subtractionButton.bottomAnchor.constraint(equalTo: oneButton.topAnchor, constant: -distanceBetweenButtons),
            subtractionButton.widthAnchor.constraint(equalToConstant: buttonSize),
            subtractionButton.heightAnchor.constraint(equalToConstant: buttonSize),
        ])
    }
    
    func setUpSevenButtonConstraints() {
        NSLayoutConstraint.activate([
            sevenButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: distanceBetweenButtons),
            sevenButton.bottomAnchor.constraint(equalTo: fourButton.topAnchor, constant: -distanceBetweenButtons),
            sevenButton.widthAnchor.constraint(equalToConstant: buttonSize),
            sevenButton.heightAnchor.constraint(equalToConstant: buttonSize),
        ])
    }
    
    func setUpEightButtonConstraints() {
        NSLayoutConstraint.activate([
            eightButton.leadingAnchor.constraint(equalTo: sevenButton.trailingAnchor, constant: distanceBetweenButtons),
            eightButton.bottomAnchor.constraint(equalTo: fourButton.topAnchor, constant: -distanceBetweenButtons),
            eightButton.widthAnchor.constraint(equalToConstant: buttonSize),
            eightButton.heightAnchor.constraint(equalToConstant: buttonSize),
        ])
    }
    
    func setUpNineButtonConstraints() {
        NSLayoutConstraint.activate([
            nineButton.leadingAnchor.constraint(equalTo: eightButton.trailingAnchor, constant: distanceBetweenButtons),
            nineButton.bottomAnchor.constraint(equalTo: fourButton.topAnchor, constant: -distanceBetweenButtons),
            nineButton.widthAnchor.constraint(equalToConstant: buttonSize),
            nineButton.heightAnchor.constraint(equalToConstant: buttonSize),
        ])
    }
    
    func setUpMultiplicationButtonConstraints() {
        NSLayoutConstraint.activate([
            multiplicationButton.leadingAnchor.constraint(equalTo: nineButton.trailingAnchor, constant: distanceBetweenButtons),
            multiplicationButton.bottomAnchor.constraint(equalTo: fourButton.topAnchor, constant: -distanceBetweenButtons),
            multiplicationButton.widthAnchor.constraint(equalToConstant: buttonSize),
            multiplicationButton.heightAnchor.constraint(equalToConstant: buttonSize),
        ])
    }
    
    func setUpClearButtonConstraints() {
        NSLayoutConstraint.activate([
            clearButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: distanceBetweenButtons),
            clearButton.bottomAnchor.constraint(equalTo: sevenButton.topAnchor, constant: -distanceBetweenButtons),
            clearButton.widthAnchor.constraint(equalToConstant: buttonSize),
            clearButton.heightAnchor.constraint(equalToConstant: buttonSize),
        ])
    }
    
    func setUpReverseSignButtonConstraints() {
        NSLayoutConstraint.activate([
            reversSignButton.leadingAnchor.constraint(equalTo: clearButton.trailingAnchor, constant: distanceBetweenButtons),
            reversSignButton.bottomAnchor.constraint(equalTo: sevenButton.topAnchor, constant: -distanceBetweenButtons),
            reversSignButton.widthAnchor.constraint(equalToConstant: buttonSize),
            reversSignButton.heightAnchor.constraint(equalToConstant: buttonSize),
        ])
    }
    
    func setUpPercentButtonConstraints() {
        NSLayoutConstraint.activate([
            percentButton.leadingAnchor.constraint(equalTo: reversSignButton.trailingAnchor, constant: distanceBetweenButtons),
            percentButton.bottomAnchor.constraint(equalTo: sevenButton.topAnchor, constant: -distanceBetweenButtons),
            percentButton.widthAnchor.constraint(equalToConstant: buttonSize),
            percentButton.heightAnchor.constraint(equalToConstant: buttonSize),
        ])
    }
    
    func setUpDivisionButtonConstraints() {
        NSLayoutConstraint.activate([
            divisionButton.leadingAnchor.constraint(equalTo: percentButton.trailingAnchor, constant: distanceBetweenButtons),
            divisionButton.bottomAnchor.constraint(equalTo: sevenButton.topAnchor, constant: -distanceBetweenButtons),
            divisionButton.widthAnchor.constraint(equalToConstant: buttonSize),
            divisionButton.heightAnchor.constraint(equalToConstant: buttonSize),
        ])
    }
    
    func setUpNumbersLabelConstraints() {
        NSLayoutConstraint.activate([
            introducedNumberLabel.bottomAnchor.constraint(equalTo: divisionButton.topAnchor, constant: -distanceBetweenButtons * 2),
            introducedNumberLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -distanceBetweenButtons*2),
            introducedNumberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: distanceBetweenButtons*2),
            introducedNumberLabel.heightAnchor.constraint(equalToConstant: buttonSize)
            
        ])
    }
    
    /// Setting up corner raduis for all buttons
    func setUpCornerRadius() {
        self.subviews
            .filter {type(of: $0) != UILabel.self}
            .forEach {$0.layer.cornerRadius = $0.frame.height / 2}
    }
    
    /// Setting up controller
    func setUpController(controlller: ViewController) {
        self.controller = controlller
    }
    
    /// Updates label by received string
    func updateLabel(text: String) {
        self.introducedNumberLabel.text = text
        checkLabelLength()
    }
    
    /// Returns introducedNumber.text
    func getLabel() -> String {
        introducedNumberLabel.text ?? "0"
    }
    
    /// Updates label font if introducedNumber length increased or decreased
    func checkLabelLength() {
        switch introducedNumberLabel.text!.count {
        case 0...7:
            introducedNumberLabel.font = .systemFont(ofSize: 80, weight: .light)
        case 7:
            introducedNumberLabel.font = .systemFont(ofSize: 80, weight: .light)
        case 8:
            introducedNumberLabel.font = .systemFont(ofSize: 70, weight: .light)
        case 9...100:
            introducedNumberLabel.font = .systemFont(ofSize: 60, weight: .light)
        default:
            return
        }
    }
    
    
}
