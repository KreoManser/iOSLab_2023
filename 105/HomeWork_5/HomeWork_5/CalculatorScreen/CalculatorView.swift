//
//  CalculatorView.swift
//  HomeWork_5
//
//  Created by Камил Хайрутдинов on 06.10.2023.
//

import UIKit

class CalculatorView: UIView {
    // MARK: - UI elements
    
    internal lazy var calculatorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 90)
        label.textColor = .white
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
            leftBracketButtton, rightBracketButtton,
            mcButtton, mPlusButtton, mMinusButtton,
            mrButtton, clearButtton, changeSignButtton,
            percentButtton, divideButtton
        ])
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var leftBracketButtton: UIButton = {
        let button = additionalButtonTemplate(title: "(" )
        return button
    }()
    
    private lazy var rightBracketButtton: UIButton = {
        let button = additionalButtonTemplate(title: ")" )
        return button
    }()
    
    private lazy var mcButtton: UIButton = {
        let button = additionalButtonTemplate(title: "mc" )
        return button
    }()
    
    private lazy var mPlusButtton: UIButton = {
        let button = additionalButtonTemplate(title: "m+" )
        return button
    }()
    
    private lazy var mMinusButtton: UIButton = {
        let button = additionalButtonTemplate(title: "m-" )
        return button
    }()
    
    private lazy var mrButtton: UIButton = {
        let button = additionalButtonTemplate(title: "mr" )
        return button
    }()
    
    private lazy var clearButtton: UIButton = {
        let button = mainButtonTemplate(title: "AC", titleColor: .black, backgroundColor: UIColor.calcLightGray)
        return button
    }()
    
    private lazy var changeSignButtton: UIButton = {
        let button = mainButtonTemplate(title: "+/_", titleColor: .black, backgroundColor: UIColor.calcLightGray)
        return button
    }()
    
    private lazy var percentButtton: UIButton = {
        let button = mainButtonTemplate(title: "%", titleColor: .black, backgroundColor: UIColor.calcLightGray)
                                    
        return button
    }()
    
    private lazy var divideButtton: UIButton = {
        let button = mainButtonTemplate(title: "÷", titleColor: .white , backgroundColor: UIColor.calcVividGamboge)
        return button
    }()
    
    // MARK: - Second row button
    internal lazy var secondRowButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            secondButtton, xDegreeTwoButtton, xDegreeThreeButtton,
            xDegreeYButtton, eDegreeXButtton, tenfoldXButtton,
            sevenButtton, eightButtton, nineButtton, multiplyButtton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var secondButtton: UIButton = {
        let button = additionalButtonTemplate(title: "2ⁿᵈ" )
        return button
    }()
    
    private lazy var xDegreeTwoButtton: UIButton = {
        let button = additionalButtonTemplate(title: "x²" )
        return button
    }()
    
    private lazy var xDegreeThreeButtton: UIButton = {
        let button = additionalButtonTemplate(title: "x³" )
        return button
    }()
    
    private lazy var xDegreeYButtton: UIButton = {
        let button = additionalButtonTemplate(title: "xʸ" )
        return button
    }()
    
    private lazy var eDegreeXButtton: UIButton = {
        let button = additionalButtonTemplate(title: "eˣ" )
        return button
    }()
    
    private lazy var tenfoldXButtton: UIButton = {
        let button = additionalButtonTemplate(title: "10ˣ" )
        return button
    }()
    
    private lazy var sevenButtton: UIButton = {
        let button = mainButtonTemplate(title: "7", titleColor: .white, backgroundColor: UIColor.calcDarkLiver)
        return button
    }()
    
    private lazy var eightButtton: UIButton = {
        let button = mainButtonTemplate(title: "8", titleColor: .white, backgroundColor: UIColor.calcDarkLiver)
        return button
    }()
    
    private lazy var nineButtton: UIButton = {
        let button = mainButtonTemplate(title: "9", titleColor: .white, backgroundColor: UIColor.calcDarkLiver)
                                    
        return button
    }()
    
    private lazy var multiplyButtton: UIButton = {
        let button = mainButtonTemplate(title: "×", titleColor: .white , backgroundColor: UIColor.calcVividGamboge)
        return button
    }()
    
    // MARK: - Third row button
    internal lazy var thirdRowButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            oneDivideXButtton, sqrtTwoXButtton, sqrtThreeXButtton,
            sqrtYXButtton, lnButtton, logTenButtton,
            fourButtton, fiveButtton, sixButtton, minusButtton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var oneDivideXButtton: UIButton = {
        let button = additionalButtonTemplate(title: "1/x" )
        return button
    }()
    
    private lazy var sqrtTwoXButtton: UIButton = {
        let button = additionalButtonTemplate(title: "2√x" )
        return button
    }()
    
    private lazy var sqrtThreeXButtton: UIButton = {
        let button = additionalButtonTemplate(title: "3√x" )
        return button
    }()
    
    private lazy var sqrtYXButtton: UIButton = {
        let button = additionalButtonTemplate(title: "y√x" )
        return button
    }()
    
    private lazy var lnButtton: UIButton = {
        let button = additionalButtonTemplate(title: "ln" )
        return button
    }()
    
    private lazy var logTenButtton: UIButton = {
        let button = additionalButtonTemplate(title: "log₁₀" )
        return button
    }()
    
    private lazy var fourButtton: UIButton = {
        let button = mainButtonTemplate(title: "4", titleColor: .white, backgroundColor: UIColor.calcDarkLiver)
        return button
    }()
    
    private lazy var fiveButtton: UIButton = {
        let button = mainButtonTemplate(title: "5", titleColor: .white, backgroundColor: UIColor.calcDarkLiver)
        return button
    }()
    
    private lazy var sixButtton: UIButton = {
        let button = mainButtonTemplate(title: "6", titleColor: .white, backgroundColor: UIColor.calcDarkLiver)
                                    
        return button
    }()
    
    private lazy var minusButtton: UIButton = {
        let button = mainButtonTemplate(title: "-", titleColor: .white , backgroundColor: UIColor.calcVividGamboge)
        return button
    }() 
    
    // MARK: - Fourth row button
    internal lazy var fourthRowButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            factorialXButtton, sinButtton, cosButtton,
            tanButtton, eButtton, eeButtton, oneButtton,
            twoButtton, threeButtton, plusButtton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var factorialXButtton: UIButton = {
        let button = additionalButtonTemplate(title: "x!" )
        return button
    }()
    
    private lazy var sinButtton: UIButton = {
        let button = additionalButtonTemplate(title: "sin" )
        return button
    }()
    
    private lazy var cosButtton: UIButton = {
        let button = additionalButtonTemplate(title: "cos" )
        return button
    }()
    
    private lazy var tanButtton: UIButton = {
        let button = additionalButtonTemplate(title: "tan" )
        return button
    }()
    
    private lazy var eButtton: UIButton = {
        let button = additionalButtonTemplate(title: "e" )
        return button
    }()
    
    private lazy var eeButtton: UIButton = {
        let button = additionalButtonTemplate(title: "EE" )
        return button
    }()
    
    private lazy var oneButtton: UIButton = {
        let button = mainButtonTemplate(title: "1", titleColor: .white, backgroundColor: UIColor.calcDarkLiver)
        return button
    }()
    
    private lazy var twoButtton: UIButton = {
        let button = mainButtonTemplate(title: "2", titleColor: .white, backgroundColor: UIColor.calcDarkLiver)
        return button
    }()
    
    private lazy var threeButtton: UIButton = {
        let button = mainButtonTemplate(title: "3", titleColor: .white, backgroundColor: UIColor.calcDarkLiver)
                                    
        return button
    }()
    
    private lazy var plusButtton: UIButton = {
        let button = mainButtonTemplate(title: "+", titleColor: .white , backgroundColor: UIColor.calcVividGamboge)
        return button
    }()
    
    // MARK: - Fifth row button
    internal lazy var fifthRowButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            radButtton, sinhButtton, coshButtton,
            tanhButtton, piButtton, randButtton,
            zeroButtton, pointButtton, equalButtton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var radButtton: UIButton = {
        let button = additionalButtonTemplate(title: "Rad")
        return button
    }()
    
    private lazy var sinhButtton: UIButton = {
        let button = additionalButtonTemplate(title: "sinh" )
        return button
    }()
    
    private lazy var coshButtton: UIButton = {
        let button = additionalButtonTemplate(title: "cosh" )
        return button
    }()
    
    private lazy var tanhButtton: UIButton = {
        let button = additionalButtonTemplate(title: "tanh" )
        return button
    }()
    
    private lazy var piButtton: UIButton = {
        let button = additionalButtonTemplate(title: "π" )
        return button
    }()
    
    private lazy var randButtton: UIButton = {
        let button = additionalButtonTemplate(title: "Rand" )
        return button
    }()
    
    private lazy var zeroButtton: UIButton = {
        let button = mainButtonTemplate(title: "0", titleColor: .white, backgroundColor: UIColor.calcDarkLiver)
        return button
    }()
    
    private lazy var pointButtton: UIButton = {
        let button = mainButtonTemplate(title: ",", titleColor: .white, backgroundColor: UIColor.calcDarkLiver)
        return button
    }()
    
    private lazy var equalButtton: UIButton = {
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
    
    // MARK: - Init
    init(viewWidth: CGRect) {
       
        self.viewFrame = viewWidth
        super.init(frame: .zero)
        backgroundColor = .black
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(subviews: mainButtonStackView, calculatorLabel)
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CalculatorView {
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

