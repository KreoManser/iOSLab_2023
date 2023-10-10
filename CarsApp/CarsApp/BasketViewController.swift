//
//  BasketViewController.swift
//  CarsApp
//
//  Created by kerik on 10.10.2023.
//

import UIKit


protocol BasketDelegate: AnyObject {
    
}
class BasketViewController: UIViewController {
    enum TableViewSections {
        case main
    }
    
    weak var delegate: BasketDelegate?
    
    private var cars: [Car] = []
    var dataSource: UITableViewDiffableDataSource<TableViewSections, Car>?
    private lazy var basketTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.register(CarTableViewCell.self, forCellReuseIdentifier: CarTableViewCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Корзина"
        addSubviews(basketTableView)
        setLayout()
        setupDataSource()
    }
}
extension BasketViewController {
    private func addSubviews(_ subviews: UIView...) {
        subviews.forEach { view.addSubview($0) }
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            basketTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            basketTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            basketTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            basketTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}


extension BasketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: basketTableView, cellProvider: { tableView, indexPath, car in
            let cell = self.basketTableView.dequeueReusableCell(withIdentifier: CarTableViewCell.reuseIdentifier, for: indexPath) as! CarTableViewCell
            cell.conigureCellforBasket(with: car)
            return cell
        })
        self.updateData(with: self.cars)
    }
    
    private func updateData(with cars: [Car]) {
        var snapshot = NSDiffableDataSourceSnapshot<TableViewSections, Car>()
        snapshot.appendSections([.main])
        snapshot.appendItems(cars)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}
extension BasketViewController {
    private func getAction() -> UIAction{
        let goToBusket = UIAction { _ in
            let busketVC = BasketViewController()
            self.navigationController?.pushViewController(busketVC, animated: true)
        }
        
        return goToBusket
    }
}

extension BasketViewController: AddCarDelegate {
    func addCar(with newCar: Car) {
        let car = newCar
        cars.append(car)
        updateData(with: cars)
    }
}
