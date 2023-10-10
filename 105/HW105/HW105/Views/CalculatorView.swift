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
}

class CalculatorView: UIView {
    private lazy var calcResultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 80)
        label.textColor = .white
        label.textAlignment = .right
        label.isUserInteractionEnabled = true
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var leftBracketButton: UIButton = {
        let button = horizontalButtonBuilder(title: "(")
        return button
    }()
    
    private lazy var rightBracketButton: UIButton = {
        let button = horizontalButtonBuilder(title: ")")
        return button
    }()
    
    private lazy var mcButton: UIButton = {
        let button = horizontalButtonBuilder(title: "mc")
        return button
    }()
    
    private lazy var mPlusButton: UIButton = {
        let button = horizontalButtonBuilder(title: "m+")
        return button
    }()
    
    private lazy var mMinusButton: UIButton = {
        let button = horizontalButtonBuilder(title: "m-")
        return button
    }()
    
    private lazy var mrButton: UIButton = {
        let button = horizontalButtonBuilder(title: "mr")
        return button
    }()
    
    private lazy var firstAddRowStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [leftBracketButton, rightBracketButton, mcButton, mPlusButton, mMinusButton, mrButton])
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 10
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var clearButton: UIButton = mainButtonBuilder("C", backgroundColor: .calcLightGrayColor, textColor: .black)
    private lazy var changeButton: UIButton = mainButtonBuilder("+/-", backgroundColor: .calcLightGrayColor, textColor: .black)
    private lazy var percentButton: UIButton = mainButtonBuilder("%", backgroundColor: .calcLightGrayColor, textColor: .black)
    private lazy var divButton: UIButton = mainButtonBuilder("÷", backgroundColor: .calcOrangeColor, textColor: .white)
    
    private lazy var firstRowStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [clearButton, changeButton, percentButton, divButton])
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 10
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var secButton: UIButton = {
        let button = horizontalButtonBuilder(title: "2ⁿᵈ")
        return button
    }()
    
    private lazy var degreeTwoButton: UIButton = {
        let button = horizontalButtonBuilder(title: "x²")
        return button
    }()
    
    private lazy var degreeThreeButton: UIButton = {
        let button = horizontalButtonBuilder(title: "x³")
        return button
    }()
    
    private lazy var degreeYButton: UIButton = {
        let button = horizontalButtonBuilder(title: "xʸ")
        return button
    }()
    
    private lazy var eDegreeXButton: UIButton = {
        let button = horizontalButtonBuilder(title: "eˣ")
        return button
    }()
    
    private lazy var tenDegreeXButton: UIButton = {
        let button = horizontalButtonBuilder(title: "10ˣ")
        return button
    }()
    
    private lazy var secondAddRowStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews:[secButton, degreeTwoButton, degreeThreeButton, degreeYButton, eDegreeXButton, tenDegreeXButton])
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 10
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
        stack.spacing = 10
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var oneDivideXButton: UIButton = {
        let button = horizontalButtonBuilder(title: "1/x")
        return button
    }()
    
    private lazy var sqrtTwoXButton: UIButton = {
        let button = horizontalButtonBuilder(title: "2√x")
        return button
    }()
    
    private lazy var sqrtThreeXButton: UIButton = {
        let button = horizontalButtonBuilder(title: "3√x")
        return button
    }()
    
    private lazy var sqrtYXButton: UIButton = {
        let button = horizontalButtonBuilder(title: "y√x")
        return button
    }()
    
    private lazy var lnButton: UIButton = {
        let button = horizontalButtonBuilder(title: "ln")
        return button
    }()
    
    private lazy var lgButton: UIButton = {
        let button = horizontalButtonBuilder(title: "log₁₀" )
        return button
    }()
    
    private lazy var thirdAddRowStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [oneDivideXButton, sqrtTwoXButton, sqrtThreeXButton, sqrtYXButton, lnButton, lgButton])
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 10
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
        stack.spacing = 10
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var factorialXButton: UIButton = {
        let button = horizontalButtonBuilder(title: "x!")
        return button
    }()
    
    private lazy var sinButton: UIButton = {
        let button = horizontalButtonBuilder(title: "sin")
        return button
    }()
    
    private lazy var cosButton: UIButton = {
        let button = horizontalButtonBuilder(title: "cos")
        return button
    }()
    
    private lazy var tanButton: UIButton = {
        let button = horizontalButtonBuilder(title: "tan")
        return button
    }()
    
    private lazy var eButton: UIButton = {
        let button = horizontalButtonBuilder(title: "e")
        return button
    }()
    
    private lazy var eeButton: UIButton = {
        let button = horizontalButtonBuilder(title: "EE" )
        return button
    }()
    
    private lazy var fourthAddRowStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [factorialXButton, sinButton, cosButton, tanButton, eButton, eeButton])
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 10
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
        stack.spacing = 10
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var radButton: UIButton = {
        let button = horizontalButtonBuilder(title: "Rad")
        return button
    }()
    
    private lazy var sinhButton: UIButton = {
        let button = horizontalButtonBuilder(title: "sinh")
        return button
    }()
    
    private lazy var coshButton: UIButton = {
        let button = horizontalButtonBuilder(title: "cosh")
        return button
    }()
    
    private lazy var tanhButton: UIButton = {
        let button = horizontalButtonBuilder(title: "tanh")
        return button
    }()
    
    private lazy var piButton: UIButton = {
        let button = horizontalButtonBuilder(title: "π")
        return button
    }()
    
    private lazy var randButton: UIButton = {
        let button = horizontalButtonBuilder(title: "Rand")
        return button
    }()
    
    private lazy var fithAddRowStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [radButton, sinhButton, coshButton, tanhButton, piButton, randButton])
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 10
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var zeroButton: UIButton = mainButtonBuilder("0", backgroundColor: .calcDarkGrayColor, textColor: .white)
    private lazy var pointButton: UIButton = mainButtonBuilder(".", backgroundColor: .calcDarkGrayColor, textColor: .white)
    private lazy var equalButton: UIButton = mainButtonBuilder("=", backgroundColor: .calcOrangeColor, textColor: .white)
    
    private lazy var fithRowStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [zeroButton, pointButton, equalButton])
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 10
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var mainStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [firstRowStack, secondRowStack, thirdRowStack, fourthRowStack])
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 10
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var addStack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [firstAddRowStack, secondAddRowStack, thirdAddRowStack, fourthAddRowStack, fithAddRowStack])
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 10
        stack.axis = .vertical
        return stack
    }()
    
    weak var calculatorHandle: (CalculatorHandle)?
    private var firstNumb: String?
    private var secondNumb: String?
    private var action: Action?
    private var mainButtons: [UIButton]?
    private var addButtons: [UIButton]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        
        verticalSetupLayout()
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// make view's layout setup
    func verticalSetupLayout() {
        removeAllSubviews(for: self)
        removeAllConstraints(for: self)
        
        backgroundColor = .black
        
        addSubview(calcResultLabel)
        addSubview(mainStack)
        addSubview(zeroButton)
        addSubview(pointButton)
        addSubview(equalButton)
        
        mainButtons?.forEach({ button in
            if button.titleLabel?.text != "0" {
                NSLayoutConstraint.activate([
                    button.widthAnchor.constraint(equalToConstant: (frame.width-60)/4),
                    button.heightAnchor.constraint(equalToConstant: (frame.width-60)/4)
                ])
            } else {
                NSLayoutConstraint.activate([
                    button.heightAnchor.constraint(equalToConstant: (frame.width-60)/4),
                    button.widthAnchor.constraint(equalToConstant: (frame.width-60)/2 + 10)
                ])
            }
        })
//
        NSLayoutConstraint.activate([
            calcResultLabel.bottomAnchor.constraint(equalTo: mainStack.topAnchor, constant: -10),
            calcResultLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            calcResultLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            mainStack.bottomAnchor.constraint(equalTo: zeroButton.topAnchor, constant: -10),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            zeroButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            zeroButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),

            pointButton.leadingAnchor.constraint(equalTo: zeroButton.trailingAnchor, constant: 10),
            pointButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),

            equalButton.leadingAnchor.constraint(equalTo: pointButton.trailingAnchor, constant: 10),
            equalButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            
        ])
    }
    
    func horizontalSetupLayout() {
        removeAllSubviews(for: self)
        removeAllConstraints(for: self)
        
        mainButtons?.forEach({ button in
            if button.titleLabel?.text != "0" {
                NSLayoutConstraint.activate([
                    button.widthAnchor.constraint(equalToConstant: (frame.height-120)/10),
                    button.heightAnchor.constraint(equalToConstant: (frame.height-80)/5)
                ])
            } else {
                NSLayoutConstraint.activate([
                    button.heightAnchor.constraint(equalToConstant: (frame.height-80)/5),
                    button.widthAnchor.constraint(equalToConstant: (frame.height-120)/5 + 5)
                ])
            }
        })
        backgroundColor = .black
        
        addSubview(calcResultLabel)
        addSubview(addStack)
        addSubview(mainStack)
        addSubview(zeroButton)
        addSubview(pointButton)
        addSubview(equalButton)
        
        NSLayoutConstraint.activate([
            calcResultLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            calcResultLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            calcResultLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            mainStack.bottomAnchor.constraint(equalTo: calcResultLabel.topAnchor, constant: 10),
            mainStack.leadingAnchor.constraint(equalTo: addStack.trailingAnchor, constant: 15),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            addStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            addStack.widthAnchor.constraint(equalToConstant: 700),
            addStack.topAnchor.constraint(equalTo: calcResultLabel.topAnchor, constant: 10),
            
            zeroButton.topAnchor.constraint(equalTo: mainStack.topAnchor, constant: 10),
            zeroButton.leadingAnchor.constraint(equalTo: addStack.trailingAnchor, constant: 10),

            pointButton.leadingAnchor.constraint(equalTo: zeroButton.trailingAnchor, constant: 10),
            pointButton.topAnchor.constraint(equalTo: mainStack.topAnchor, constant: 10),

            equalButton.leadingAnchor.constraint(equalTo: pointButton.trailingAnchor, constant: 10),
            equalButton.topAnchor.constraint(equalTo: mainStack.topAnchor, constant: 10),
            
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
                self.calcResultLabel.text! += "9"
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
            self.firstNumb = nil
            self.secondNumb = nil
        }
        equalButton.addAction(equalButtonAction, for: .touchUpInside)
    }
}

