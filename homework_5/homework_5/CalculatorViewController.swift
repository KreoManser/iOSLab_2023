import UIKit

// Связи между CalculateView и CalculateOperation
class CalculatorViewController: UIViewController {

    lazy var calculatorView = CalculateView(frame: .zero)
    var calculatorOperation = CalculatorOperations()

    override func loadView() {
        super.loadView()
        view = calculatorView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        calculatorView.calculatorController = self
    }
    /// Замыкания
    
    //Замыкание для кнопок с цифрами
    lazy var digitButtonPressed: (String) -> Void = { [weak self] digit in
        self?.calculatorOperation.appendDigit?(digit)
        self?.updateView()
    }

    // Замыкание для кнопок операторов
    lazy var operatorButtonPressed: (String) -> Void = { [weak self] operation in
        self?.calculatorOperation.performOperation?(operation)
        self?.updateView()
    }

    // Замыкание для обновления представления после изменений в модели
    lazy var updateView: () -> Void = { [weak self] in
        let result = self?.calculatorOperation.getResult?() ?? "0"
        self?.calculatorView.updateResultLabel(result)
    }
}
