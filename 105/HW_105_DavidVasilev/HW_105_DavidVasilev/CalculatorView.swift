import UIKit

class CalculatorView: UIView {
    
    private lazy var calculatorInputTextField: UITextField = UITextField()
    lazy var cButton : UIButton = {
        var button = createButton(title: "С", color: .lightGray)
        return button
    }()
    lazy var plusMinusButton : UIButton = {
        var button = createButton(title: "+/-", color:.lightGray)
        return button
    }()
    lazy var procentButton : UIButton = {
        var button = createButton(title: "%", color: .lightGray)
        return button
    }()
    lazy var divisionButton : UIButton = {
        var button = createButton(title: "÷", color: .lightOrange)
        return button
    }()
    lazy var multiplicationButton : UIButton = {
        var button = createButton(title: "×", color: .lightOrange)
        return button
    }()
    lazy var sevenButton : UIButton = {
        var button = createButton(title: "7", color: .darkGray)
        return button
    }()
    lazy var eightButton : UIButton = {
        var button = createButton(title: "8", color: .darkGray)
        return button
    }()
    lazy var nineButton : UIButton = {
        var button = createButton(title: "9", color: .darkGray)
        return button
    }()
    lazy var fourButton : UIButton = {
        var button = createButton(title: "4", color: .darkGray)
        return button
    }()
    lazy var fiveButton : UIButton = {
        var button = createButton(title: "5", color: .darkGray)
        return button
    }()
    lazy var sixButton : UIButton = {
        var button = createButton(title: "6", color: .darkGray)
        return button
    }()
    lazy var substractionButton : UIButton = {
        var button =  createButton(title: "-", color: .lightOrange)
        return button
    }()
    lazy var additionButton : UIButton = {
        var button =  createButton(title: "+", color: .lightOrange)
        return button
    }()
    lazy var oneButton : UIButton = {
        var button = createButton(title: "1", color: .darkGray)
        return button
    }()
    lazy var twoButton : UIButton = {
        var button =  createButton(title: "2", color: .darkGray)
        return button
    }()
    lazy var threeButton : UIButton = {
        var button = createButton(title: "3", color: .darkGray)
        return  button
    }()
    lazy var equalButton = UIButton()
    lazy var commaButton = UIButton()
    lazy var zeroButton = UIButton()
    
    private lazy var mainStackView = UIStackView()
    private lazy var firstLineStackView = UIStackView()
    private lazy var secondLineStackView = UIStackView()
    private lazy var thirdLineStackView = UIStackView()
    private lazy var forthLineStackView = UIStackView()
    
    weak var calculatorController: CalculatorViewController?
    
    ///method for accessing text from textField
    func calculatorTextField(with string: String){
        calculatorInputTextField.text = string
    }
    
