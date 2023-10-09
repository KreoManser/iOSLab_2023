//
//  ViewController.swift
//  HomeWork_5
//
//  Created by Нияз Ризванов on 08.10.2023.
//

import UIKit

/// Класс контроллер
/// Прописаны основные связи между CalculateView и CalculateOperation
class CalculateViewController: UIViewController {
    
    lazy var calculateView = CalculateView(frame: .zero)
    var calculateOperation = CalculateOperation()
    
    override func loadView() {
        super.loadView()
        view = calculateView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        calculateView.calculateController = self
    }

    /// Замыкание для кнопок с цифрами
    lazy var digitButtonPressed: (String) -> Void = { [weak self] digit in
        self?.calculateOperation.appendDigit?(digit)
        self?.updateView()
    }

    /// Замыкание для кнопок операторов
    lazy var operatorButtonPressed: (String) -> Void = { [weak self] operation in
        self?.calculateOperation.performOperation?(operation)
        self?.updateView()
    }

    /// Замыкание для обновления представления после изменений в модели
    lazy var updateView: () -> Void = { [weak self] in
        let result = self?.calculateOperation.getResult?() ?? "0"
        self?.calculateView.updateResultLabel(result)
    }
}

