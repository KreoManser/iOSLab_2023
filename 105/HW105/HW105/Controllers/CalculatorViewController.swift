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
        let firstNumb = Decimal(string: firstNumb)
        let secondNumb = Decimal(string: secondNumb)
        
        switch action {
        case .sum:
            return calculatorModel.sumAction(
        }
    }
}
