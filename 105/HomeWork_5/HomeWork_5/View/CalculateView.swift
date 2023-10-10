//
//  CalculateView.swift
//  HomeWork_5
//
//  Created by Нияз Ризванов on 08.10.2023.
//

import UIKit

/// Класс(View) отвечающий за отображение
class CalculateView: UIView {
    
    /// Слабая ссылка на CalculateViewController
    weak var calculateController: CalculateViewController?
    
    /// Замыкание для обновления resultLabel
    lazy var updateResultLabel: (String) -> Void = { [weak self] result in
            self?.resultLabel.text = result
        }
    
    lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 65)
        label.text = "0"
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    lazy var clearButton: UIButton = {
        let action = UIAction { _ in
            self.calculateController?.operatorButtonPressed("AC")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "AC")
        button.backgroundColor = .lightGray
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var plusAndMinusButton: UIButton = {
        let action = UIAction { _ in
            self.calculateController?.operatorButtonPressed("+/-")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "+/-")
        button.backgroundColor = .lightGray
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var percentButton: UIButton = {
        let action = UIAction { _ in
            self.calculateController?.operatorButtonPressed("%")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "%")
        button.backgroundColor = .lightGray
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var divisionButton: UIButton = {
        let action = UIAction { _ in
            self.calculateController?.operatorButtonPressed("/")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "/")
        button.backgroundColor = .orange
        return button
    }()
    
    lazy var multiplyButton: UIButton = {
        let action = UIAction { _ in
            self.calculateController?.operatorButtonPressed("x")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "x")
        button.backgroundColor = .orange
        return button
    }()
    
    lazy var addiButton: UIButton = {
        let action = UIAction { _ in
            self.calculateController?.operatorButtonPressed("+")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "+")
        button.backgroundColor = .orange
        return button
    }()
    
    lazy var subtractButton: UIButton = {
        let action = UIAction { _ in
            self.calculateController?.operatorButtonPressed("-")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "-")
        button.backgroundColor = .orange
        return button
    }()
    
    lazy var equalButton: UIButton = {
        let action = UIAction { _ in
            self.calculateController?.operatorButtonPressed("=")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "=")
        button.backgroundColor = .orange
        return button
    }()
    
    lazy var oneButton: UIButton = {
        let action = UIAction { _ in
            self.calculateController?.digitButtonPressed("1")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "1")
        button.backgroundColor = .darkGray
        return button
    }()
    
    lazy var twoButton: UIButton = {
        let action = UIAction { _ in
            self.calculateController?.digitButtonPressed("2")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "2")
        button.backgroundColor = .darkGray
        return button
    }()
    
    lazy var threeButton: UIButton = {
        let action = UIAction { _ in
            self.calculateController?.digitButtonPressed("3")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "3")
        button.backgroundColor = .darkGray
        return button
    }()
    
    lazy var fourButton: UIButton = {
        let action = UIAction { _ in
            self.calculateController?.digitButtonPressed("4")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "4")
        button.backgroundColor = .darkGray
        return button
    }()
    
    lazy var fiveButton: UIButton = {
        let action = UIAction { _ in
            self.calculateController?.digitButtonPressed("5")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "5")
        button.backgroundColor = .darkGray
        return button
    }()
    
    lazy var sixButton: UIButton = {
        let action = UIAction { _ in
            self.calculateController?.digitButtonPressed("6")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "6")
        button.backgroundColor = .darkGray
        return button
    }()
    
    lazy var sevenButton: UIButton = {
        let action = UIAction { _ in
            self.calculateController?.digitButtonPressed("7")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "7")
        button.backgroundColor = .darkGray
        return button
    }()
    
    lazy var eightButton: UIButton = {
        let action = UIAction { _ in
            self.calculateController?.digitButtonPressed("8")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "8")
        button.backgroundColor = .darkGray
        return button
    }()
    lazy var nineButton: UIButton = {
        let action = UIAction { _ in
            self.calculateController?.digitButtonPressed("9")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, "9")
        button.backgroundColor = .darkGray
        return button
    }()
    lazy var zeroButton: UIButton = {
        let action = UIAction { _ in
            self.calculateController?.digitButtonPressed("0")
        }
        let button = UIButton(primaryAction: action)
        button.setTitle("0", for: .normal)
        button.backgroundColor = .darkGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 28
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        return button
    }()
    
    lazy var commaButton: UIButton = {
        let action = UIAction { _ in
            self.calculateController?.digitButtonPressed(",")
        }
        let button = UIButton(primaryAction: action)
        configureButton(button, ",")
        button.backgroundColor = .darkGray
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        
        let stackViewForButton1 = UIStackView(arrangedSubviews: [
            clearButton, plusAndMinusButton, percentButton, divisionButton
        ])
        configureForStackViewButtonHorizontal(stackViewForButton1)
        
        let stackViewForButton2 = UIStackView(arrangedSubviews: [
            sevenButton, eightButton, nineButton, multiplyButton
        ])
        configureForStackViewButtonHorizontal(stackViewForButton2)
        
        let stackViewForButton3 = UIStackView(arrangedSubviews: [
            fourButton, fiveButton, sixButton, subtractButton
        ])
        configureForStackViewButtonHorizontal(stackViewForButton3)
        
        let stackViewForButton4 = UIStackView(arrangedSubviews: [
            oneButton, twoButton, threeButton, addiButton
        ])
        configureForStackViewButtonHorizontal(stackViewForButton4)
        
        let stackViewForButton5 = UIStackView(arrangedSubviews: [
            zeroButton, commaButton, equalButton
        ])
        configureForStackViewButtonHorizontal(stackViewForButton5)
        
        let mainStackView = UIStackView(arrangedSubviews: [
            resultLabel, stackViewForButton1, stackViewForButton2, stackViewForButton3, stackViewForButton4, stackViewForButton5
        ])
        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mainStackView)

        NSLayoutConstraint.activate([
            mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }
    
    private var configureButton: (UIButton, String) -> Void = { button, symbol in
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(symbol, for: .normal)
        //button.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        button.layer.cornerRadius = 28
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        button.setTitleColor(.white, for: .normal)
    }
    
    private var configureForStackViewButtonHorizontal: (UIStackView) -> Void  = { stackView in
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
