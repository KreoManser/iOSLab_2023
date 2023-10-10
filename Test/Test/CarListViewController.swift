//
//  CarListViewController.swift
//  Test
//
//  Created by Alina on 10.10.2023.
//

import UIKit

protocol TableViewDelegate: AnyObject {
    func didSelectCar(_ car: Car)
}


class CarListViewController: UIViewController, UITableViewDataSource {
    
    weak var delegate: TableViewDelegate?
    
    
    enum TableSection {
        case main
    }
    
    lazy var CarTableView: UITableView = {
        
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.separatorStyle = .none
        table.register(CarTableViewCell.self, forCellReuseIdentifier: CarTableViewCell.reuseIdentifier)
        table.estimatedRowHeight = 120
        return table
    }()
    
    var dataSource: UITableViewDiffableDataSource<TableSection, Car>?
    var tableBottomConstraint: NSLayoutConstraint?
    
    var cars = [
        Car(id: UUID(), model: "Mercedes-Benz", price: 50000, image: UIImage(named: "Mercedes")),
        Car(id: UUID(), model: "BMW", price: 45000, image: UIImage(named: "bmw")),
        Car(id: UUID(), model: "Audi", price: 55000, image: UIImage(named: "audi")),
        Car(id: UUID(), model: "Lamborghini", price: 30000, image: UIImage(named: "lamborghini"))
    ]

    var basket: [Car] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(CarTableView)
        
        setupLayout()
        setupNavigationBar()
        setupDataSource()
    }
    
    func setupDataSource() {
        
        dataSource = UITableViewDiffableDataSource(tableView: CarTableView, cellProvider: { tableView, indexPath, car in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CarTableViewCell.reuseIdentifier, for: indexPath) as! CarTableViewCell
            cell.configureCell(with: car)
            cell.delegate = self
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
    
    func setupNavigationBar() {
        
        let basketAction = UIAction { _ in
            self.navigationController?.pushViewController(BasketViewController(), animated: true)
        }
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "Car Shop"

        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .bookmarks, primaryAction: basketAction, menu: nil)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            CarTableView.topAnchor.constraint(equalTo: view.topAnchor),
            CarTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            CarTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            CarTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension CarListViewController: CarCellDelegate {
    
    func didSelectCar(_ car: Car) {
        
    }
    
    
    func didPressDetailDisclosure() {
        
        let alert = UIAlertController(title: "Добавлено в корзину", message: "Ваш товар теперь в корзине", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}

extension CarListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCar = cars[indexPath.row]
        delegate?.didSelectCar(selectedCar)
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carCell", for: indexPath) as! CarTableViewCell

        let car = cars[indexPath.row]

        cell.modelLabel.text = car.model
        cell.priceLabel.text = "\(car.price)" + "$"
        cell.carImageView.image = car.image

        return cell
    }
}


