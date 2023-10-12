//
//  ViewController.swift
//  HW_105_AppleCalculator
//
//  Created by Артур Миннушин on 07.10.2023.
//

import UIKit

/// Класс Controller, связующий для model и view
class CalculatorViewController: UIViewController {
    
    ///  Экземпляра класса View
    var calcView: CalculatorView = CalculatorView(frame: .zero)
    ///  Экземпляр класс Model
    var calcModel: MafmaticOperationManager = MafmaticOperationManager()
    
    /// Запуск экрана и присвоение его view для более простой раоты
    override func loadView() {
        view = calcView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calcView.calculateExmpl = self
    }
}
/// Это связующий компонент  между view  и  controller
extension CalculatorViewController: Calculte {
    func Calculate(operations: Operations, firstIndex: String, secondIndex: String) -> String {
        
        let firstEllment = Decimal(string: firstIndex)
        let secondeEllment = Decimal(string: secondIndex)
        
        switch operations {
        case .plus:
            return calcModel.plusClosure(firstEllment!, secondeEllment!)
        case .minus:
            return calcModel.minusClosure(firstEllment!, secondeEllment!)
        case .multyply:
            return calcModel.miltiplactionClosure(firstEllment!, secondeEllment!)
        case .devide:
            return calcModel.divisionClosure(firstEllment!, secondeEllment ?? 0)
        case .nilOpertion:
            return "0"
        }
    }
}

