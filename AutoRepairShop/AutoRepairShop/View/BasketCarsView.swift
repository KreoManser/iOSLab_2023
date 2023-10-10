//
//  BasketCarsView.swift
//  AutoRepairShop
//
//  Created by Нияз Ризванов on 10.10.2023.
//

import UIKit

class BasketCarsView: UIView {
    weak var basketCarsController: BasketCarsViewController?
    
    private lazy var headerBasket: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        return view
    }()
    
//    private lazy var labelBasket: UILabel = {
//        let label = UILabel()
//        label.text = "Корзина"
//        labelBasket.textColor = .white
//        labelBasket.font = UIFont.systemFont(ofSize: 40)
//        labelBasket.font = UIFont.boldSystemFont(ofSize: 25)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
//    private lazy var footerBasket: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .darkGray
//        return view
//    }()
//    
//    var count = 0
//    private lazy var labelFooterBasket: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Всего машин: \(count) "
//        labelBasket.textColor = .white
//        labelBasket.font = UIFont.systemFont(ofSize: 40)
//        labelBasket.font = UIFont.boldSystemFont(ofSize: 25)
//        return label
//    }()
//    
//    private lazy var tableBasket: UITableView = {
//        let table = UITableView()
//        table.translatesAutoresizingMaskIntoConstraints = false
////        table.dataSource = self
////        table.delegate = self
//        table.separatorStyle = .none
//        table.register(ListCarsTableViewCell.self, forCellReuseIdentifier: ListCarsTableViewCell.reuseIdentifier)
//        return table
//    }()
//    
    var cars: [Car] = []
    var dataSource: UITableViewDiffableDataSource<Int,Car>?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .orange
        
        addSubview(headerBasket)
        //addSubview(labelBasket)
//        addSubview(tableBasket)
//        addSubview(footerBasket)
//        addSubview(labelFooterBasket)
        
       // setupDataSource()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func setupDataSource() {
//        dataSource = UITableViewDiffableDataSource(tableView: tableBasket) { tableBasket, indexPath, cars in
//            
//            let cell = tableBasket.dequeueReusableCell(withIdentifier: BasketTableViewCell.reuseIdentifier, for: indexPath) as! BasketTableViewCell
//            cell.configureCell(with: cars)
//            return cell
//        }
//        updateDatasource(with: cars, animated: false)
//    }
    
    func updateDatasource(with cars: [Car], animated: Bool){
        var snapshot = NSDiffableDataSourceSnapshot<Int, Car>()
        snapshot.appendSections([0])
        snapshot.appendItems(cars)
        dataSource?.apply(snapshot, animatingDifferences: animated)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            headerBasket.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerBasket.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            headerBasket.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            headerBasket.heightAnchor.constraint(equalToConstant: 50),
//            labelBasket.centerXAnchor.constraint(equalTo: headerBasket.centerXAnchor),
//            labelBasket.centerYAnchor.constraint(equalTo: headerBasket.centerYAnchor),
            
//            tableBasket.topAnchor.constraint(equalTo: headerBasket.bottomAnchor,constant: 10),
//            tableBasket.bottomAnchor.constraint(equalTo: footerBasket.bottomAnchor),
//            tableBasket.leadingAnchor.constraint(equalTo: leadingAnchor),
//            tableBasket.trailingAnchor.constraint(equalTo: trailingAnchor),
//            
//            footerBasket.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -5),
//            footerBasket.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
//            footerBasket.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
//            footerBasket.heightAnchor.constraint(equalToConstant: 50),
//            labelBasket.leadingAnchor.constraint(equalTo:   footerBasket .leadingAnchor,constant: 10),
//            labelBasket.centerYAnchor.constraint(equalTo: footerBasket.centerYAnchor),
            
        ])
    }
//    
//    
//    private func setupData() {
//        dataSourse = [
//            Car(name: "BMW M5 competiton", price: "$53,800", image: UIImage(named:"BMW M5")),
//            Car(name: "BMW 3 Series", price: "$43,000",image: UIImage(named:"BMW Series 3")),
//            Car(name: "BMW X3", price: "$42,000", image: UIImage(named:"BMW X3")),
//            Car(name: "BMW 7 Series", price: "$86,800", image: UIImage(named:"BMW Series 7")),
//            Car(name: "BMW M4 ", price: "$50,800", image: UIImage(named:"BMW M4")),
//            Car(name: "BMW X7", price: "$92,600", image: UIImage(named:"BMW x7")),
//            Car(name: "BMW 2 Series", price: "$36,350", image: UIImage(named:"BMW Series 2")),
//        ]
//    }
    
}

