//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Rustem on 08.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var calcView = CalcView(frame: .zero)
    
    lazy var model = ButtonFuncModel()
    
    /// closure for calculating, functions taken from model, according to MVC pattern
    lazy var calc: (String, Double, Double) -> String = { operation, firstNum, secondNum in
        if operation == "add" {
            return "\(self.model.add(firstNum,secondNum).clean)"
        }
        if operation == "subtract" {
            return "\(self.model.subtract(firstNum,secondNum).clean)"
        }
        if operation == "divide" {
            return "\(self.model.divide(firstNum,secondNum).clean)"
        }
        if operation == "multiply" {
            return "\(self.model.multiply(firstNum,secondNum).clean)"
        }
        if operation == "percentage" {
            return "\(self.model.percentage(firstNum,secondNum).clean)"
        }
        return "0"
    }
    
    override func loadView() {
        view = calcView
        calcView.isPressed = model.isPressed
        calcView.isDeselected = model.isDeselected
        calcView.shouldBeSelected = model.shouldBeSselected
        calcView.calculate = self.calc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
/// extension to double so we can remove .0 in nums like 18.0
extension Double {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
