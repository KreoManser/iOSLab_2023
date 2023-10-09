import UIKit

protocol CalculatorHandle: AnyObject {
    /// function to calculate the result of some entered action
    /// - Parameters:
    ///   - action: one of Action enum action
    ///   - firstNumb: first entered number
    ///   - secondNumb: second entered number
    /// - Returns: returns calculated result
    func calculate(action: Action, firstNumb: String, secondNumb: String) -> String
}

enum Action {
    case sum
    case diff
    case mult
    case div
    case empty
}

class CalculatorView: UIView {
    private lazy var calcResultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 80)
        label.textColor = .white
        label.textAlignment = .right
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var clearButton: UIButton = mainButtonBuilder("C", backgroundColor: .calcLightGrayColor, textColor: .black)
    private lazy var changeButton: UIButton = mainButtonBuilder("+/-", backgroundColor: .calcLightGrayColor, textColor: .black)
    private lazy var percentButton: UIButton = mainButtonBuilder("%", backgroundColor: .calcLightGrayColor, textColor: .black)
    private lazy var divButton: UIButton = mainButtonBuilder("÷", backgroundColor: .calcOrangeColor, textColor: .white)
    
    private lazy var firstRowStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [clearButton, changeButton, percentButton, divButton])
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 15
        stack.axis = .horizontal
        return stack
    }()

    private lazy var sevenButton: UIButton = mainButtonBuilder("7", backgroundColor: .calcDarkGrayColor, textColor: .white)
    private lazy var eightButton: UIButton = mainButtonBuilder("8", backgroundColor: .calcDarkGrayColor, textColor: .white)
    private lazy var nineButton: UIButton = mainButtonBuilder("9", backgroundColor: .calcDarkGrayColor, textColor: .white)
    private lazy var multButton: UIButton = mainButtonBuilder("×", backgroundColor: .calcOrangeColor, textColor: .white)
    
    private lazy var secondRowStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews:[sevenButton, eightButton, nineButton, multButton])
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 15
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var fourButton: UIButton = mainButtonBuilder("4", backgroundColor: .calcDarkGrayColor, textColor: .white)
    private lazy var fiveButton: UIButton = mainButtonBuilder("5", backgroundColor: .calcDarkGrayColor, textColor: .white)
    private lazy var sixButton: UIButton = mainButtonBuilder("6", backgroundColor: .calcDarkGrayColor, textColor: .white)
    private lazy var diffButton: UIButton = mainButtonBuilder("-", backgroundColor: .calcOrangeColor, textColor: .white)
    
    private lazy var thirdRowStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [fourButton, fiveButton, sixButton, diffButton])
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 15
        stack.axis = .horizontal
        return stack
    }()

    private lazy var oneButton: UIButton = mainButtonBuilder("1", backgroundColor: .calcDarkGrayColor, textColor: .white)
    private lazy var twoButton: UIButton = mainButtonBuilder("2", backgroundColor: .calcDarkGrayColor, textColor: .white)
    private lazy var threeButton: UIButton = mainButtonBuilder("3", backgroundColor: .calcDarkGrayColor, textColor: .white)
    private lazy var sumButton: UIButton = mainButtonBuilder("+", backgroundColor: .calcOrangeColor, textColor: .white)
    
    private lazy var fourthRowStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [oneButton, twoButton, threeButton, sumButton])
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 15
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var mainStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [firstRowStack, secondRowStack, thirdRowStack, fourthRowStack])
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 15
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var zeroButton: UIButton = mainButtonBuilder("0", backgroundColor: .calcDarkGrayColor, textColor: .white)
    private lazy var pointButton: UIButton = mainButtonBuilder(".", backgroundColor: .calcDarkGrayColor, textColor: .white)
    private lazy var equalButton: UIButton = mainButtonBuilder("=", backgroundColor: .calcOrangeColor, textColor: .white)
    
    weak var calculatorHandle: (CalculatorHandle)?
    private var firstNumb: String?
    private var secondNumb: String?
    private var action: Action?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        
        setupLayout()
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// make view's layout setup
    func setupLayout() {
        backgroundColor = .black
        
        addSubview(calcResultLabel)
        addSubview(mainStack)
        addSubview(zeroButton)
        addSubview(pointButton)
        addSubview(equalButton)
        
        NSLayoutConstraint.activate([
            calcResultLabel.bottomAnchor.constraint(equalTo: mainStack.topAnchor, constant: -15),
            calcResultLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            calcResultLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            mainStack.bottomAnchor.constraint(equalTo: zeroButton.topAnchor, constant: -15),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            zeroButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            zeroButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),

            pointButton.leadingAnchor.constraint(equalTo: zeroButton.trailingAnchor, constant: 15),
            pointButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),

            equalButton.leadingAnchor.constraint(equalTo: pointButton.trailingAnchor, constant: 15),
            equalButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            
        ])
    }
    
    /// implements the logic of pressing all buttons
    func setupAction() {
        let clearButtonAction: UIAction = UIAction { [weak self] _ in
            guard let self else { return }
            self.calcResultLabel.text = "0"
        }
        clearButton.addAction(clearButtonAction, for: .touchUpInside)
        
        let changeButtonAction: UIAction = UIAction { [weak self] _ in
            guard let self else { return }
            if (self.calcResultLabel.text != nil && self.calcResultLabel.text != "0"){
                if ((self.calcResultLabel.text!.hasPrefix("-"))) {
                    self.calcResultLabel.text!.removeFirst()
                } else {
                    self.calcResultLabel.text = "-" + self.calcResultLabel.text!
                }
            }
        }
        changeButton.addAction(changeButtonAction, for: .touchUpInside)
        
        let divButtonAction: UIAction = UIAction { [weak self] _ in
            guard let self else { return }
            self.firstNumb = self.calcResultLabel.text
            self.action = .div
            self.calcResultLabel.text = ""
        }
        divButton.addAction(divButtonAction, for: .touchUpInside)
        
        let multButtonAction: UIAction = UIAction { [weak self] _ in
            guard let self else { return }
            self.firstNumb = self.calcResultLabel.text
            self.action = .mult
            self.calcResultLabel.text = ""
        }
        multButton.addAction(multButtonAction, for: .touchUpInside)
        
        let sumButtonAction: UIAction = UIAction { [weak self] _ in
            guard let self else { return }
            self.firstNumb = self.calcResultLabel.text
            self.action = .sum
            self.calcResultLabel.text = ""
        }
        sumButton.addAction(sumButtonAction, for: .touchUpInside)
        
        let diffButtonAction: UIAction = UIAction { [weak self] _ in
            guard let self else { return }
            self.firstNumb = self.calcResultLabel.text
            self.action = .diff
            self.calcResultLabel.text = ""
        }
        diffButton.addAction(diffButtonAction, for: .touchUpInside)
        
        let nineButtonAction: UIAction = UIAction { [weak self] _ in
            guard let self else { return }
            if self.calcResultLabel.text == "0" {
                self.calcResultLabel.text = "9"
            }
            else {
                self.calcResultLabel.text! += ""
            }
        }
        nineButton.addAction(nineButtonAction, for: .touchUpInside)
        
        let eightButtonAction: UIAction = UIAction { [weak self] _ in
            guard let self else { return }
            if self.calcResultLabel.text == "0" {
                self.calcResultLabel.text = "8"
            }
            else {
                self.calcResultLabel.text! += "8"
            }
        }
        eightButton.addAction(eightButtonAction, for: .touchUpInside)
        
        let sevenButtonAction: UIAction = UIAction { [weak self] _ in
            guard let self else { return }
            if self.calcResultLabel.text == "0" {
                self.calcResultLabel.text = "7"
            }
            else {
                self.calcResultLabel.text! += "7"
            }
        }
        sevenButton.addAction(sevenButtonAction, for: .touchUpInside)
        
        let sixButtonAction: UIAction = UIAction { [weak self] _ in
            guard let self else { return }
            if self.calcResultLabel.text == "0" {
                self.calcResultLabel.text = "6"
            }
            else {
                self.calcResultLabel.text! += "6"
            }
        }
        sixButton.addAction(sixButtonAction, for: .touchUpInside)
        
        let fiveButtonAction: UIAction = UIAction { [weak self] _ in
            guard let self else { return }
            if self.calcResultLabel.text == "0" {
                self.calcResultLabel.text = "5"
            }
            else {
                self.calcResultLabel.text! += "5"
            }
        }
        fiveButton.addAction(fiveButtonAction, for: .touchUpInside)
        
        let fourButtonAction: UIAction = UIAction { [weak self] _ in
            guard let self else { return }
            if self.calcResultLabel.text == "0" {
                self.calcResultLabel.text = "4"
            }
            else {
                self.calcResultLabel.text! += "4"
            }
        }
        fourButton.addAction(fourButtonAction, for: .touchUpInside)
        
        let threeButtonAction: UIAction = UIAction { [weak self] _ in
            guard let self else { return }
            if self.calcResultLabel.text == "0" {
                self.calcResultLabel.text = "3"
            }
            else {
                self.calcResultLabel.text! += "3"
            }
        }
        threeButton.addAction(threeButtonAction, for: .touchUpInside)
        
        let twoButtonAction: UIAction = UIAction { [weak self] _ in
            guard let self else { return }
            if self.calcResultLabel.text == "0" {
                self.calcResultLabel.text = "2"
            }
            else {
                self.calcResultLabel.text! += "2"
            }
        }
        twoButton.addAction(twoButtonAction, for: .touchUpInside)
        
        let oneButtonAction: UIAction = UIAction { [weak self] _ in
            guard let self else { return }
            if self.calcResultLabel.text == "0" {
                self.calcResultLabel.text = "1"
            }
            else {
                self.calcResultLabel.text! += "1"
            }
        }
        oneButton.addAction(oneButtonAction, for: .touchUpInside)
        
        let zeroButtonAction: UIAction = UIAction { [weak self] _ in
            guard let self else { return }
            if self.calcResultLabel.text != "0" {
                self.calcResultLabel.text! += "0"
            }
        }
        zeroButton.addAction(zeroButtonAction, for: .touchUpInside)
        
        let pointButtonAction: UIAction = UIAction { [weak self] _ in
            guard let self else { return }
            if (!self.calcResultLabel.text!.contains(".")) {
                self.calcResultLabel.text! += "."
            }
        }
        pointButton.addAction(pointButtonAction, for: .touchUpInside)
        
        let equalButtonAction: UIAction = UIAction { [weak self] _ in
            guard let self else { return }
            self.secondNumb = self.calcResultLabel.text!
            guard let firstNumb = self.firstNumb, let action = self.action, let secondNumb = self.secondNumb else { return }
            self.calcResultLabel.text = self.calculatorHandle?.calculate(action: action, firstNumb: firstNumb, secondNumb: secondNumb)
        }
        equalButton.addAction(equalButtonAction, for: .touchUpInside)
    }
}

extension CalculatorView {
    /// private function to easy bulid main buttons
    /// - Parameters:
    ///   - title: future button title
    ///   - backgroundColor: future button bg color
    /// - Returns: new main button
    private func mainButtonBuilder(_ title: String, backgroundColor:UIColor, textColor:UIColor) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.tintColor = .white
        button.backgroundColor = backgroundColor
        button.setTitleColor(textColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
        button.layer.cornerRadius = (frame.width-75) / 8
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        if title != "0" {
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: (frame.width-75)/4),
                button.heightAnchor.constraint(equalToConstant: (frame.width-75)/4)
            ])
            
        } else {
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: (frame.width-75)/4),
                button.widthAnchor.constraint(equalToConstant: (frame.width-75)/2 + 15)
            ])
        }
        return button
    }
}

extension UIColor {
    static let calcOrangeColor = UIColor(red: 239/255, green: 133/255, blue: 26/255, alpha: 1)
    static let calcLightGrayColor = UIColor(red: 211/255, green: 206/255, blue: 201/255, alpha: 1)
    static let calcDarkGrayColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
}
