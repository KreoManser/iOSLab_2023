//
//  CalculatorView.swift
//  homework_5
//
//  Created by Кирилл Щёлоков on 08.10.2023.
//

import Foundation
import UIKit


class CalculatorView: UIView {
    
    let calculatorViewController = CalculatorViewController()
    
    // MARK: - Closures
    
    var numberButtonTapped: ((Double) -> Void)?
    var operationButtonTapped: ((Operation) -> Void)?
    var equalButtonTapped: (() -> Void)?
    var allClearButtonTapped: (() -> Void)?
    var clearOperationButtonTapped: (() -> Void)?
    var unDoButtonTapped: (() -> Void)?
    var reDoOperationButtonTapped: (() -> Void)?

    // MARK: - Properties
    
    private var currentNumber = "0"

    private lazy var sumLabel = UILabel()
    
    private lazy var cancelButton = UIButton()
    private lazy var plusMinusButton = UIButton()
    private lazy var percentButton = UIButton()
    private lazy var divideButton = UIButton()
    private lazy var sevenButton = UIButton()
    private lazy var eightButton = UIButton()
    private lazy var nineButton = UIButton()
    private lazy var multiplyButton = UIButton()
    private lazy var fourButton = UIButton()
    private lazy var fiveButton = UIButton()
    private lazy var sixButton = UIButton()
    private lazy var minusButton = UIButton()
    private lazy var oneButton = UIButton()
    private lazy var twoButton = UIButton()
    private lazy var threeButton = UIButton()
    private lazy var plusButton = UIButton()
    private lazy var zeroButton = UIButton()
    private lazy var dotButton = UIButton()
    private lazy var equalButton = UIButton()
    
    private lazy var mainStackView = UIStackView()
    private lazy var firstLineStackView = UIStackView()
    private lazy var secondLineStackView = UIStackView()
    private lazy var thirdLineStackView = UIStackView()
    private lazy var forthLineStackView = UIStackView()



    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setUp()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetUp
    
    private func setUp(){
        setUpMainStackView()
        setUpFirstLineStackView()
        setUpSecondLineStackView()
        setUpThirdLineStackView()
        setUpForthLineStackView()
        setUpFifthLine()
        setUpSumLabel()
    }
    
