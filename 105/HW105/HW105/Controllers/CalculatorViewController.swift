import UIKit

class CalculatorViewController: UIViewController {
    private var calculatorView: CalculatorView!
    private var calculatorModel: CalculatorModel = CalculatorModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCalculatorView()
    }
}

extension CalculatorViewController {
    /// connect CalculatorView with CalculatorViewController
    private func setupCalculatorView() {
        view.backgroundColor = .black
        
        calculatorView = CalculatorView(frame: view.frame)
        view.addSubview(calculatorView)
        calculatorView.calculatorHandle = self
    }
}

extension CalculatorViewController: CalculatorHandle {
    func calculate(action: Action, firstNumb: String, secondNumb: String) -> String {
        let firstNumb = Decimal(string: firstNumb) ?? 0
        let secondNumb = Decimal(string: secondNumb) ?? 0
        
        switch action {
        case .sum:
            return calculatorModel.sumAction(firstNumb, secondNumb)
        case .diff:
            return calculatorModel.diffAction(firstNumb, secondNumb)
        case .mult:
            return calculatorModel.multAction(firstNumb, secondNumb)
        case .div:
            return calculatorModel.divAction(firstNumb, secondNumb)
        }
    }
}
