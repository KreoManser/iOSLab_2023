//
//  ViewController.swift
//  Homework5
//
//  Created by kerik on 07.10.2023.
//

import UIKit

class ViewController: UIViewController {
    lazy var calculatorView: CalculatorView = CalculatorView(viewWidth: view.frame)
    var calcModel: CalculatorModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        calcModel = CalculatorModel(displayView: self)
        view.addSubview(calculatorView)
        ConfigureCalculatorViewOnView()
        view.backgroundColor = .black
    }

}
extension ViewController {
    
    /// Configure CalculatorView on root view
    private func ConfigureCalculatorViewOnView() {
        NSLayoutConstraint.activate([
            calculatorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            calculatorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            calculatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calculatorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
