//
//  CalculatorViewExtensions.swift
//  HomeWork_5
//
//  Created by Камил Хайрутдинов on 06.10.2023.
//

import Foundation
import UIKit

extension CalculatorView {
    
    /// Creates a buttons with the required parameters
    /// - Parameters:
    ///   - title: Button title
    ///   - titleColor: Button title text color
    ///   - backgroundColor: Button background colour
    /// - Returns: Ready-to-use button
    internal func mainButtonTemplate(title: String, titleColor: UIColor, backgroundColor: UIColor) -> UIButton {
        let button = UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle(title , for: .normal)
        button.tintColor = backgroundColor
        button.setTitleColor(titleColor, for: .normal)
        button.setTitleColor(titleColor, for: .highlighted)
        
        button.layer.masksToBounds = true
        
        buttons.append(button)
        return button
        
    }
    
    /// Creates an additionals buttons with the required parameters
    /// - Parameters:
    ///   - title: Button title
    /// - Returns: Ready-to-use button
    internal func additionalButtonTemplate(title: String) -> UIButton {
        let button = UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle(title , for: .normal)
        button.tintColor = UIColor.calcEerieBlack
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        
        button.isHidden = true
        button.layer.masksToBounds = true
        
        buttons.append(button)
        additionalButtons.append(button)
        return button
    }
    
    public func configureUIInPortraitOrientation() {
        print("rotatare is port")
        
        additionalButtons.forEach { $0.isHidden = true }
        
        calculatorLabel.font = UIFont.systemFont(ofSize: 90)
        
        zeroButtonsWidthConstraint?.constant = (viewFrame.width - 60) / 4 * 2 + 10
        zeroButtonsHeightConstraint?.constant = (viewFrame.width - 60) / 4
        
        buttonsWidthConstraint?.constant = (viewFrame.width - 60) / 4
        buttonsHeightConstraint?.constant = (viewFrame.width - 60) / 4
        buttons.forEach { $0.layer.cornerRadius = buttonsHeightConstraint!.constant / 2 }
    }

    public func configureUIInLandscapeOrientation() {
        print("rotatare is land")
        
        additionalButtons.forEach { $0.isHidden = false }
        
        calculatorLabel.font = UIFont.systemFont(ofSize: 70)
        
        zeroButtonsWidthConstraint?.constant = ((viewFrame.width - 60) / 5 * 2)
        zeroButtonsHeightConstraint?.constant = (viewFrame.width - 60) / 7
        
        buttonsWidthConstraint?.constant = (viewFrame.width - 60) / 5
        buttonsHeightConstraint?.constant = (viewFrame.width - 60) / 7
        buttons.forEach { $0.layer.cornerRadius = buttonsHeightConstraint!.constant / 2 }
    }
}
