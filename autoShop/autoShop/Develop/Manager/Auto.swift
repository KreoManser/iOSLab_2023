//
//  Auto.swift
//  autoShop
//
//  Created by Артур Миннушин on 10.10.2023.
//

import Foundation
import UIKit

struct Auto: Hashable, Identifiable {
    let id: UUID
    let photo: UIImage?
    let name: String
    let price: Decimal
}
