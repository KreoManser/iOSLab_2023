import UIKit

class CalculatorViewController: UIViewController {
    
    lazy var calculatorView: CalculatorView = CalculatorView(frame: .zero)
    var model = CalculatorModel()
    var currentNumber = ""
    var firstValue = 0.0
    var secondValue = 0.0
    var recordingNewNumber = false
    var currentAction = ""
    var previousAction = ""
    
    ///switch case with operations
    func actionsCases(){
        switch previousAction{
        case "+":
            firstValue = Double(model.addition(firstValue,secondValue))!
            secondValue =  0.0
            currentNumber = ""
        case "-":
            firstValue = Double(model.substraction(firstValue,secondValue))!
            secondValue =  0.0
            currentNumber = ""
        case "÷":
            firstValue = Double(model.division(firstValue,secondValue))!
            secondValue =  0.0
            currentNumber = ""
        case "×":
            firstValue = Double(model.multiplication(firstValue,secondValue))!
            secondValue =  0.0
            currentNumber = ""
        case "=":
            secondValue =  0.0
            currentNumber = ""
        default:
            break
        }
    }
    
    ///method writes the number that the user enters
    @objc func writingNumberAction(_ sender: UIButton) {

        let title = sender.titleLabel?.text
        if recordingNewNumber{
            currentNumber.append(title!)
            calculatorView.calculatorTextField(with: currentNumber)
        }
        else {
            recordingNewNumber = true
            currentNumber.append(title!)
            calculatorView.calculatorTextField(with: currentNumber)
        }
    }
    
    ///method for manage all operations
    @objc func manageOperationAction(_ sender: UIButton) {
        let title = sender.titleLabel?.text
        recordingNewNumber = false
        previousAction = currentAction
        currentAction = title!
        if firstValue == 0.0 {
            firstValue = Double(currentNumber) ?? 0.0
            currentNumber = ""
        }
        else if secondValue == 0.0{
            secondValue = Double(currentNumber) ?? 0.0
            actionsCases()
            calculatorView.calculatorTextField(with: model.type(firstValue))
        }
    }
    // MARK: - loadViews
    override func viewDidLoad() {
        super.viewDidLoad()
        loadView()
    }
    
    override func loadView() {
        view = calculatorView
    }

    // MARK: - add action
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addTargetForOperationButton()
        addTargetForNumbersButton()
    }
    /// adds an operation actions to the buttons
    func addTargetForOperationButton(){
        calculatorView.additionButton.addTarget(self, action: #selector(manageOperationAction(_:)), for: .touchUpInside)
        calculatorView.substractionButton.addTarget(self, action: #selector(manageOperationAction(_:)), for: .touchUpInside)
        calculatorView.multiplicationButton.addTarget(self, action: #selector(manageOperationAction(_:)), for: .touchUpInside)
        calculatorView.divisionButton.addTarget(self, action: #selector(manageOperationAction(_:)), for: .touchUpInside)
        calculatorView.equalButton.addTarget(self, action: #selector(manageOperationAction(_:)), for: .touchUpInside)
    }
    /// adds an number action to the buttons
    func addTargetForNumbersButton(){
        calculatorView.zeroButton.addTarget(self, action: #selector(writingNumberAction(_:)), for: .touchUpInside)
        calculatorView.oneButton.addTarget(self, action: #selector(writingNumberAction(_:)), for: .touchUpInside)
        calculatorView.twoButton.addTarget(self, action: #selector(writingNumberAction(_:)), for: .touchUpInside)
        calculatorView.threeButton.addTarget(self, action: #selector(writingNumberAction(_:)), for: .touchUpInside)
        calculatorView.fourButton.addTarget(self, action: #selector(writingNumberAction(_:)), for: .touchUpInside)
        calculatorView.fiveButton.addTarget(self, action: #selector(writingNumberAction(_:)), for: .touchUpInside)
        calculatorView.sixButton.addTarget(self, action: #selector(writingNumberAction(_:)), for: .touchUpInside)
        calculatorView.sevenButton.addTarget(self, action: #selector(writingNumberAction(_:)), for: .touchUpInside)
        calculatorView.eightButton.addTarget(self, action: #selector(writingNumberAction(_:)), for: .touchUpInside)
        calculatorView.nineButton.addTarget(self, action: #selector(writingNumberAction(_:)), for: .touchUpInside)
    }
}
