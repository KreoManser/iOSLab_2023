//
//  ShopCarsView.swift
//  AutoRepairShop
//
//  Created by Нияз Ризванов on 10.10.2023.
//

import UIKit

class ShopCarsView: UIView {
    weak var shopCarsController: ViewController?
    
    lazy var tableCars: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.register(ListCarsTableViewCell.self, forCellReuseIdentifier: ListCarsTableViewCell.reuseIdentifier)
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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Choose your dream car"
        label.textColor = .white
        return label
    }()
    
    lazy var basketButton: UIButton = {
        var action = UIAction { _ in
            self.shopCarsController?.addBasket()
        }
        let button = UIButton(type: .custom)
        let buttonImage = UIImage(named: "basket icon")
        button.setImage(buttonImage, for: .normal)
        button.addAction(action , for: .touchUpInside)
        
        return button
    }()
    
    var dataSourse: [Car] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(headerView)
        addSubview(tableCars)
        addSubview(headerLabel)
        setupLayout()
        
        setupData()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData() {
        dataSourse = [
            Car(id: UUID(), name: "BMW M5 competiton", price: "$53,800", image: UIImage(named:"BMW M5")),
            Car(id: UUID(),name: "BMW 3 Series", price: "$43,000",image: UIImage(named:"BMW Series 3")),
            Car(id: UUID(),name: "BMW X3", price: "$42,000", image: UIImage(named:"BMW X3")),
            Car(id: UUID(),name: "BMW 7 Series", price: "$86,800", image: UIImage(named:"BMW Series 7")),
            Car(id: UUID(),name: "BMW M4 ", price: "$50,800", image: UIImage(named:"BMW M4")),
            Car(id: UUID(),name: "BMW X7", price: "$92,600", image: UIImage(named:"BMW x7")),
            Car(id: UUID(),name: "BMW 2 Series", price: "$36,350", image: UIImage(named:"BMW Series 2")),
        ]
    }
    
    func setupNavigationBar(){
        let customBarButtonItem = UIBarButtonItem(customView: basketButton)
        shopCarsController?.navigationItem.rightBarButtonItem = customBarButtonItem
        shopCarsController?.navigationItem.title = "Main"
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 50),
            headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            tableCars.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: 10),
            tableCars.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableCars.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableCars.trailingAnchor.constraint(equalTo: trailingAnchor),
            basketButton.widthAnchor.constraint(equalToConstant: 30),
            basketButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}

extension ShopCarsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourse.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: ListCarsTableViewCell.reuseIdentifier , for: indexPath) as! ListCarsTableViewCell

        let car = dataSourse[indexPath.row]

        cell.configureCell(with: car)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 110
        }
}
