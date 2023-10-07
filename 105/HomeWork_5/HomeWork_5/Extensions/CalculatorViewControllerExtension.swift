//
//  CalculatorViewControllerExtension.swift
//  HomeWork_5
//
//  Created by Камил Хайрутдинов on 06.10.2023.
//

import UIKit
import Foundation

extension CalculatorViewController {
    
    /// Configure CalculatorView on root view
    internal func ConfigureCalculatorViewOnView() {
        NSLayoutConstraint.activate([
            calculatorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            calculatorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            calculatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calculatorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
