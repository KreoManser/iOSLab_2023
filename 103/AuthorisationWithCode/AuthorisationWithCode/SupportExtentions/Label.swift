//
//  Label.swift
//  AuthorisationWithCode
//
//  Created by Mac on 2023-09-26.
//

import UIKit

extension UILabel {
    func setLable(title: String) {
        self.text = title
        self.font = UIFont.systemFont(ofSize: 12)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
