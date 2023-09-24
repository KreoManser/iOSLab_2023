//
//  ButtonTemplate.swift
//  ProgramTable
//
//  Created by Timur on 24.09.2023.
//

import SwiftUI

class ButtonTemplate {
    
    func buttonTemplate(title: String) -> UIButton{
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle(title, for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "Inter", size: 12)
        loginButton.backgroundColor = UIColor(Color("ButtonColor"))
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 8
        loginButton.configuration = .filled()
        loginButton.configuration?.baseBackgroundColor = UIColor(named: "ButtonColor")
        return loginButton
    }
}
