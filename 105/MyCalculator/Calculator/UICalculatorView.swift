
import UIKit

class UICalculatorView: UIView {
    
    public lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 60)
        textField.textAlignment = .right
        textField.text = "0"
        textField.textColor = .white
        return textField
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    public var dictionaryButton = [String: UIButton]()
    
    public lazy var horizontalTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 30)
        textField.textAlignment = .right
        textField.text = "0"
        textField.textColor = .white
        return textField
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    public var horizontalDictionaryButton = [String: UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupVerticalButton()
        setupHorizontalButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var stringField = ""
    
    func setupVerticalButton() {
        let arraySign = ["÷", "×", "-", "+", "="]
        let characters: [String] = ["C", "±", "%", "÷", "7", "8", "9", "×", "4", "5", "6", "-", "1", "2", "3", "+", "0", ",", "=" ]
        for i in 0..<5 { // Создаем 5 строк кнопок
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.translatesAutoresizingMaskIntoConstraints = false
            rowStackView.spacing = 15
            
            for j in 0..<4 { // В каждой строке создаем 4 кнопки
                let symbolIndex = i * 4 + j
                if symbolIndex < characters.count {
                    let symbol = characters[symbolIndex]
                    let action = UIAction { _ in
                        self.inputNumberAction(symbol: symbol, textField: self.textField)
                    }
                    let button: UIButton = {
                        let button = UIButton(primaryAction: action)
                        button.translatesAutoresizingMaskIntoConstraints = false
                        button.setTitle(symbol, for: .normal)
                        button.setTitleColor(.white, for: .normal)
                        button.backgroundColor = .darkGray
                        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
                        button.layer.masksToBounds = true
                        button.layer.cornerRadius = 40
                        button.setTitleColor(.gray, for: .highlighted)
                        if symbol == "0" {
                            let constraint = button.widthAnchor.constraint(equalToConstant: 180)
                            constraint.priority = UILayoutPriority(751)
                            constraint.isActive = true
                            button.heightAnchor.constraint(equalToConstant: 80).isActive = true
                            button.contentHorizontalAlignment = .left
                            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
                        }
                        else {
                            button.widthAnchor.constraint(equalToConstant: 80).isActive = true
                            button.heightAnchor.constraint(equalToConstant: 80).isActive = true
                        }
                        if arraySign.contains(symbol) {

                            let action = UIAction { _ in
                                self.stringField.append(self.inputSign(symbol: symbol, textField: self.textField))
                            }
                            button.removeAction(action, for: .allTouchEvents)
                        }
                        self.checkSymbolColor(symbol: symbol, button: button)
                        return button
                    }()
                    dictionaryButton[symbol] = button
                    rowStackView.addArrangedSubview(button)
                }
            }
            stackView.addArrangedSubview(rowStackView)
        }
    }
    
    
    
    func setupVerticalLayout() {
    
        addSubview(textField)
        addSubview(stackView)
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 30),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            textField.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
    }
    
    
    func inputNumberAction(symbol: String, textField: UITextField) {
        
        let array = Array(Range(1...9)).map {String($0)}
        guard array.contains(symbol) else { return }
        if symbol == "0" {
            if let currentText = textField.text {
                if currentText != "0" { // Проверка, чтобы не добавлять лишние нули
                    let newText = currentText + symbol
                    self.textField.text = newText
                }
            }
        } else {
            if let currentText = textField.text {
                if currentText == "0" {
                    var newText = currentText
                    newText.remove(at: newText.startIndex)
                    newText += symbol
                    textField.text = newText
                } else {
                    let newText = currentText + symbol
                    textField.text = newText
                }
            }
        }
    }
    
    
    func inputSign(symbol: String, textField: UITextField) -> String {
        guard let currentText = textField.text else { return "" }
        textField.text = ""
        return currentText + symbol
    }
    
    func checkSymbolColor(symbol: String, button: UIButton) {
        if symbol == "C" || symbol == "±" ||  symbol == "%" {
            
            button.backgroundColor = .systemGray2
            button.setTitleColor(.black, for: .normal)
        }
        else if symbol == "÷" || symbol == "×" ||  symbol == "-" || symbol == "+" || symbol == "=" {
            button.backgroundColor = .orange
        }
    }
    
    
    
    func setupHorizontalButton() {
    
        let strings: [String] = ["(", ")", "mc", "m+", "m-", "mr", "C", "±", "%", "÷", "2ⁿᵈ", "x²", "x³", "xʸ", "eˣ", "10ˣ", "7", "8", "9", "×", "¹/ₓ", "²√x", "³√x", "ʸ√x", "ln", "log₁₀", "4", "5", "6", "-", "x!", "sin", "cos", "tan", "e", "EE", "1", "2", "3", "+", "Deg", "sinh", "cosh", "tanh", "π", "Rand", "0", ",", "=" ]
        let stringsUsed: [String] = ["C", "±", "%", "÷", "7", "8", "9", "×", "4", "5", "6", "-", "1", "2", "3", "+", "0", ",", "=" ]
        for i in 0..<5 { // Создаем 5 строк кнопок
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.translatesAutoresizingMaskIntoConstraints = false
            rowStackView.spacing = 10
            
            for j in 0..<10 { // В каждой строке создаем 10 кнопок
                let symbolIndex = i * 10 + j
                
                if symbolIndex < strings.count {
                    let symbol = strings[symbolIndex]
                    let action = UIAction { _ in
                        self.inputNumberAction(symbol: symbol, textField: self.horizontalTextField)
                    }
                    let button: UIButton = {
                        let button = UIButton(primaryAction: action)
                        button.translatesAutoresizingMaskIntoConstraints = false
                        button.setTitle(symbol, for: .normal)
                        button.setTitleColor(.white, for: .normal)
                        button.backgroundColor = .darkGray
                        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                        button.layer.masksToBounds = true
                        button.layer.cornerRadius = 20
                        button.setTitleColor(.gray, for: .highlighted)
                        
                        if symbol == "0" {
                            button.widthAnchor.constraint(equalToConstant: 120).isActive = true
                            button.heightAnchor.constraint(equalToConstant: 40).isActive = true
                            button.contentHorizontalAlignment = .left
                            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
                        }
                        else {
                            let constraint = button.widthAnchor.constraint(equalToConstant: 55)
                            constraint.priority = UILayoutPriority(751)
                            constraint.isActive = true
                            button.heightAnchor.constraint(equalToConstant: 40).isActive = true
                        }
                        self.checkSymbolColor(symbol: symbol, button: button)
                        if !stringsUsed.contains(symbol) {
                            button.removeTarget(nil, action: nil, for: .allEvents)
                        }
                        if symbol == "C" {
                            button.removeTarget(nil, action: #selector(deleteTextField), for: .allEvents)
                        }
                        return button
                    }()
                    horizontalDictionaryButton[symbol] = button
                    rowStackView.addArrangedSubview(button)
                }
            }
            horizontalStackView.addArrangedSubview(rowStackView)
        }
    }
    
    @objc func deleteTextField() {
        self.textField.text = "0"
    }
    
    
    func setupHorizontalLayout() {
        addSubview(horizontalStackView)
        addSubview(horizontalTextField)
        NSLayoutConstraint.activate([
            horizontalTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 30),
            horizontalTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50),
            horizontalTextField.bottomAnchor.constraint(equalTo: horizontalStackView.topAnchor, constant: -5),
            

            horizontalStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 1),
            horizontalStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -1),
            horizontalStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -1)
        ])
    }
    
    func setupLayout(for orientation: UIDeviceOrientation) {
        if orientation.isPortrait {
            setupVerticalLayout()
            stackView.isHidden = false
            textField.isHidden = false
            horizontalStackView.isHidden = true
            horizontalTextField.isHidden = true
        } else if orientation.isLandscape {
            setupHorizontalLayout()
            stackView.isHidden = true
            textField.isHidden = true
            horizontalStackView.isHidden = false
            horizontalTextField.isHidden  = false
        }
    }
}



//protocol UICalculatorViewDelegate: AnyObject {
//    func clickProcessing(dictionaryButton: [String: UIButton])
//}
//
//extension UICalculatorView: UICalculatorViewDelegate {
//    func clickProcessing(dictionaryButton: [String : UIButton]) {
//        dictionaryButton["C
//    }
//    
//    
//}
