//
//  ConfigureTableViewBasket.swift
//  AutoRepairShop
//
//  Created by Нияз Ризванов on 17.10.2023.
//

import Foundation
import UIKit

class ConfigureTableViewBasket: NSObject {
    var tableCar: UITableView?
    
    weak var controller: BasketViewController?
    
    var cars: [Car] = []
    
    var dataSource: UITableViewDiffableDataSource<Int,Car>?
    
    func setupDataSource() -> UITableViewDiffableDataSource<Int,Car>? {
        dataSource = UITableViewDiffableDataSource(tableView: tableCar!, cellProvider: { tableView, indexPath, car in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Delete", for: indexPath) as! ListCarsForBasketTableViewCell
            cell.configureCell(with: car)
            cell.controller = self.controller
            return cell
        })
        updateDataSource(with: cars, animated: false)
        guard dataSource != nil else {return nil}
        return dataSource
    }
    
    func updateDataSource(with cars: [Car], animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Int,Car>()
        snapshot.appendSections([0])
        snapshot.appendItems(cars)
        dataSource?.apply(snapshot, animatingDifferences: animated)
    }
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dataSource.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "titleDelete" , for: indexPath) as! ListCarsForBasketTableViewCell
//        
//        let car = dataSource[indexPath.row]
//        
//        cell.configureCell(with: car)
//        
//        return cell
//    }
}
