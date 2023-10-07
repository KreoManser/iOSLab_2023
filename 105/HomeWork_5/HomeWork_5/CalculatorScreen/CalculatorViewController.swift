//
//  CalculatorViewController.swift
//  HomeWork_5
//
//  Created by Камил Хайрутдинов on 06.10.2023.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    /// CalculatorView reference
    lazy var calculatorView: CalculatorView = CalculatorView(viewWidth: view.frame)
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(calculatorView)
        ConfigureCalculatorViewOnView()
        view.backgroundColor = .black
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if UIDevice.current.orientation.isLandscape {
            calculatorView.configureUIInLandscapeOrientation()
            calculatorView.layoutIfNeeded()
        }
        else if UIDevice.current.orientation.isPortrait {
            calculatorView.configureUIInPortraitOrientation()
            calculatorView.layoutIfNeeded()
        }

    }
}
