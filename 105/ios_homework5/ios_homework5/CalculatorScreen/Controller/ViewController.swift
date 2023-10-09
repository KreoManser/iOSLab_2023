import UIKit

/// The ViewController class that is responsible for managing the view hierarchy of the Calculator app
class ViewController: UIViewController{
    
    /// The main view of the app, which displays the calculator interface.
    lazy var calculatorView: CalculatorView = CalculatorView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        calculatorView.setupLayout(view: self.calculatorView)
    }

    override func loadView() {
        view = calculatorView
    }
}

