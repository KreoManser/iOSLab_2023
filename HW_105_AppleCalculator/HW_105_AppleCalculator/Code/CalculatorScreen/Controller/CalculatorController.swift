//
//  ViewController.swift
//  HW_105_AppleCalculator
//
//  Created by Артур Миннушин on 07.10.2023.
//

import UIKit

protocol LoginController: AnyObject {
    func callMeFromView()
}

/// Класс Controller, связующий для model и view
class CalculatorViewController: UIViewController {
    
    /// Переменная для передачи нашего экрана
    lazy var calcView: CalculatorView = CalculatorView(frame: .zero)
    
    /// Хапуск экрана и присвоение его view для более простой раоты
    override func loadView() {
        view = calcView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