    ///method to create a button with configuration
    func createButton(title: String, color: UIColor) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = 38
        button.backgroundColor = color
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        return button
    }
    
    // MARK: - initViewSetUp
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(calculatorInputTextField)
        setUp()
        backgroundColor = .black
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setUp
    private func setUp(){
        setUpMainStackView()
        setUpFirstStackView()
        setUpSecondStackView()
        setUpThirdStackView()
        setUpForthStackView()
        setupCalculatorInputTextField()
        setUpLastLine()
    }
    
    private func setupCalculatorInputTextField(){
        addSubview(calculatorInputTextField)
        calculatorInputTextField.text = "0"
        calculatorInputTextField.font = UIFont.systemFont(ofSize: 80, weight: .light)
        calculatorInputTextField.textColor = .white
        calculatorInputTextField.translatesAutoresizingMaskIntoConstraints = false
        calculatorInputTextField.textAlignment = .right
        calculatorInputTextField.adjustsFontSizeToFitWidth = true
        NSLayoutConstraint.activate([
            calculatorInputTextField.bottomAnchor.constraint(equalTo: mainStackView.topAnchor, constant: -20),
            calculatorInputTextField.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -5),
            calculatorInputTextField.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
        ])
    }
    
    private func setUpMainStackView(){
        addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.97),
            mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -100),
            mainStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            mainStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
        ])
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 15
    }
    
    private func setUpSubStackView(with stackView: UIStackView){
        mainStackView.addArrangedSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 15
    }
    
    private func setUpFirstStackView(){
        setUpSubStackView(with: firstLineStackView)
        firstLineStackView.addArrangedSubview(cButton)
        firstLineStackView.addArrangedSubview(plusMinusButton)
        firstLineStackView.addArrangedSubview(procentButton)
        firstLineStackView.addArrangedSubview(divisionButton)
    }
    
    private func setUpSecondStackView(){
        setUpSubStackView(with: secondLineStackView)
        secondLineStackView.addArrangedSubview(sevenButton)
        secondLineStackView.addArrangedSubview(eightButton)
        secondLineStackView.addArrangedSubview(nineButton)
        secondLineStackView.addArrangedSubview(multiplicationButton)
    }
    
    private func setUpThirdStackView(){
        setUpSubStackView(with: thirdLineStackView)
        thirdLineStackView.addArrangedSubview(fourButton)
        thirdLineStackView.addArrangedSubview(fiveButton)
        thirdLineStackView.addArrangedSubview(sixButton)
        thirdLineStackView.addArrangedSubview(substractionButton)
    }
    
    private func setUpForthStackView(){
        setUpSubStackView(with: forthLineStackView)
        forthLineStackView.addArrangedSubview(oneButton)
        forthLineStackView.addArrangedSubview(twoButton)
        forthLineStackView.addArrangedSubview(threeButton)
        forthLineStackView.addArrangedSubview(additionButton)
    }
    
    private func setUpLastLine(){
        setUpZeroButton()
        setUpEqualButton()
        setUpCommaButton()

    }
    
    private func setUpZeroButton(){
        addSubview(zeroButton)
        zeroButton.translatesAutoresizingMaskIntoConstraints = false
        zeroButton.backgroundColor = .darkGray
        zeroButton.setTitle("0", for: .normal)
        zeroButton.setTitleColor(.white, for: .normal)
        zeroButton.layer.cornerRadius = 38
        zeroButton.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        
        NSLayoutConstraint.activate([
            zeroButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.45),
            zeroButton.heightAnchor.constraint(equalToConstant: 78.33),
            zeroButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            zeroButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor)
        ])
    }
    
    private func setUpEqualButton(){
        addSubview(equalButton)
        equalButton.translatesAutoresizingMaskIntoConstraints = false
        equalButton.backgroundColor = .lightOrange
        equalButton.setTitle("=", for: .normal)
        equalButton.setTitleColor(.white, for: .normal)
        equalButton.layer.cornerRadius = 38
        equalButton.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        NSLayoutConstraint.activate([
            equalButton.widthAnchor.constraint(equalToConstant: 80.65),
            equalButton.heightAnchor.constraint(equalToConstant: 78.35),
            equalButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            equalButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
        ])
    }
    
    private func setUpCommaButton(){
        addSubview(commaButton)
        commaButton.translatesAutoresizingMaskIntoConstraints = false
        commaButton.backgroundColor = .darkGray
        commaButton.setTitle(",", for: .normal)
        commaButton.setTitleColor(.white, for: .normal)
        commaButton.layer.cornerRadius = 38
        commaButton.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        NSLayoutConstraint.activate([
            commaButton.widthAnchor.constraint(equalToConstant: 80.65),
            commaButton.heightAnchor.constraint(equalToConstant: 78.35),
            commaButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            commaButton.leadingAnchor.constraint(equalTo: zeroButton.trailingAnchor, constant: 12),
            commaButton.trailingAnchor.constraint(equalTo: equalButton.leadingAnchor, constant: -12)
        ])
    }
}
