//
//  ButtonCell.swift
//  homework_5
//
//  Created by marwa awwad mohamed awwad on 07.10.2023.
//

import UIKit

class ButtonCell: UICollectionViewCell {
     
    static let identifer = "ButtonCell"
    
    //Mark: - Variables
    private(set) var calculatorButton: CalculatorButton!
    
    //Mark: UIComponents
    private  let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40,weight: .regular)
        label.text = "Error"
        return label
    }()
    
    
    
    //Mark: - Configure
    
    public func configure(with calculatorButton: CalculatorButton){

        self.calculatorButton = calculatorButton
        self.titleLabel.text = calculatorButton.title
        self.backgroundColor = calculatorButton.color
      
        switch calculatorButton {
            
        case .allCelear, .plusMinus ,. persentage:
            self.titleLabel.textColor = .black
        default:
            self.titleLabel.textColor = .white
        }
        
        
        // Mark: - UI setup
        self.setupUI()
    }
    
    public func setOperationSelected(){
        self.titleLabel.textColor = .systemOrange
        self.backgroundColor = .white
    }
    private func setupUI(){
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        switch self.calculatorButton{
        case let .number(int) where int == 0:
            self.layer.cornerRadius = 10
            
            NSLayoutConstraint.activate([
                titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                ])
            
            default: self.layer.cornerRadius = self.frame.size.width/4
            NSLayoutConstraint.activate([
                self.titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                self.titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                self.titleLabel.widthAnchor.constraint(equalTo: widthAnchor),
                self.titleLabel.heightAnchor.constraint(equalTo:  heightAnchor),
               
            
            ])
          }
       
    }
    override func prepareForReuse() {
         super.prepareForReuse()
        self.titleLabel.removeFromSuperview()
        
    }
    
}
