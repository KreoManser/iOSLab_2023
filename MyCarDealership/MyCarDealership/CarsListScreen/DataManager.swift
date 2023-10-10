//
//  DataManager.swift
//  MyCarDealership
//
//  Created by Азат Зиганшин on 10.10.2023.
//

import Foundation
import UIKit

class DataManager {
    func getDataSource() -> [Car] {
        return [
            Car(id: UUID(), model: "BMW M5", price: 10000000, image: UIImage(named: "M5"))
        ]
    }
}