extension CalculatorView {
    /// private function to easy bulid vertical buttons
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
        button.layer.cornerRadius = (frame.width-60) / 8
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
//        if button.titleLabel?.text != "0" {
//            NSLayoutConstraint.activate([
//                button.widthAnchor.constraint(equalToConstant: (frame.width-60)/4),
//                button.heightAnchor.constraint(equalToConstant: (frame.width-60)/4)
//            ])
//        } else {
//            NSLayoutConstraint.activate([
//                button.heightAnchor.constraint(equalToConstant: (frame.width-60)/4),
//                button.widthAnchor.constraint(equalToConstant: (frame.width-60)/2 + 10)
//            ])
//        }
        mainButtons?.append(button)
        return button
    }
    
    /// private function to easy bulid horizontal buttons
    /// - Parameters:
    ///   - title: future button title
    /// - Returns: new horizontal button
    private func horizontalButtonBuilder(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .calcAddDarkGrayColor
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = (frame.height-120) / 20
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        mainButtons?.append(button)
        addButtons?.append(button)
        return button
    }
    
    /// vertical screen position configuration
    func verticalButtonsConfig() {
        addButtons?.forEach{ $0.isHidden = true }
        
        calcResultLabel.font = UIFont.systemFont(ofSize: 80)
        
        verticalSetupLayout()
    }
    
    /// horizontall screen position configuration
    func horizontalButtonsConfig() {
        addButtons?.forEach{ $0.isHidden = false }
        
        calcResultLabel.font = UIFont.systemFont(ofSize: 65)
        
        horizontalSetupLayout()
    }
    
    private func removeAllConstraints(for view: UIView) {
        view.removeConstraints(view.constraints)
        
        for subview in view.subviews {
            removeAllConstraints(for: subview)
        }
    }
    
    private func removeAllSubviews(for view: UIView) {
        for subview in view.subviews {
            subview.removeFromSuperview()
        }
    }
}

extension UIColor {
    static let calcOrangeColor = UIColor(red: 239/255, green: 133/255, blue: 26/255, alpha: 1)
    static let calcLightGrayColor = UIColor(red: 211/255, green: 206/255, blue: 201/255, alpha: 1)
    static let calcDarkGrayColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
    static let calcAddDarkGrayColor = UIColor(red: 35/255, green: 36/255, blue: 37/255, alpha: 1)
}
