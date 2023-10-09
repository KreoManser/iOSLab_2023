//
//  CalculatorView.swift
//  HW_105
//
//  Created by Азат Зиганшин on 08.10.2023.
//

import UIKit

class CalculatorView: UIView {

    lazy var displayLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 70)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var ACButton: UIButton = {
        return createButton("AC", UIColor.black, UIColor.systemGray)
    }()
    
    lazy var plusMinusButton: UIButton = {
        return createButton("±", UIColor.black, UIColor.systemGray)
    }()
    
    lazy var percentButton: UIButton = {
        return createButton("%", UIColor.black, UIColor.systemGray)
    }()
    
    lazy var oneButton: UIButton = {
        return createButton("1", UIColor.white, UIColor(red: 49/255, green: 49/255, blue: 49/255, alpha: 1.0))
    }()
    
    lazy var twoButton: UIButton = {
        return createButton("2", UIColor.white, UIColor(red: 49/255, green: 49/255, blue: 49/255, alpha: 1.0))
    }()
    
    lazy var threeButton: UIButton = {
        return createButton("3", UIColor.white, UIColor(red: 49/255, green: 49/255, blue: 49/255, alpha: 1.0))
    }()
    
    lazy var fourButton: UIButton = {
        return createButton("4", UIColor.white, UIColor(red: 49/255, green: 49/255, blue: 49/255, alpha: 1.0))
    }()
    
    lazy var fiveButton: UIButton = {
        return createButton("5", UIColor.white, UIColor(red: 49/255, green: 49/255, blue: 49/255, alpha: 1.0))
    }()
    
    lazy var sixButton: UIButton = {
        return createButton("6", UIColor.white, UIColor(red: 49/255, green: 49/255, blue: 49/255, alpha: 1.0))
    }()
    
    lazy var sevenButton: UIButton = {
        return createButton("7", UIColor.white, UIColor(red: 49/255, green: 49/255, blue: 49/255, alpha: 1.0))
    }()
    
    lazy var eightButton: UIButton = {
        return createButton("8", UIColor.white, UIColor(red: 49/255, green: 49/255, blue: 49/255, alpha: 1.0))
    }()
    
    lazy var nineButton: UIButton = {
        return createButton("9", UIColor.white, UIColor(red: 49/255, green: 49/255, blue: 49/255, alpha: 1.0))
    }()
    
    lazy var zeroButton: UIButton = {
        return createButton("0", UIColor.white, UIColor(red: 49/255, green: 49/255, blue: 49/255, alpha: 1.0))
    }()
    
    lazy var divisionButton: UIButton = {
        return createButton("÷", UIColor.white, UIColor.systemOrange)
    }()
    
    lazy var multiplicationButton: UIButton = {
        return createButton("×", UIColor.white, UIColor.systemOrange)
    }()
    
    lazy var minusButton: UIButton = {
        return createButton("-", UIColor.white, UIColor.systemOrange)
    }()
    
    lazy var plusButton: UIButton = {
        return createButton("+", UIColor.white, UIColor.systemOrange)
    }()
    
    lazy var equalButton: UIButton = {
        return createButton("=", UIColor.white, UIColor.systemOrange)
    }()
    
    lazy var dotButton: UIButton = {
        return createButton(".", UIColor.white, UIColor(red: 49/255, green: 49/255, blue: 49/255, alpha: 1.0))
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Creates a button to observe DRY
    let createButton: ((String, UIColor, UIColor) -> UIButton) = {title, titleColor, backgroundColor in
        
//        var config = UIButton.Configuration.plain()
//        config.title = title
//        config.baseForegroundColor = titleColor
//        config.background.backgroundColor = backgroundColor
//        config.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30)
        
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        button.backgroundColor = backgroundColor
        button.setTitleColor(titleColor, for: .normal)
        button.layer.cornerRadius = 40
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

extension CalculatorView {
    
    /// Creates stackview to observe DRY
    /// - Parameter views: set of elements for stackview
    /// - Returns: new stackview
    func createStackView(views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        return stackView
    }
    
    /// Adds elements to the screen, creates constraints
    func setupLayout() {
        
        let firstRowStackView = createStackView(views: [ACButton, plusMinusButton, percentButton, divisionButton])
        let secondRowStackView = createStackView(views: [sevenButton, eightButton, nineButton, multiplicationButton])
        let thirdRowStackView = createStackView(views: [fourButton, fiveButton, sixButton, minusButton])
        let fourthRowStackView = createStackView(views: [oneButton, twoButton, threeButton, plusButton])
        let fiveRowStackView = createStackView(views: [zeroButton, dotButton, equalButton])

        addSubview(fiveRowStackView)
        addSubview(fourthRowStackView)
        addSubview(firstRowStackView)
        addSubview(secondRowStackView)
        addSubview(thirdRowStackView)
        addSubview(displayLabel)

        NSLayoutConstraint.activate([
            fiveRowStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            fiveRowStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            equalButton.leadingAnchor.constraint(equalTo: plusButton.leadingAnchor),
            dotButton.leadingAnchor.constraint(equalTo: threeButton.leadingAnchor),
            
            fourthRowStackView.bottomAnchor.constraint(equalTo: fiveRowStackView.topAnchor, constant: -10),
            fourthRowStackView.centerXAnchor.constraint(equalTo: centerXAnchor),

            thirdRowStackView.bottomAnchor.constraint(equalTo: fourthRowStackView.topAnchor, constant: -10),
            thirdRowStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            secondRowStackView.bottomAnchor.constraint(equalTo: thirdRowStackView.topAnchor, constant: -10),
            secondRowStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            firstRowStackView.bottomAnchor.constraint(equalTo: secondRowStackView.topAnchor, constant: -10),
            firstRowStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            displayLabel.bottomAnchor.constraint(equalTo: firstRowStackView.topAnchor, constant: -10),
            displayLabel.trailingAnchor.constraint(equalTo: divisionButton.trailingAnchor),
        ])
        
        setupButtonsSize(constant: 80)
    }
    
    /// Changes the size of elements due to constraint
    /// - Parameter constant: The value of the height and width of the element
    func setupButtonsSize(constant: CGFloat)
    {
        let views: [UIView] = [ACButton, plusMinusButton, percentButton, divisionButton, multiplicationButton, plusButton, minusButton, equalButton, dotButton, oneButton, twoButton, threeButton, fourButton, fiveButton, sixButton, sevenButton, eightButton, nineButton]
        views.forEach {
            NSLayoutConstraint.activate([
                $0.heightAnchor.constraint(equalToConstant: constant),
                $0.widthAnchor.constraint(equalToConstant: constant)
            ])
        }
    }
}
