//
//  CalcHeaderCell.swift
//  Calculator-Clone
//
//  Created by John Lee on 2022-09-15.
//

import UIKit

class CalcView: UIView{
    
    var calculatorButton: CalculatorButton?
    
    /// adding to array all types of cells-buttons
    let calcButtonCells: [CalculatorButton] = [
        .allClear, .plusMinus, .percentage, .divide,
        .number(7), .number(8), .number(9), .multiply,
        .number(4), .number(5), .number(6), .subtract,
        .number(1), .number(2), .number(3), .add,
        .number(0), .decimal, .equals
    ]
    
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
        collectionView.frame = bounds
        
        NSLayoutConstraint.activate([
            self.label.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.label.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 120),
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
            cell.isPressed()
        }
        print(buttonCell.title)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let buttonCell = self.calcButtonCells[indexPath.row]
        if let cell = collectionView.cellForItem(at: indexPath) as? CalcButtonCell {
            cell.isDeselected()
        }
        print(buttonCell.title)
    }
}
