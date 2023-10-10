//
//  BacketTableViewDataSource.swift
//  autoShop
//
//  Created by Артур Миннушин on 10.10.2023.
//

import Foundation
import UIKit

class BacketTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var dataSource: [Auto] = []
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Indentifire", for: indexPath)
        
        let item = dataSource[indexPath.row]
        
        let name = item.name
        let photo = item.photo
        let price = item.price
        var listConfigeration = cell.defaultContentConfiguration()
        listConfigeration.text = name
        listConfigeration.image = photo
        listConfigeration.secondaryText = "Price:\(price) dollars"
        
        cell.contentConfiguration = listConfigeration
        
        return cell
    }
}
