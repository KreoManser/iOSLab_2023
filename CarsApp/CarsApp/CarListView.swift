//
//  MainView.swift
//  CarsApp
//
//  Created by kerik on 10.10.2023.
//

import UIKit

class CarListView: UIView {

    lazy var carTableView: UITableView = {
            let tableView = UITableView()
            tableView.separatorStyle = .singleLine
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(CarTableViewCell.self, forCellReuseIdentifier: CarTableViewCell.reuseIdentifier)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableView
        }()
    
    let dataSource: [Car] = [
            Car(image: UIImage(named: "жигули"), name: "ВАЗ 2104", cost: 50000),
            Car(image: UIImage(named: "bmwM5"), name: "BMW М5", cost: 9000000),
            Car(image: UIImage(named: "audi"), name: "Audi Q3", cost: 4500000),
            Car(image: UIImage(named: "suzuki"), name: "Suzuki sx4", cost: 700000),
            
        ]
    private var viewFrame: CGRect
    
    init(viewWidth: CGRect) {
            
            viewFrame = viewWidth
            
            super.init(frame: .zero)
            backgroundColor = .white
            translatesAutoresizingMaskIntoConstraints = false
            
            addSubviews(subviews: carTableView)
            setLayout()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}

extension CarListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarTableViewCell.reuseIdentifier, for: indexPath) as! CarTableViewCell
        let car = dataSource[indexPath.row]
        cell.configureCellForCarList(with: car, action: getAction(car: car))
        return cell
    }
    
    func tableView(_ carTableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    private func addSubviews(subviews: UIView...) {
            subviews.forEach { addSubview($0) }
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            carTableView.topAnchor.constraint(equalTo: topAnchor),
            carTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            carTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            carTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
                        
        ])
    }
}

extension CarListView: BasketDelegate {
    private func getAction(car: Car) -> UIAction {
        let addCarToBasket = UIAction { _ in
            let basketVC = BasketViewController()
            basketVC.delegate = self
            basketVC.addCar(with: car)
        }
        return addCarToBasket
    }
    
}
