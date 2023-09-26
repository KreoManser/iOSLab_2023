//
//  TextField.swift
//  AuthorisationWithCode
//
//  Created by Mac on 2023-09-26.
//

import UIKit

extension UITextField {
    func setTextField () {
        self.font = UIFont.systemFont(ofSize: 12)
        self.backgroundColor = .lightGray
        self.layer.cornerRadius = 5
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
