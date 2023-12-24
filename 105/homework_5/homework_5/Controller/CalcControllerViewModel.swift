//
//  CalcControllerViewModel.swift
//  homework_5
//
//  Created by marwa awwad mohamed awwad on 07.10.2023.
//

import Foundation

class CalcControllerViewModel {
    
    // MARK: - Closures to Avoid Crashes by updating views after clicking a button
    
    var updateViews:(()->Void)?
    
    enum currentNumber {
        case firstNumber
        case secondNumber
        
    }
    
    // MARK: - TableView DataSource Array
    let calcuttonCells: [CalculatorButton] = [
        .allCelear, . plusMinus, .persentage, .divide,
        . number(7), .number(8), .number(9), .multiply,
        .number(4), .number(5), .number(6), .subtract,
        .number (1), .number(2), .number (3), .add,
        .number(0), . decimal, .equal,
    ]
    // MARK: - Normal Variables
    private(set) lazy var  calcHeaderLabel: String = self.firstNumber ?? "0"
    private(set) var currentNumber: currentNumber = .firstNumber
    private(set) var firstNumber: String? = nil{didSet{ self.calcHeaderLabel = self.firstNumber?.description ?? "0"}}
    private(set) var secondNumber: String? =  nil{didSet{self.calcHeaderLabel = self.secondNumber?.description ?? "0"}}
    
    //MARK: - setting the operations
    private(set) var operation: CalculatorOperation? = nil
    
    //MARK: check if the numbers are decimals
    private(set) var firstNumberIsDecimal: Bool = false
    private(set) var secondNumberIsDecimal: Bool = false
    
    //MARK: if any of the numbers are decimal this is gonna return true
    var eitherNumberIsDecimal: Bool {
        return firstNumberIsDecimal || secondNumberIsDecimal
    }
    //MARK: - memory Variables(to keep calculating on the previous operatoin)
    private(set) var prevNumber: String? =  nil  // it was int but lately i converted it to string to add the decimal
    private(set) var prevOperation: CalculatorOperation? = nil
}

extension CalcControllerViewModel{
    //MARK: this function to play all the non numerical buttons
    public func didSelectButton(with calcButton: CalculatorButton){
        
        switch calcButton{
        case .allCelear:self.didSelectAllClear()
        case .plusMinus:self.didSelectPlusMinus()
        case .persentage:self.didSelectPersantage()
        case .divide: self.didSelectOperation(with: .divide)
        case .multiply: self.didSelectOperation(with: .multiply)
        case .subtract: self.didSelectOperation(with: .subtract)
        case .add: self.didSelectOperation(with: .add)
        case .equal: self.didSelectEqualButton()
        case.number(let number): self.didSelectNumber(with: (number))
        case .decimal: self.didSelectDecimal()
        }
        self.updateViews?()
    }
    
    //MARK: function to activat the all clear button
    public func didSelectAllClear(){
        self.calcHeaderLabel = "0"
        self.currentNumber = .firstNumber
        self.firstNumber = nil
        self.secondNumber = nil
        self.prevNumber = nil
        self.operation = nil
        self.firstNumberIsDecimal = false
        self.secondNumberIsDecimal  = false
        self.prevOperation = nil
    }
}

//MARK: Selecting numbers
extension CalcControllerViewModel{
    private func  didSelectNumber(with number: Int){
        if self.currentNumber == .firstNumber{
            if var firstNumber = self.firstNumber {
        
                firstNumber.append(number.description)
                self.firstNumber = firstNumber
                self.prevNumber = firstNumber
            }else{
                //the case where we havn't taped any button or wirte anything in
                self.firstNumber = number.description
                self.prevNumber =  number.description
            }
            }else{
                if var secondNumber = self.secondNumber{
                    secondNumber.append(number.description)
                    self.secondNumber = secondNumber.description
                    self.prevNumber = secondNumber
                    
                }else{
                    self.secondNumber = number.description
                    self.prevNumber =  number.description
                }
            }
       }
}
    
 //MARK: Equal and arithmetic operations
