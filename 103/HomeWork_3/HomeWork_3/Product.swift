//
//  Product.swift
//  HomeWork_3
//
//  Created by Камил Хайрутдинов on 24.09.2023.
//

import Foundation
import UIKit

class Product {
    let image: UIImage?
    let name: String
    let price: String
    let description: String?
    
    init(image: UIImage?, name: String, price: String, description: String?) {
        self.image = image
        self.name = name
        self.price = price
        self.description = description
    }
}

