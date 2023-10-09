//
//  CalcHeaderCell.swift
//  Calculator-Clone
//
//  Created by John Lee on 2022-09-15.
//

import UIKit

class CalcView: UIView{
    
    /// adding to array all types of cells-buttons
    let calcButtonCells: [CalculatorButton] = [
        .allClear, .plusMinus, .percentage, .divide,
        .number(7), .number(8), .number(9), .multiply,
        .number(4), .number(5), .number(6), .subtract,
        .number(1), .number(2), .number(3), .add,
        .number(0), .decimal, .equals
    ]
    
    /// changing colors for action buttons
    var isPressed: ((CalcButtonCell) -> Void)?
    /// changing colors back
    var isDeselected: ((CalcButtonCell) -> Void)?
    /// restrict num and . buttons to be selected so action color won't change
    var shouldBeSelected: ((CalcButtonCell) -> Bool)?
    private var firstNumber = 0.0
    private var secondNumber = 0.0
    private var operation = ""
    private var result: [Double] = []
    /// closure for changing color of button when pressed and chaing label text
    var isHiglighted: ((CalcButtonCell, String, Double, Double) -> String)?
    /// calculate everything, delegating to controller
    lazy var calculate: ((String, Double, Double) -> String) = { operationType, firstNum, secondNum in
        return ""
    }
    /// undoAction for undoButton
    lazy var undoCalculate: (() -> String) = {
        return "\((self.result.popLast() ?? 0).clean)"
    }
    
    /// closure for label text changing
    lazy var operationDone: (CalcButtonCell, String) -> String = { cell, text in
        self.label.text = text
        switch(cell.calculatorButton){
        case .number(_), .decimal:
            UIView.animate(withDuration: 0.1){
                cell.backgroundColor = .lightGray
                cell.backgroundColor = cell.calculatorButton.color
            }
            if (self.label.text == "0"){
                if(cell.titleLabel.text ?? "0" == "."){
                    self.label.text = "0"
                }else{
                    self.label.text = cell.titleLabel.text ?? "0"
                }
            }else{
                if text.count < 12{
                    if(text.contains(".") && (cell.titleLabel.text ?? "") == "."){
                        self.label.text = text
                    }else{
                        self.label.text = text + (cell.titleLabel.text ?? "")
                    }
                }
                else{
                    self.label.text = text
                }
            }
        case .allClear:
            self.label.text = "0"
            self.firstNumber = 0.0
            self.secondNumber = 0.0
        case .plusMinus:
            if(self.label.text != "0"){
                if((self.label.text?.contains("-")) ?? false){
                    self.label.text?.removeFirst()
                }else{
                    self.label.text = "-" + (self.label.text ?? "0")
                }
            }
        case .percentage:
            self.firstNumber = Double((self.label.text ?? "0")) ?? 0.0
            self.label.text = "0"
            self.operation = "percentage"
        case .multiply:
            self.firstNumber = Double((self.label.text ?? "0")) ?? 0.0
            self.label.text = "0"
            self.operation = "multiply"
        case .divide:
            self.firstNumber = Double((self.label.text ?? "0")) ?? 0.0
            self.label.text = "0"
            self.operation = "divide"
        case .add:
            self.firstNumber = Double((self.label.text ?? "0")) ?? 0.0
            self.label.text = "0"
            self.operation = "add"
        case .subtract:
            self.firstNumber = Double((self.label.text ?? "0")) ?? 0.0
            self.label.text = "0"
            self.operation = "subtract"
        case .equals:
            self.secondNumber = Double((self.label.text ?? "0")) ?? 0.0
            self.label.text = self.calculate(self.operation, self.firstNumber, self.secondNumber)
            self.result.append(Double(self.label.text ?? "0") ?? 0)
        default:
            print("cant be highlighted")
        }
        return self.label.text ?? "0"
    }
    /// result label
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 72, weight: .regular)
        label.text = "0"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    /// undo button (undoing last operation)
    lazy var undoButton: UIButton = {
        var button = UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Undo", for: .normal)
        button.backgroundColor = .systemOrange
        button.tintColor = .orange
        let undo = UIAction { _ in
            if(self.operation != ""){
                self.label.text = self.undoCalculate()
            }
        }
        button.addAction(undo, for: .touchUpInside)
        return button
    }()
    /// repeat last operation
    lazy var repeatButton: UIButton = {
        var button = UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("repeat", for: .normal)
        button.backgroundColor = .systemOrange
        button.tintColor = .orange
        let undo = UIAction { _ in
            if(self.operation != ""){
                self.label.text = self.calculate(self.operation,(Double(self.label.text ?? "0") ?? 0), self.secondNumber)
                self.result.append(Double(self.label.text ?? "0") ?? 0)
            }
        }
        button.addAction(undo, for: .touchUpInside)
        return button
    }()
    /// collectionView which contains our buttons
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CalcButtonCell.self, forCellWithReuseIdentifier: CalcButtonCell.identifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// closure to change result label from model
    lazy var changeLabel: (String) -> Void  = { currentCalcText in
        self.label.text = currentCalcText
        self.setNeedsDisplay()
    }
    
    /// setup constraints and adding views
    private func setupUI() {
        self.backgroundColor = .black
        
        self.addSubview(label)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(collectionView)
        self.addSubview(undoButton)
        self.addSubview(repeatButton)
        collectionView.frame = bounds
        
        NSLayoutConstraint.activate([
            self.label.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.label.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 120),
            self.undoButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.undoButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.repeatButton.leadingAnchor.constraint(equalTo: undoButton.leadingAnchor),
            self.repeatButton.topAnchor.constraint(equalTo: undoButton.bottomAnchor, constant: 15),
            self.collectionView.topAnchor.constraint(equalTo: label.bottomAnchor),
            self.collectionView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            self.collectionView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
/// Extension to CalcView to use as CollectionView dataSource and delegate
extension CalcView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calcButtonCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalcButtonCell.identifier, for: indexPath) as? CalcButtonCell else {
            fatalError("Failed to dequeue CalcButtonCell in CalcView")
        }
        let calcButton = self.calcButtonCells[indexPath.row]
        
        cell.configure(with: calcButton)
        return cell
    }
    
    /// setting our buttons
    /// - Parameters:
    ///   - collectionView: our buttons view
    ///   - collectionViewLayout: layout
    ///   - indexPath: all buttons
    /// - Returns: one of our button
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let calcButton = calcButtonCells[indexPath.row]
        
        switch calcButton {
        case let .number(int) where int == 0:
            return CGSize(
                width: (frame.size.width/5)*2 + ((frame.size.width/5)/3),
                height: frame.size.width/5
            )
        default:
            return CGSize(
                width: frame.size.width/5,
                height: frame.size.width/5
            )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    /// changing color while pressing button
    /// - Parameters:
    ///   - collectionView: our buttons
    ///   - indexPath: one of button
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let buttonCell = self.calcButtonCells[indexPath.row]
        if let cell = collectionView.cellForItem(at: indexPath) as? CalcButtonCell {
            isPressed?(cell)
        }
        print(buttonCell.title)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CalcButtonCell {
            isDeselected?(cell)
        }
    }
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if let cell = collectionView.cellForItem(at: indexPath) as? CalcButtonCell {
            
            return shouldBeSelected?(cell) ?? false
        }
        return true
    }
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CalcButtonCell {
            self.label.text = operationDone(cell, self.label.text ?? "0")
        }
    }
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        
    }
}
