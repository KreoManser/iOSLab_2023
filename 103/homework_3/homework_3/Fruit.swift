//
//  Fruit.swift
//  homework_3
//
//  Created by Данил on 24.09.2023.
//

import UIKit

internal class Fruit {
    let image: UIImage?
    let name: String
    let price: String
    
    init(image: UIImage?, name: String, price: String) {
        self.image = image
        self.name = name
        self.price = price
    }
}
