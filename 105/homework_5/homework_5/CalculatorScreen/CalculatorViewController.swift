//
//  ViewController.swift
//  homework_5
//
//  Created by Кирилл Щёлоков on 08.10.2023.
//

import UIKit

class CalculatorViewController: UIViewController {

    // MARK: - Properties
        
        private var calculatorView: CalculatorView!
        private var calculatorModel: CalculatorModel!
        
        // MARK: - View Lifecycle
    
    /// Transplatation of actions between View and Model
        override func viewDidLoad() {
            super.viewDidLoad()
            
            setupCalculatorView()
            calculatorModel = CalculatorModel()
            
            calculatorView.numberButtonTapped = { [weak self] number in
                self?.calculatorModel.appendNumber(number)
            }
            
            calculatorView.operationButtonTapped = { [weak self] operation in
                self?.calculatorModel.performOperation(operation)
            }
            
            calculatorView.clearOperationButtonTapped = { [weak self] in
                self?.calculatorModel.clearOperation()
            }
            
            calculatorView.unDoButtonTapped = { [weak self] in
                self?.calculatorModel.undo(completion: { result in
                    DispatchQueue.main.async {
                        self?.calculatorView.updateResultText(text: result)
                    }
                })
            }
            
            calculatorView.reDoOperationButtonTapped = { [weak self] in
                self?.calculatorModel.redo(completion: { result in
                    DispatchQueue.main.async {
                        self?.calculatorView.updateResultText(text: result)
                    }
                })
            }
            
            calculatorView.equalButtonTapped = { [weak self] in
                self?.calculatorModel.calculateResult() { result in
                    DispatchQueue.main.async {
                        self?.calculatorView.updateResultText(text: result)
                    }
                }
            }
            
            calculatorView.allClearButtonTapped = { [weak self] in
                self?.calculatorModel.clear()
                self?.calculatorView.updateResultText(text: "0")
            }
        }
        
        // MARK: - Setup
        
        private func setupCalculatorView() {
            calculatorView = CalculatorView(frame: view.bounds)
            view.addSubview(calculatorView)
        }

}

