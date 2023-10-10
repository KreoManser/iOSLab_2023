//
//  MainCarsModel.swift
//  CarsApp
//
//  Created by kerik on 10.10.2023.
//

import Foundation
import UIKit

class MainCarsModel {
    let dataSource: [Car] = [
            Car(image: UIImage(named: "жигули"), name: "ВАЗ 2104", cost: 50000),
            Car(image: UIImage(named: "bmwM5"), name: "BMW M5", cost: 9000000),
            Car(image: UIImage(named: "audi"), name: "Audi Q3", cost: 4500000),
            Car(image: UIImage(named: "suzuki"), name: "Suzuki sx4", cost: 700000),
        ]
}
