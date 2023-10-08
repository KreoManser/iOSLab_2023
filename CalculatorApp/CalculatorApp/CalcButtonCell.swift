//
//  CalcButtonCell.swift
//  CalculatorApp
//
//  Created by Rustem on 08.10.2023.
//
import UIKit

class CalcButtonCell: UICollectionViewCell {
    
    /// identifier to collectionview
    static let identifier = "CalcButtonCell"
    
    /// getting type of our button
    private(set) var calculatorButton: CalculatorButton!
    
    /// the text on button
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40, weight: .regular)
        label.text = "Error"
        return label
    }()
    
    /// configuring the button
    /// - Parameter calculatorButton: getting parameters by type
    public func configure(with calculatorButton: CalculatorButton) {
        self.calculatorButton = calculatorButton
        
        self.titleLabel.text = calculatorButton.title
        self.backgroundColor = calculatorButton.color
        
        switch calculatorButton {
        case .allClear, .plusMinus, .percentage:
            self.titleLabel.textColor = .black
        default:
            self.titleLabel.textColor = .white
        }
        
        self.setupUI()
    }
    
    /// adding UI properties to our cell
    private func setupUI() {
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        switch self.calculatorButton {
        case let .number(int) where int == 0:
            self.layer.cornerRadius = 36
            
            let extraSpace = self.frame.width-self.frame.height
            
            NSLayoutConstraint.activate([
                self.titleLabel.heightAnchor.constraint(equalToConstant: self.frame.height),
                self.titleLabel.widthAnchor.constraint(equalToConstant: self.frame.height),
                self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -extraSpace),
            ])
        default:
            self.layer.cornerRadius = self.frame.size.width/2
            
            NSLayoutConstraint.activate([
                self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                self.titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor),
                self.titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            ])
        }
    }
    
    /// action when button pressed
    func isPressed(){
        switch(self.calculatorButton){
        case .divide, .multiply, .subtract, .add:
            UIView.animate(withDuration: 0.25){
                self.backgroundColor = .white
                self.titleLabel.textColor = .systemOrange
            }
        case .allClear, .plusMinus, .percentage, .equals:
            UIView.animate(withDuration: 0.5){
                self.backgroundColor = .white
                self.backgroundColor = self.calculatorButton.color
            }
        default:
            UIView.animate(withDuration: 0.5){
                self.backgroundColor = .lightGray
                self.backgroundColor = self.calculatorButton.color
            }
        }
    }
    
    /// action when button is deselected
    func isDeselected(){
        switch(self.calculatorButton){
        case .divide, .multiply, .subtract, .add:
            UIView.animate(withDuration: 0.25){
                self.backgroundColor = .systemOrange
                self.titleLabel.textColor = .white
            }
        default:
            print("button deselected")
            }
        }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.removeFromSuperview()
    }
}
