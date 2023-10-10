//
//  Car.swift
//  CarsApp
//
//  Created by kerik on 10.10.2023.
//

import UIKit

struct Car: Hashable, Identifiable{
    let id: UUID
    let image: UIImage?
    let name: String
    let cost: Int
    
    init(image: UIImage?, name: String, cost: Int) {
        self.id = UUID()
        self.image = image
        self.name = name
        self.cost = cost
    }
}
