//
//  Button.swift
//  AuthorisationWithCode
//
//  Created by Mac on 2023-09-26.
//

import UIKit

extension UIButton {
    func setButton (title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.black, for: UIControl.State.normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.backgroundColor = .lightGray
        self.layer.cornerRadius = 5
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
