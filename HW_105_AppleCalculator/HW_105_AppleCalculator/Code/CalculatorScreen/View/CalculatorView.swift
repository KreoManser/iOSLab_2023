//
//  CalculatorView.swift
//  HW_105_AppleCalculator
//
//  Created by Артур Миннушин on 08.10.2023.
//

import UIKit

///  Класс для отрисовки нашего класса
class CalculatorView: UIView {
    
    ///  Блок  кнопок для калькулятор,  где мы задаем нанчальные параметры
    lazy var calculatorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 70)
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()
    
    lazy var aCButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("AC", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.backgroundColor = .systemGray3
        return button
    }()
    
    lazy var plusAndMinusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("±", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.backgroundColor = .systemGray3
        return button
    }()
    
    lazy var procentButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("%", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.backgroundColor = .systemGray3
        return button
    }()
    
    lazy var divisionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("÷", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.backgroundColor = .systemOrange
        return button
    }()
    
    lazy var sevenButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("7", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.backgroundColor = .darkGray
        return button
    }()
    
    lazy var eightButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("8", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.backgroundColor = .darkGray
        return button
    }()
    
    lazy var nineButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("9", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.backgroundColor = .darkGray
        return button
    }()
    
    lazy var multiplicationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("⨉", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.backgroundColor = .systemOrange
        return button
    }()
    
    lazy var fourButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("4", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.backgroundColor = .darkGray
        return button
    }()
    
    lazy var fiveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("5", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.backgroundColor = .darkGray
        return button
    }()
    
    lazy var sixButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("6", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.backgroundColor = .darkGray
        return button
    }()
    
    lazy var minusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.backgroundColor = .systemOrange
        return button
    }()
    
    lazy var oneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("1", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.backgroundColor = .darkGray
        return button
    }()
    
    lazy var twoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("2", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.backgroundColor = .darkGray
        return button
    }()
    
    lazy var threeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("3", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.backgroundColor = .darkGray
        return button
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.backgroundColor = .systemOrange
        return button
    }()
    
    lazy var zeroButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("0", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.backgroundColor = .darkGray
        return button
    }()
    
    lazy var doubleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(",", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.backgroundColor = .darkGray
        return button
    }()
    
    lazy var equalsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("=", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.backgroundColor = .systemOrange
        return button
    }()
    
    /// Инициализация всех обектов на экране и проставление всех констренов
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        addSubview(equalsButton)
        addSubview(doubleButton)
        addSubview(zeroButton)
        addSubview(plusButton)
        addSubview(threeButton)
        addSubview(twoButton)
        addSubview(oneButton)
        addSubview(minusButton)
        addSubview(sixButton)
        addSubview(fiveButton)
        addSubview(fourButton)
        addSubview(multiplicationButton)
        addSubview(nineButton)
        addSubview(eightButton)
        addSubview(sevenButton)
        addSubview(divisionButton)
        addSubview(procentButton)
        addSubview(plusAndMinusButton)
        addSubview(aCButton)
        addSubview(calculatorLabel)
        
        NSLayoutConstraint.activate([
            equalsButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            equalsButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            equalsButton.widthAnchor.constraint(lessThanOrEqualToConstant: 80),
            equalsButton.heightAnchor.constraint(equalToConstant: 80),
            
            doubleButton.trailingAnchor.constraint(equalTo: equalsButton.leadingAnchor, constant: -15),
            doubleButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            doubleButton.leadingAnchor.constraint(equalTo: zeroButton.trailingAnchor, constant: 15),
            doubleButton.widthAnchor.constraint(lessThanOrEqualToConstant: 80),
            doubleButton.heightAnchor.constraint(equalToConstant: 80),
            
            zeroButton.trailingAnchor.constraint(equalTo: doubleButton.leadingAnchor, constant: -15),
            zeroButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            zeroButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            zeroButton.heightAnchor.constraint(equalToConstant: 80),
            
            plusButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            plusButton.bottomAnchor.constraint(equalTo: equalsButton.topAnchor, constant: -15),
            plusButton.widthAnchor.constraint(lessThanOrEqualToConstant: 80),
            plusButton.heightAnchor.constraint(equalToConstant: 80),
            
            threeButton.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -15),
            threeButton.bottomAnchor.constraint(equalTo: equalsButton.topAnchor, constant: -15),
            threeButton.leadingAnchor.constraint(equalTo: twoButton.trailingAnchor, constant: 15),
            threeButton.widthAnchor.constraint(lessThanOrEqualToConstant: 80),
            threeButton.heightAnchor.constraint(equalToConstant: 80),
            
            twoButton.trailingAnchor.constraint(equalTo: threeButton.leadingAnchor, constant: -15),
            twoButton.bottomAnchor.constraint(equalTo: equalsButton.topAnchor, constant: -15),
            twoButton.leadingAnchor.constraint(equalTo: oneButton.trailingAnchor, constant: 15),
            twoButton.widthAnchor.constraint(lessThanOrEqualToConstant: 80),
            twoButton.heightAnchor.constraint(equalToConstant: 80),
            
            oneButton.trailingAnchor.constraint(equalTo: twoButton.leadingAnchor, constant: -15),
            oneButton.bottomAnchor.constraint(equalTo: equalsButton.topAnchor, constant: -15),
            oneButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            oneButton.widthAnchor.constraint(lessThanOrEqualToConstant: 80),
            oneButton.heightAnchor.constraint(equalToConstant: 80),
            
            minusButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            minusButton.bottomAnchor.constraint(equalTo: plusButton.topAnchor, constant: -15),
            minusButton.widthAnchor.constraint(lessThanOrEqualToConstant: 80),
            minusButton.heightAnchor.constraint(equalToConstant: 80),
            
            sixButton.trailingAnchor.constraint(equalTo: minusButton.leadingAnchor, constant: -15),
            sixButton.bottomAnchor.constraint(equalTo: plusButton.topAnchor, constant: -15),
            sixButton.leadingAnchor.constraint(equalTo: fiveButton.trailingAnchor, constant: 15),
            sixButton.widthAnchor.constraint(lessThanOrEqualToConstant: 80),
            sixButton.heightAnchor.constraint(equalToConstant: 80),
            
            fiveButton.trailingAnchor.constraint(equalTo: sixButton.leadingAnchor, constant: -15),
            fiveButton.bottomAnchor.constraint(equalTo: plusButton.topAnchor, constant: -15),
            fiveButton.leadingAnchor.constraint(equalTo: fourButton.trailingAnchor, constant: 15),
            fiveButton.widthAnchor.constraint(lessThanOrEqualToConstant: 80),
            fiveButton.heightAnchor.constraint(equalToConstant: 80),
            
            fourButton.trailingAnchor.constraint(equalTo: fiveButton.leadingAnchor, constant: -15),
            fourButton.bottomAnchor.constraint(equalTo: plusButton.topAnchor, constant: -15),
            fourButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            fourButton.widthAnchor.constraint(lessThanOrEqualToConstant: 80),
            fourButton.heightAnchor.constraint(equalToConstant: 80),
            
            multiplicationButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            multiplicationButton.bottomAnchor.constraint(equalTo: minusButton.topAnchor, constant: -15),
            multiplicationButton.widthAnchor.constraint(equalToConstant: 80),
            multiplicationButton.heightAnchor.constraint(equalToConstant: 80),
            
            nineButton.trailingAnchor.constraint(equalTo: multiplicationButton.leadingAnchor, constant: -15),
            nineButton.bottomAnchor.constraint(equalTo: minusButton.topAnchor, constant: -15),
            nineButton.leadingAnchor.constraint(equalTo: eightButton.trailingAnchor, constant: 15),
            nineButton.widthAnchor.constraint(equalToConstant: 80),
            nineButton.heightAnchor.constraint(equalToConstant: 80),
            
            eightButton.trailingAnchor.constraint(equalTo: nineButton.leadingAnchor, constant: -15),
            eightButton.bottomAnchor.constraint(equalTo: minusButton.topAnchor, constant: -15),
            eightButton.leadingAnchor.constraint(equalTo: sevenButton.trailingAnchor, constant: 15),
            eightButton.widthAnchor.constraint(equalToConstant: 80),
            eightButton.heightAnchor.constraint(equalToConstant: 80),
            
            sevenButton.trailingAnchor.constraint(equalTo: eightButton.leadingAnchor, constant: -15),
            sevenButton.bottomAnchor.constraint(equalTo: minusButton.topAnchor, constant: -15),
            sevenButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            sevenButton.widthAnchor.constraint(equalToConstant: 80),
            sevenButton.heightAnchor.constraint(equalToConstant: 80),
            
            divisionButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            divisionButton.bottomAnchor.constraint(equalTo: multiplicationButton.topAnchor, constant: -15),
            divisionButton.widthAnchor.constraint(equalToConstant: 80),
            divisionButton.heightAnchor.constraint(equalToConstant: 80),
            
            procentButton.trailingAnchor.constraint(equalTo: divisionButton.leadingAnchor, constant: -15),
            procentButton.bottomAnchor.constraint(equalTo: multiplicationButton.topAnchor, constant: -15),
            procentButton.leadingAnchor.constraint(equalTo: plusAndMinusButton.trailingAnchor, constant: 15),
            procentButton.widthAnchor.constraint(equalToConstant: 80),
            procentButton.heightAnchor.constraint(equalToConstant: 80),
            
            plusAndMinusButton.trailingAnchor.constraint(equalTo: procentButton.leadingAnchor, constant: -15),
            plusAndMinusButton.bottomAnchor.constraint(equalTo: multiplicationButton.topAnchor, constant: -15),
            plusAndMinusButton.leadingAnchor.constraint(equalTo: aCButton.trailingAnchor, constant: 15),
            plusAndMinusButton.widthAnchor.constraint(equalToConstant: 80),
            plusAndMinusButton.heightAnchor.constraint(equalToConstant: 80),
            
            aCButton.trailingAnchor.constraint(equalTo: plusAndMinusButton.leadingAnchor, constant: -15),
            aCButton.bottomAnchor.constraint(equalTo: multiplicationButton.topAnchor, constant: -15),
            aCButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            aCButton.widthAnchor.constraint(equalToConstant: 80),
            aCButton.heightAnchor.constraint(equalToConstant: 80),
            
            calculatorLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            calculatorLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            calculatorLabel.bottomAnchor.constraint(equalTo: divisionButton.topAnchor, constant: -15),
            calculatorLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        
        equalsButton.layer.cornerRadius = 40
        doubleButton.layer.cornerRadius = 40
        zeroButton.layer.cornerRadius = 40
        plusButton.layer.cornerRadius = 40
        threeButton.layer.cornerRadius = 40
        twoButton.layer.cornerRadius = 40
        oneButton.layer.cornerRadius = 40
        minusButton.layer.cornerRadius = 40
        sixButton.layer.cornerRadius = 40
        fiveButton.layer.cornerRadius = 40
        fourButton.layer.cornerRadius = 40
        multiplicationButton.layer.cornerRadius = 40
        nineButton.layer.cornerRadius = 40
        eightButton.layer.cornerRadius = 40
        sevenButton.layer.cornerRadius = 40
        divisionButton.layer.cornerRadius = 40
        procentButton.layer.cornerRadius = 40
        plusAndMinusButton.layer.cornerRadius = 40
        aCButton.layer.cornerRadius = 40
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
