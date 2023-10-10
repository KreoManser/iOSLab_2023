//
//  DataBase.swift
//  autoShop
//
//  Created by Артур Миннушин on 10.10.2023.
//

import Foundation

class DataBase {
    
    func getData () -> [Auto] {
        return [
            Auto(id: UUID() ,photo: .checkmark, name: "Mercedes", price: 1000.0),
            Auto(id: UUID() ,photo: .checkmark, name: "Audi", price: 1000.0),
            Auto(id: UUID() ,photo: .checkmark, name: "Volvo", price: 1000.0),
            Auto(id: UUID() ,photo: .checkmark, name: "Mazda", price: 1000.0),
            Auto(id: UUID() ,photo: .checkmark, name: "Toyota", price: 1000.0),
            Auto(id: UUID() ,photo: .checkmark, name: "Suzuki", price: 1000.0),
            Auto(id: UUID() ,photo: .checkmark, name: "Lada", price: 1000.0),
            Auto(id: UUID() ,photo: .checkmark, name: "Range Rover", price: 1000.0),
            Auto(id: UUID() ,photo: .checkmark, name: "Ram", price: 1000.0),
            Auto(id: UUID() ,photo: .checkmark, name: "Honda", price: 1000.0),
            Auto(id: UUID() ,photo: .checkmark, name: "Hoval", price: 1000.0),
            Auto(id: UUID() ,photo: .checkmark, name: "Tank", price: 1000.0),
            Auto(id: UUID() ,photo: .checkmark, name: "Moscvich", price: 1000.0),
            Auto(id: UUID() ,photo: .checkmark, name: "Lamborgini", price: 1000.0),
        ]
    }
    
}
