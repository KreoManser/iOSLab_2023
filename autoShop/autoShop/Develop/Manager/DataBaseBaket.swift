//
//  DataBaseBaket.swift
//  autoShop
//
//  Created by Артур Миннушин on 10.10.2023.
//

import Foundation

class DataBaseBaket {
    
    var data: [Auto] = [Auto(id: UUID() ,photo: .checkmark, name: "Mercedes", price: 1000.0),]
    
    func setData (auto: Auto) -> Void {
        data.append(auto)
    }
    
    func getData () -> [Auto] {
        return data
    }
    
}
