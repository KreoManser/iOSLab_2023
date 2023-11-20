//
//  Alien.swift
//  HW_108
//
//  Created by Азат Зиганшин on 19.11.2023.
//

import Foundation
import UIKit

class Alien {
    var view: UIImageView
    var isAlive: Bool = true

    init(image: UIImage?) {
        view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 60),
            view.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}
