//
//  Car.swift
//  MyCarDealership
//
//  Created by Азат Зиганшин on 10.10.2023.
//

import Foundation
import UIKit

struct Car: Hashable {
    
    var id: UUID
    var model: String
    var price: Int
    var image: UIImage?

}
