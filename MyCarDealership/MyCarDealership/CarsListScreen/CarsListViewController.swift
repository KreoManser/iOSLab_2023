//
//  ViewController.swift
//  MyCarDealership
//
//  Created by Азат Зиганшин on 10.10.2023.
//

import UIKit

protocol CarsListViewControllerDelegate: AnyObject {
    func dataUpdated(car: Car)
}

class CarsListViewController: UIViewController {

    var carsView = CarsListView()
    var dataManager = DataManager()
    var basketViewController = BasketViewController()
    
    var dataSource: [Car] = []
    
    private weak var delegate: CarsListViewControllerDelegate?
    
    override func loadView() {
        view = carsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        carsView.tableView.delegate = self
        carsView.tableView.dataSource = self
        delegate = basketViewController
        
        dataSource = dataManager.getDataSource()
        
        self.title = "Автосалон"
        setupNavigationBar()
        
        
    }

    
    func setupNavigationBar() {
        let basketAction = UIAction { _ in
            self.navigationController?.pushViewController(self.basketViewController, animated: true)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: basketAction, menu: nil)
    }

}

extension CarsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarsListTableViewCell.reuseIdentifier, for: indexPath) as! CarsListTableViewCell
        
        let car = dataSource[indexPath.row]
        cell.configureCell(with: car)
        let action: () -> Void = { [weak self] in
            self?.delegate?.dataUpdated(car: car)
        }
        cell.addToBasketButton.addAction(UIAction {_ in action()}, for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

