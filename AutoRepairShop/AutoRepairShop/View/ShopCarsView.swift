//
//  ShopCarsView.swift
//  AutoRepairShop
//
//  Created by Нияз Ризванов on 10.10.2023.
//

import UIKit

class ShopCarsView: UIView {
    weak var shopCarsController: ShopViewController?
    
    lazy var tableCar: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .singleLine
        table.delegate = self
        table.register(ListCarsShopTableViewCell.self, forCellReuseIdentifier: "titleBuy")
        return table
    }()
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        return view
    }()
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Выбери свою мечту"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    lazy var basketButton: UIButton = {
            var action = UIAction { _ in
                self.shopCarsController?.showBasket()
            }
            let button = UIButton()
            let buttonImage = UIImage(named: "basket icon")
            button.setImage(buttonImage, for: .normal)
            button.addAction(action , for: .touchUpInside)
            
            return button
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(headerView)
        addSubview(headerLabel)
        addSubview(tableCar)
        setupLayout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pressButton(car: Car) {
        shopCarsController?.addCar(car: car)
    }
    
    func setupDataSourse(dataSourse: UITableViewDataSource) {
        tableCar.dataSource = dataSourse
    }
    
    func setupNavigationBar(){
        let customBarButtonItem = UIBarButtonItem(customView: basketButton)
        shopCarsController?.navigationItem.rightBarButtonItem = customBarButtonItem
        shopCarsController?.navigationItem.title = "Cars"
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 50),
            
            headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            tableCar.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: 10),
            tableCar.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableCar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableCar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            basketButton.widthAnchor.constraint(equalToConstant: 30),
            basketButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}

extension ShopCarsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //shopCarsController?.pressCell(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true )
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120
    }
}
