//
//  ViewController.swift
//  HW3
//
//  Created by Kseniya Skvortsova on 27.09.2023.
//

import UIKit

class ShopViewController: UIViewController {
    
    lazy var tableView: UITableView = {
       
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.reuseIdentifier)
        return table
    }()
    
    var dataSource: [Product] = []
    
    var tableBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView = UIScrollView()
        
        dataSource = generateData()
        
        view.backgroundColor = .orange
        view.addSubview(tableView)
        tableView.backgroundColor = .black
        
        setupLayout()
    }
    
    func generateData()->[Product]{
        let data:[Product] = [Product(name: "Fate/Grand Order Lancer Tamamo no Mae",
                                      subtitle: "'Fate/Grand Order' game, Kotobukiya studio, 38 cm, and more more more more more more more more more more more text",
                                      price: "14.700 R",
                                      picImage: UIImage(named: "image1")),
                              Product(name: "King Studio Itachi Uchiha GK Resin Statue",
                                                            subtitle: "'Naruto' title, King Studio, 25 cm",
                                                            price: "11.600 R",
                                                            picImage: UIImage(named: "image2")),
                              Product(name: "Nemesis Venus Ver.",
                                                            subtitle: "'Tower of Fantasy' game, RIBOSE studio, 25 cm",
                                                            price: "15.200 R",
                                                            picImage: UIImage(named: "image3")),
                              Product(name: "POP UP PARADE Hatsune Miku Future Eve Ver. L Size",
                                                            subtitle: "POP UP PARADE studio, 23 cm",
                                                            price: "6.900 R",
                                                            picImage: UIImage(named: "image4")),
                              Product(name: "Lamzc Studio 1/6 Kira Yoshikage & Kawajiri Kosaku",
                                                            subtitle: "'Jojo' title, Lamzc Studio, 60 cm",
                                                            price: "62.300 R",
                                                            picImage: UIImage(named: "image5")),
                              Product(name: "Noodle Stopper Ruby Rose",
                                                            subtitle: "'RWBY' title, FuRyu studio, 14 cm",
                                                            price: "2.800 R",
                                                            picImage: UIImage(named: "image6")),
                              Product(name: "Noodle Stopper Miku Hatsune Sakura 2024 Ver.",
                                                            subtitle: "FuRyu studio, 15 cm",
                                                            price: "2.800 R",
                                                            picImage: UIImage(named: "image7")),
                              Product(name: "Noodle Stopper Kozume Kenma",
                                                            subtitle: "'Haikyuu!!' title, FuRyu studio, 11 cm",
                                                            price: "2.800 R",
                                                            picImage: UIImage(named: "image8")),
                              Product(name: "Vinsmoke Sanji",
                                                            subtitle: "'One Piece' title, Brain-Hole studio, 25 cm",
                                                            price: "9.800 R",
                                                            picImage: UIImage(named: "image9")),
                              Product(name: "B-style Kanna Bunny Ver.",
                                                            subtitle: "'Miss Kobayashi's Dragon Maid' title, FREEing studio, 35 cm",
                                                            price: "36.900 R",
                                                            picImage: UIImage(named: "image10"))]
        return data
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension ShopViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reuseIdentifier, for: indexPath) as! ProductTableViewCell
        
        let product = dataSource[indexPath.row]
        cell.configureCell(with: product)
        cell.backgroundColor = .black
//        let model = dataSource[indexPath.row]
//        var listConfiguration = cell.defaultContentConfiguration()
//        var backgroundConfiguration = cell.defaultBackgroundConfiguration()
//
//        listConfiguration.text = model
//        listConfiguration.secondaryText = "123"
//        listConfiguration.secondaryTextProperties.font = UIFont.boldSystemFont(ofSize: 21)
//
//        backgroundConfiguration.backgroundColor = .brown
//        backgroundConfiguration.cornerRadius = 10
//        backgroundConfiguration.backgroundInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
//
//        cell.contentConfiguration = listConfiguration
//        cell.backgroundConfiguration = backgroundConfiguration
        
        return cell
    }
}
