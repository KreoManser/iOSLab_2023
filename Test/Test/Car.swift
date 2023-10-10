//
//  Car.swift
//  Test
//
//  Created by Alina on 10.10.2023.
//

import Foundation
import UIKit
 
struct Car: Hashable, Identifiable {
    let id: UUID
    let model: String
    let price: Int
    let image: UIImage?
    
    init(id: UUID, model: String, price: Int, image: UIImage?) {
        self.id = id
        self.model = model
        self.price = price
        self.image = image
    }
}