extension CalcControllerViewModel{
    public func didSelectEqualButton(){
        if let operation =  self.operation,
           let firstNumber = self.firstNumber?.toDoubel,
           let secondNumber = self.secondNumber?.toDoubel {
            ///Equals is pessed normally after firstNumber, then an operation, then a secondNumber
            let result = self.getOperationResult(operation, firstNumber, secondNumber)
            self.secondNumber = nil
            self.prevOperation = operation
            self.operation = nil
            self.firstNumber = result.description
            self.currentNumber = .firstNumber
        }
        else if let prevOperation = self.prevOperation,
                let firstNumber = self.firstNumber?.toDoubel,
                let prevNumber = self.prevNumber?.toDoubel{
            /// This will update the calculated based on previously selected number and arithmatic operation
            let result = self.getOperationResult(prevOperation, firstNumber, prevNumber)
            self.firstNumber = result.description
            
        }
        
    }
    
    private func didSelectOperation( with operation: CalculatorOperation){
        if self.currentNumber == .firstNumber{
            self.operation = operation
            self.currentNumber = .secondNumber
            
        }else if self.currentNumber == .secondNumber {
            if let prevOperation = self.operation,
               let firstNumber = self.firstNumber?.toDoubel,
               let secondNumber = self.secondNumber?.toDoubel{
                
                // Do Previous Operation first
                let result = self.getOperationResult(prevOperation  , firstNumber, secondNumber)
                let resultString = self.eitherNumberIsDecimal ? result.description : result.toInt?.description  ///this will be a String
                self.secondNumber = nil
                self.firstNumber = resultString
                self.currentNumber = .secondNumber
                self.operation = operation
            }else{    /// else switch operation
                self.operation = operation
            }
        }
    }
    
    //MARK: Helper
    private func getOperationResult(_ operation: CalculatorOperation, _ firstNumber: Double?, _ secondNumber: Double? ) -> Double {
       
        guard let firstNumber = firstNumber,
              let secondNumber = secondNumber else {return 0}
        
        switch operation{
        case .divide:
            return (firstNumber / secondNumber)
        case .multiply:
            return (firstNumber * secondNumber)
        case .subtract:
            return (firstNumber - secondNumber)
        case .add:
            return (firstNumber + secondNumber)
        }
    }
}
//MARK: action buttons
extension CalcControllerViewModel{
    
    private func  didSelectPlusMinus(){
        if self.currentNumber == .firstNumber, var number = self.firstNumber{
            if number.contains("–"){
                number.removeFirst()
            }else{
                number.insert("–", at: number.startIndex)
            }
            self.firstNumber = number
            self.prevNumber = number
            
        } else if self.currentNumber == .secondNumber, var number  = self.secondNumber{
            if number.contains("–"){
                number.removeFirst()
            }else{
                number.insert("–", at: number.startIndex)
            }
            self.secondNumber = number
            self.prevNumber = number
        }
    }
    private func didSelectPersantage(){
        if self.currentNumber == .firstNumber, var number = self.firstNumber?.toDoubel {
            
            number/=100
            if number.isInteger{
                self.firstNumber = number.toInt?.description
            }else{
                self.firstNumber = number.description
                self.firstNumberIsDecimal = true
            }
            
        } else if self.currentNumber == .secondNumber, var number  = self.secondNumber?.toDoubel{
            number/=100
            if number.isInteger{
                self.secondNumber = number.toInt?.description
            }else{
                self.secondNumber = number.description
                self.secondNumberIsDecimal = true
            }
            
        }
    }
    private func didSelectDecimal(){
        if self.currentNumber == .firstNumber{
            self.firstNumberIsDecimal = true
            if let firstNumber = self.firstNumber,  !firstNumber.contains("."){
                self.firstNumber = firstNumber.appending(".")
            }else if self.firstNumber == nil{
                self.firstNumber = "0."
            }
        }else if self.currentNumber == .secondNumber{
            self.secondNumberIsDecimal = true
            
            if let secondNumber = self.secondNumber,  !secondNumber.contains("."){
                self.secondNumber = secondNumber.appending(".")
            }else if self.secondNumber == nil{
                self.secondNumber  = "0."
            }
        }
    }
}

        
   
