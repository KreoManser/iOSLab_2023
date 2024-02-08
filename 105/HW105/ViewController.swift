//
//  ViewController.swift
//  HW105
//
//  Created by Ильмир Шарафутдинов on 27.01.2024.
//

import UIKit

enum calculation {
    case multiplication
    case subtraction
    case division
    case addition
    case none
}

class ViewController: UIViewController {
    
    @IBOutlet weak var result: UILabel!
    
    var firstNum: Double = 0
    var secondNum: Double = 0
    var selectedCalculation: calculation = .none
    
    /// это тег кнопки "AC" - очистка
    lazy var clearClosure = {
        self.result.text = "0"
        self.firstNum = 0
        self.secondNum = 0
        self.selectedCalculation = .none
    }
    /// это тег кнопки "+/-" - смена знака
    lazy var negativePositiveNumberClosure = {
        if let text = self.result.text, let value = Double(text) {
            self.result.text = String(-value)
        }
    }
    /// это тег кнопки "%" - процентный расчет
    lazy var percentageClosure = {
        if let text = self.result.text, let value = Double(text) {
            self.result.text = String(value / 100)
        }
    }
    /// это тег кнопки "/" - деление
    lazy var divisionClosure = {
        if let text = self.result.text, let value = Double(text) {
            self.firstNum = value
            self.selectedCalculation = .division
            self.result.text = "0"
        }
    }
    /// это тег кнопки "X" - умножения
    lazy var multiplicationClosure = {
        if let text = self.result.text, let value = Double(text) {
            self.firstNum = value
            self.selectedCalculation = .multiplication
            self.result.text = "0"
        }
    }
    /// это тег кнопки "-" вычитания
    lazy var subtractionClosure = {
        if let text = self.result.text, let value = Double(text) {
            self.firstNum = value
            self.selectedCalculation = .subtraction
            self.result.text = "0"
        }
    }
    /// это тег кнопки "+" - сложение
    lazy var additionClosure = {
        if let text = self.result.text, let value = Double(text) {
            self.firstNum = value
            self.selectedCalculation = .addition
            self.result.text = "0"
        }
    }
    ///  это тег кнопки "=" - результат
    lazy var resultClosure = {
        if let text = self.result.text, let value = Double(text) {
            self.secondNum = value
            var calculationResult: Double = 0
            
            switch self.selectedCalculation {
            case .addition:
                calculationResult = self.firstNum + self.secondNum
                break
            case .subtraction:
                calculationResult = self.firstNum - self.secondNum
                break
            case .multiplication:
                calculationResult = self.firstNum * self.secondNum
                break
            case .division:
                calculationResult = self.firstNum / self.secondNum
                break
            case .none:
                break
            }
            self.result.text = String(calculationResult)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addNumber(_ sender: Any) {
        guard let tagButton = (sender as AnyObject).tag else { return }
        if let firstCharacter = result.text?.first, firstCharacter == "0" {
            if result.text!.count == 1 {
                result.text = String(tagButton)
            } else {
                result.text?.removeFirst()
                result.text! += String(tagButton)
            }
        } else {
            result.text! += String(tagButton)
        }
    }
    
    @IBAction func buttonCalculations(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        
        switch button.tag {
        case 10:
            clearClosure()
            break
        case 11:
            negativePositiveNumberClosure()
            break
        case 12:
            percentageClosure()
            break
        case 13:
            divisionClosure()
            break
        case 14:
            multiplicationClosure()
            break
        case 15:
            subtractionClosure()
            break
        case 16:
            additionClosure()
            break
        case 17:
            resultClosure()
        default:
            break
        }
    }
}


