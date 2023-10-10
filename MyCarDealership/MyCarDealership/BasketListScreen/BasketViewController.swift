//
//  BasketViewController.swift
//  MyCarDealership
//
//  Created by Азат Зиганшин on 10.10.2023.
//

import UIKit

enum TableSection {
    case main
}

class BasketViewController: UIViewController, UITableViewDelegate {

    var basketView = BasketView()
    
    var dataSource: UITableViewDiffableDataSource<TableSection, Car>?
    var cars: [Car] = []
    
    
    override func loadView() {
        view = basketView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        basketView.tableView.delegate = self
        
        setupDataSource()
        updateDataSource(with: cars, animate: true)
    }
    
    func setupDataSource() {
            
        dataSource = UITableViewDiffableDataSource(tableView: basketView.tableView, cellProvider: { tableView, indexPath, car in
            
            let action = { [weak self] in
                if let index = self?.cars.firstIndex(where: { $0.id == car.id }) {
                    self?.cars.remove(at: index)
                    self?.updateDataSource(with: self?.cars ?? [], animate: true)
                }
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: BasketCarsListTableViewCell.reuseIdentifier, for: indexPath) as! BasketCarsListTableViewCell
                cell.configureCell(with: car)
                
                cell.addToBasketButton.addAction(UIAction{ _ in action()}, for: .touchUpInside)
                return cell
            })
            
        updateDataSource(with: cars, animate: false)
    }
    
    func updateDataSource(with cars: [Car], animate: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<TableSection, Car>()
        snapshot.appendSections([.main])
        snapshot.appendItems(cars)
        dataSource?.apply(snapshot, animatingDifferences: animate)
    }
}

extension BasketViewController: CarsListViewControllerDelegate {
    func dataUpdated(car: Car) {
        let index = cars.firstIndex(where: { $0.id == car.id })
        if (index == nil) {
            cars.append(car)
            updateDataSource(with: cars, animate: false)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
