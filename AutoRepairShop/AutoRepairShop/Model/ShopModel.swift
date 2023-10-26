//
//  ShopModel.swift
//  AutoRepairShop
//
//  Created by Нияз Ризванов on 15.10.2023.
//

import Foundation
protocol AddCarToTableViewDiffableDataSource: AnyObject {
    func addCarToTable(for car: Car)
}

class ShopModel {
    private weak var delegate: AddCarToTableViewDiffableDataSource?
    private var car: Car!
    
    init(car: Car!, delegate: AddCarToTableViewDiffableDataSource? = nil) {
        self.delegate = delegate
        self.car = car
    }
    
    
}