    private func setUpSumLabel(){
        addSubview(sumLabel)
        sumLabel.text = "0"
        sumLabel.font = UIFont.systemFont(ofSize: 80, weight: .light)
        sumLabel.textColor = .white
        sumLabel.translatesAutoresizingMaskIntoConstraints = false
        sumLabel.textAlignment = .right
        sumLabel.adjustsFontSizeToFitWidth = true
        sumLabel.minimumScaleFactor = 0.5
        
        NSLayoutConstraint.activate([
            sumLabel.bottomAnchor.constraint(equalTo: mainStackView.topAnchor, constant: -20),
            sumLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -5),
            sumLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
        ])
    }
    
    private func setUpMainStackView(){
        addSubview(mainStackView)

        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 300),
            mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -100),
            mainStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            mainStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
        ])
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 15
    }
    
    private func setUpFirstLineStackView(){
        configSubStackView(with: firstLineStackView)
        
        setUpCancelButton()
        setUpPlusMinusButton()
        setUpPercentButton()
        setUpDivideButton()
    }
    
    private func setUpSecondLineStackView(){
        configSubStackView(with: secondLineStackView)
        
        setUpSevenButton()
        setUpEightButton()
        setUpNineButton()
        setUpMultiplyButton()
    }
    
    private func setUpThirdLineStackView(){
        configSubStackView(with: thirdLineStackView)
        
        setUpFourButton()
        setUpFiveButton()
        setUpSixButton()
        setUpMinusButton()
    }
    
    private func setUpForthLineStackView(){
        configSubStackView(with: forthLineStackView)
        
        setUpOneButton()
        setUpTwoButton()
        setUpThreeButton()
        setUpPlusButton()
    }
    
    private func setUpFifthLine(){
        setUpZeroButton()
        setUpDotButton()
        setUpEqualButton()

    }
    
    
    private func setUpCancelButton(){
        
        let clearButtonAction = UIAction { [self] _ in
            
            if cancelButton.titleLabel?.text == "AC" {
                currentNumber = "0"
                unselectOperationButtons()
                allClearButtonTapped!()
            } else {
                currentNumber = "0"
                cancelButton.setTitle("AC", for: .normal)
                updateResultText(text: "0")
            }
            
        }
        
        configButton(for: cancelButton, withTitle: "AC", withTitleColor: .black, withButtonColor: .appGrayColor!, to: firstLineStackView,
                     withAction: clearButtonAction)
        
    }
    
    private func setUpPlusMinusButton(){
        configButton(for: plusMinusButton, withTitle: "undo", withTitleColor: .black, withButtonColor: .appGrayColor!, to: firstLineStackView,
                     withAction: UIAction { [self] _ in
            unDoButtonTapped!()
        })
    }
    
    private func setUpPercentButton(){
        configButton(for: percentButton, withTitle: "redo", withTitleColor: .black, withButtonColor: .appGrayColor!, to: firstLineStackView,
                     withAction: UIAction { [self] _ in
            reDoOperationButtonTapped!()
        })
    }
    
    private func setUpDivideButton(){
        configButton(for: divideButton, withTitle: "÷", withTitleColor: .white, withButtonColor: .appOrangeColor!, to: firstLineStackView,
                     withAction: UIAction { [self] _ in
            currentNumber = "0"
            changeButtonColor(for: divideButton)
            operationButtonTapped!(.division)
        })
    }
    
    private func setUpSevenButton(){
        configButton(for: sevenButton, withTitle: "7", withTitleColor: .white, withButtonColor: .appDeepGrayColor!, to: secondLineStackView,
                     withAction: UIAction { [self] _ in
            unselectOperationButtons()
            numberButtonTapped!(getNumberFromButton(sevenButton))
        })
    }
    
    private func setUpEightButton(){
        configButton(for: eightButton, withTitle: "8", withTitleColor: .white, withButtonColor: .appDeepGrayColor!, to: secondLineStackView,
                     withAction: UIAction { [self] _ in
            unselectOperationButtons()
            numberButtonTapped!(getNumberFromButton(eightButton))
        })
    }
    
    private func setUpNineButton(){
        configButton(for: nineButton, withTitle: "9", withTitleColor: .white, withButtonColor: .appDeepGrayColor!, to: secondLineStackView,
                     withAction: UIAction { [self] _ in
            unselectOperationButtons()
            numberButtonTapped!(getNumberFromButton(nineButton))
        })
    }
    
    private func setUpMultiplyButton(){
        configButton(for: multiplyButton, withTitle: "×", withTitleColor: .white, withButtonColor: .appOrangeColor!, to: secondLineStackView,
                     withAction: UIAction { [self] _ in
            currentNumber = "0"
            changeButtonColor(for: multiplyButton)
            operationButtonTapped!(.multiplication)
        })
    }
    
    private func setUpFourButton(){
        configButton(for: fourButton, withTitle: "4", withTitleColor: .white, withButtonColor: .appDeepGrayColor!, to: thirdLineStackView,
                     withAction: UIAction { [self] _ in
            unselectOperationButtons()
            numberButtonTapped!(getNumberFromButton(fourButton))
        })
    }
    
    private func setUpFiveButton(){
        configButton(for: fiveButton, withTitle: "5", withTitleColor: .white, withButtonColor: .appDeepGrayColor!, to: thirdLineStackView,
                     withAction: UIAction { [self] _ in
            unselectOperationButtons()
            numberButtonTapped!(getNumberFromButton(fiveButton))
        })
    }
    
    private func setUpSixButton(){
        configButton(for: sixButton, withTitle: "6", withTitleColor: .white, withButtonColor: .appDeepGrayColor!, to: thirdLineStackView,
                     withAction: UIAction { [self] _ in
            unselectOperationButtons()
            numberButtonTapped!(getNumberFromButton(sixButton))
        })
    }
    
    private func setUpMinusButton(){
        configButton(for: minusButton, withTitle: "—", withTitleColor: .white, withButtonColor: .appOrangeColor!, to: thirdLineStackView,
                     withAction: UIAction { [self] _ in
            currentNumber = "0"
            changeButtonColor(for: minusButton)
            operationButtonTapped!(.subtraction)
        })
    }
    
    private func setUpOneButton(){
        configButton(for: oneButton, withTitle: "1", withTitleColor: .white, withButtonColor: .appDeepGrayColor!, to: forthLineStackView,
                     withAction: UIAction { [self] _ in
            unselectOperationButtons()
            numberButtonTapped!(getNumberFromButton(oneButton))
        })
    }
    
    private func setUpTwoButton(){
        configButton(for: twoButton, withTitle: "2", withTitleColor: .white, withButtonColor: .appDeepGrayColor!, to: forthLineStackView,
                     withAction: UIAction { [self] _ in
            unselectOperationButtons()
            numberButtonTapped!(getNumberFromButton(twoButton))
        })
    }
    
    private func setUpThreeButton(){
        configButton(for: threeButton, withTitle: "3", withTitleColor: .white, withButtonColor: .appDeepGrayColor!, to: forthLineStackView,
                     withAction: UIAction { [self] _ in
            unselectOperationButtons()
            numberButtonTapped!(getNumberFromButton(threeButton))
        })
    }
    
    private func setUpPlusButton(){
        configButton(for: plusButton, withTitle: "+", withTitleColor: .white, withButtonColor: .appOrangeColor!, to: forthLineStackView,
                     withAction: UIAction { [self] _ in
            currentNumber = "0"
            changeButtonColor(for: plusButton)
            operationButtonTapped!(.addition)
        })
    }
    
    private func setUpZeroButton(){
        addSubview(zeroButton)
        zeroButton.translatesAutoresizingMaskIntoConstraints = false
        zeroButton.backgroundColor = .appDeepGrayColor
        zeroButton.setTitle("0", for: .normal)
        zeroButton.setTitleColor(.white, for: .normal)
        zeroButton.layer.cornerRadius = 38
        zeroButton.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        
        NSLayoutConstraint.activate([
            zeroButton.widthAnchor.constraint(equalToConstant: 176.34),
            zeroButton.heightAnchor.constraint(equalToConstant: 78.33),
            zeroButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            zeroButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor)
        ])
        
        zeroButton.addAction(UIAction { [self] _ in
            numberButtonTapped!(getNumberFromButton(zeroButton))
            unselectOperationButtons()
        }, for: .touchUpInside)
    }
    
    private func setUpDotButton(){
        addSubview(dotButton)
        dotButton.translatesAutoresizingMaskIntoConstraints = false
        dotButton.backgroundColor = .appDeepGrayColor
        dotButton.setTitle(".", for: .normal)
        dotButton.setTitleColor(.white, for: .normal)
        dotButton.layer.cornerRadius = 38
        dotButton.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        
        NSLayoutConstraint.activate([
            dotButton.widthAnchor.constraint(equalToConstant: 80.67),
            dotButton.heightAnchor.constraint(equalToConstant: 78.33),
            dotButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            dotButton.leadingAnchor.constraint(equalTo: zeroButton.trailingAnchor, constant: 15)
        ])
        
        dotButton.addAction(UIAction { [self] _ in
            numberButtonTapped!(getNumberFromButton(dotButton))
            unselectOperationButtons()
        }, for: .touchUpInside)
    }
    
    private func setUpEqualButton(){
        addSubview(equalButton)
        equalButton.translatesAutoresizingMaskIntoConstraints = false
        equalButton.backgroundColor = .appOrangeColor
        equalButton.setTitle("=", for: .normal)
        equalButton.setTitleColor(.white, for: .normal)
        equalButton.layer.cornerRadius = 38
        equalButton.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        
        NSLayoutConstraint.activate([
            equalButton.widthAnchor.constraint(equalToConstant: 80.67),
            equalButton.heightAnchor.constraint(equalToConstant: 78.33),
            equalButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            equalButton.leadingAnchor.constraint(equalTo: dotButton.trailingAnchor, constant: 15)
        ])
        
        equalButton.addAction(UIAction { [self] _ in
            currentNumber = "0"
            equalButtonTapped!()
        }, for: .touchUpInside)
    }
    
    // MARK: - Configs
    
    private func configButton(for button : UIButton, withTitle title: String, withTitleColor titleColor: UIColor, withButtonColor color: UIColor, to stackView: UIStackView, withAction action: UIAction){
        stackView.addArrangedSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = color
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.layer.cornerRadius = 38
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        
        button.addAction(action, for: .touchUpInside)
    }
    
    private func configSubStackView(with stackView: UIStackView){
        mainStackView.addArrangedSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 15
    }
    
    // MARK: - Functions
    
    /// Method return a number from button's title
    /// - Parameter button: Button, whose title will return
    /// - Returns: number from button's title
    private func getNumberFromButton(_ button: UIButton) -> Double {
        let number = button.titleLabel?.text ?? "0"
        if currentNumber == "0" {
            currentNumber = number
        } else {
            currentNumber += number
        }

        sumLabel.text = "\(currentNumber)"
        cancelButton.setTitle("C", for: .normal)
        return Double(currentNumber) ?? 0
    }
    
    
    /// Method update resulting textLabel with the new data
    /// - Parameter text: new data for label
    func updateResultText(text: String) {
        
        guard let number = Double(text) else {
            sumLabel.text = text
            return
        }
            let intValue = Int(number)

            if number == Double(intValue) {
                sumLabel.text = "\(intValue)"
            } else {
                sumLabel.text = "\(number)"
            }
        }
    
    /// Method change button's background color and title color between two colors: Orange and White
    /// - Parameter button: button, whose parameters will be change
    private func changeButtonColor(for button: UIButton){
        if button.backgroundColor == .appOrangeColor{
            button.backgroundColor = .white
            button.setTitleColor(.appOrangeColor, for: .normal)
        } else {
            button.backgroundColor = .appOrangeColor
            button.setTitleColor(.white, for: .normal)
            clearOperationButtonTapped!()
        }
    }
    
    /// Method resets button selections
    private func unselectOperationButtons(){
        multiplyButton.backgroundColor = .appOrangeColor
        minusButton.backgroundColor = .appOrangeColor
        plusButton.backgroundColor = .appOrangeColor
        equalButton.backgroundColor = .appOrangeColor
        divideButton.backgroundColor = .appOrangeColor
        
        multiplyButton.setTitleColor(.white, for: .normal)
        minusButton.setTitleColor(.white, for: .normal)
        plusButton.setTitleColor(.white, for: .normal)
        equalButton.setTitleColor(.white, for: .normal)
        divideButton.setTitleColor(.white, for: .normal)
    }
    
}

