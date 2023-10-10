//
//  Model.swift
//  AutoRepairShop
//
//  Created by Нияз Ризванов on 10.10.2023.
//

import Foundation
import UIKit

class DataManager {
    
    func obtainStrings() -> [Car] {
        let dataSourse = [
            Car(id: UUID(), name: "BMW M5 competiton", price: "$53,800", image: UIImage(named:"BMW M5")),
            Car(id: UUID(),name: "BMW 3 Series", price: "$43,000",image: UIImage(named:"BMW Series 3")),
            Car(id: UUID(),name: "BMW X3", price: "$42,000", image: UIImage(named:"BMW X3")),
            Car(id: UUID(),name: "BMW 7 Series", price: "$86,800", image: UIImage(named:"BMW Series 7")),
            Car(id: UUID(),name: "BMW M4 ", price: "$50,800", image: UIImage(named:"BMW M4")),
            Car(id: UUID(),name: "BMW X7", price: "$92,600", image: UIImage(named:"BMW x7")),
            Car(id: UUID(),name: "BMW 2 Series", price: "$36,350", image: UIImage(named:"BMW Series 2")),
        ]
        return dataSourse
    }
}
