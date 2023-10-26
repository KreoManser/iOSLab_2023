//
//  ConfigureTableView.swift
//  AutoRepairShop
//
//  Created by Нияз Ризванов on 11.10.2023.
//

import Foundation
import UIKit

class ConfigureTableViewShop: NSObject,  UITableViewDataSource {
    var dataSource: [Car] = []
    weak var controller: ShopViewController?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleBuy" , for: indexPath) as! ListCarsShopTableViewCell
        
        let car = dataSource[indexPath.row]
        
        cell.configureCell(with: car)
        cell.controller = controller
        return cell
    }
}
