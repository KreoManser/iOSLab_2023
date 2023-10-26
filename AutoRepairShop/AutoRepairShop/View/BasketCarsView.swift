//
//  BasketCarsView.swift
//  AutoRepairShop
//
//  Created by Нияз Ризванов on 11.10.2023.
//

import UIKit

class BasketCarsView: UIView {

    weak var basketController: BasketViewController?
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        return view
    }()
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Корзина"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    lazy var tableCar: UITableView =  {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.separatorStyle = .singleLine
        table.register(
            ListCarsForBasketTableViewCell.self, forCellReuseIdentifier: "Delete")
        return table
    }()
   

    lazy var footerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        return view
    }()
        
    lazy var footerLabel: UILabel = {
        let label = UILabel()
        label.text = "Всего: 0"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    var data = DataManager()
    
    var dataSource: UITableViewDiffableDataSource<Int,Car>?
    
    var cars: [Car] =  []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white

        addSubview(headerView)
        addSubview(headerLabel)
        addSubview(tableCar)
        addSubview(footerView)
        addSubview(footerLabel)

        setupLayout()
        
    
                
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func addCarDataSource(for car: Car) {
//        cars.append(car)
//        
//        guard var snapshot = self.dataSource?.snapshot() else { return }
//        snapshot.appendItems([car], toSection: 0)
//        self.dataSource?.apply(snapshot)
//    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 50),
            
            headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            footerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 50),
            
            footerLabel.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            footerLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            
            tableCar.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: 10),
            tableCar.bottomAnchor.constraint(equalTo: footerView.topAnchor,constant: 10),
            tableCar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableCar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

extension BasketCarsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120
    }
    
}
