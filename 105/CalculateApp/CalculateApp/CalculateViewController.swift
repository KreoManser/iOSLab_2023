//
//  CalculateViewController.swift
//  CalculateApp
//
//  Created by Mac on 2023-10-08.
//

import UIKit

class CalculateViewController: UIViewController {
    lazy var calculateView = CalculateView(frame: .zero)
    
    override func loadView() {
        view = calculateView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func actions() {
        
    }
}
