//
//  Image.swift
//  AuthorisationWithCode
//
//  Created by Mac on 2023-09-26.
//

import UIKit

extension UIImageView {
    func setImage(name: String, cornerRadius: Double) {
        self.image = UIImage(named: name)
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
