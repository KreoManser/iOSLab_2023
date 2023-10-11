//
//  CalculateViewController.swift
//  CalculateApp
//
//  Created by Mac on 2023-10-08.
//

import UIKit

/// Class that describes how to connect via model and view of Calculator screen
class CalculateViewController: UIViewController {
    // MARK: - Declaration objects
    lazy var calculateView = CalculateView(frame: .zero)
    lazy var calculatorModel = CalculateModel()
    
    // MARK: - Load view
    override func loadView() {
        view = calculateView
        calculateView.calculateProtocol = self
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if UIDevice.current.orientation.isLandscape {
            calculateView.setupLayout(orintation: "landscape")
        } else if UIDevice.current.orientation.isPortrait {
            calculateView.setupLayout(orintation: "portrait")
        }
        
        calculateView.layoutIfNeeded()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Custom Delegate
extension CalculateViewController: CalculateProtocol {
    func doOneMoreTime() -> String {
        let endIndex = calculatorModel.history.endIndex
        var previousOp: Operation = Operation(firstNumber: 0, secondNumber: 0, operation: .noOperation, result: "0")
        if calculatorModel.history.count != 0 {
            previousOp = calculatorModel.history[endIndex - 1]
        }
        
        let first = previousOp.result
        let second = String(previousOp.secondNumber)
        let operation = previousOp.operation
        
        let result = calculatorModel.makeCalculation(operation: operation, first: first, second: second)
        
        return result
    }
    
    func changeBecauseOfHistory() -> String {
        let endIndex = calculatorModel.history.endIndex
        var previous = "0"
        if calculatorModel.history.count != 0 {
            previous = calculatorModel.history[endIndex - 1].result
            calculatorModel.history.remove(at: endIndex - 1)
        }
        return previous
    }

    func calculate(operation: OperationType, firstNumber: String, secondNumber: String) -> String {
        calculatorModel.makeCalculation(operation: operation, first: firstNumber, second: secondNumber)
    }
}
