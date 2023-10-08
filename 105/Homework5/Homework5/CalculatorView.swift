//
//  CalculatorView.swift
//  Homework5
//
//  Created by kerik on 07.10.2023.
//

import UIKit

class CalculatorView: UIView {
    private lazy var calculatorLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 70)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// StackView with all buttons
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            createHorizontalStackView(buttons: [
                clearButtton,
                signButton,
                percentButtton,
                divideButtton], distibution: .fillEqually),
            createHorizontalStackView(buttons: [
                sevenButtton,
                eightButtton,
                nineButtton,
                multiplyButtton
            ], distibution: .fillEqually),
            createHorizontalStackView(buttons: [
                fourButtton,
                fiveButtton,
                sixButton,
                minusButtton
            ], distibution: .fillEqually),
            createHorizontalStackView(buttons: [
                oneButtton,
                twoButtton,
                threeButton,
                plusButtton
            ], distibution: .fillEqually),
            fifthRowButtonStackView
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var clearButtton: UIButton = {
        let button = createButton(title: "AC", titleColor: .black, buttonColor: .systemGray)
        let clearButtonAction: UIAction = UIAction { [weak self] _ in
            
        }
        return button
    }()
    
    private lazy var signButton: UIButton = {
        let button = createButton(title: "+/-", titleColor: .black, buttonColor: .systemGray)
        return button
    }()
    
    private lazy var percentButtton: UIButton = {
        let button = createButton(title: "%", titleColor: .black, buttonColor: .systemGray)
        
        return button
    }()
    
    private lazy var divideButtton: UIButton = {
        let button = createButton(title: "÷", titleColor: .white , buttonColor: .systemOrange)
        return button
    }()
    
    private lazy var sevenButtton: UIButton = {
        let button = createButton(title: "7", titleColor: .white, buttonColor: .darkGray)
        return button
    }()
    
    private lazy var eightButtton: UIButton = {
        let button = createButton(title: "8", titleColor: .white, buttonColor: .darkGray)
        return button
    }()
    
    private lazy var nineButtton: UIButton = {
        let button = createButton(title: "9", titleColor: .white, buttonColor: .darkGray)
        return button
    }()
    
    private lazy var multiplyButtton: UIButton = {
        let button = createButton(title: "×", titleColor: .white , buttonColor: UIColor.systemOrange)
        return button
    }()
    
    private lazy var fourButtton: UIButton = {
        let button = createButton(title: "4", titleColor: .white, buttonColor: .darkGray)
        return button
    }()
    
    private lazy var fiveButtton: UIButton = {
        let button = createButton(title: "5", titleColor: .white, buttonColor: .darkGray)
        return button
    }()
    
    private lazy var sixButton: UIButton = {
        let button = createButton(title: "6", titleColor: .white, buttonColor: .darkGray)
        return button
    }()
    
    private lazy var minusButtton: UIButton = {
        let button = createButton(title: "-", titleColor: .white , buttonColor: UIColor.systemOrange)
        return button
    }()
    
    private lazy var oneButtton: UIButton = {
        let button = createButton(title: "1", titleColor: .white, buttonColor: .darkGray)
        return button
    }()
    
    private lazy var twoButtton: UIButton = {
        let button = createButton(title: "2", titleColor: .white, buttonColor: .darkGray)
        return button
    }()
    
    private lazy var threeButton: UIButton = {
        let button = createButton(title: "3", titleColor: .white, buttonColor: .darkGray)
        return button
    }()
    
    private lazy var plusButtton: UIButton = {
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
    
    private var viewFrame: CGRect
    var buttons: [UIButton] = []
    
    init(viewWidth: CGRect) {
        
        viewFrame = viewWidth
        
        super.init(frame: .zero)
        backgroundColor = .black
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(subviews: calculatorLabel ,buttonStackView)
        setLayout()
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
        let button = UIButton(configuration: .filled())
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
