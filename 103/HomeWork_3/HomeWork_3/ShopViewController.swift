//
//  ShopViewController.swift
//  HomeWork_3
//
//  Created by Нияз Ризванов on 25.09.2023.
//

import UIKit

class ShopViewController: UIViewController {
    
    private lazy var tableShop: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.register(OnePicrureTableViewCell.self, forCellReuseIdentifier: "onePictureCellIdentifier")
        table.register(TwoPictureTableViewCell.self, forCellReuseIdentifier: "twoPictureCellIdentifier")
        return table
    }()
    private lazy var viewForSearch: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var textFieldSearch: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(viewForSearch)
        view.addSubview(textFieldSearch)
        view.addSubview(tableShop)

        configureElement()
        
        setupLayout()
    }
    
    private func configureElement() {
        view.backgroundColor = .white
        
        navigationItem.title = "Магазин"
        
        viewForSearch.backgroundColor = .tintColor
        
        textFieldSearch.placeholder = "Поиск на IN TECHNOLOGY"
        textFieldSearch.backgroundColor = .white
        textFieldSearch.layer.cornerRadius = 4
        textFieldSearch.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 20))
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            viewForSearch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewForSearch.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewForSearch.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewForSearch.heightAnchor.constraint(equalToConstant: 60),
            
            textFieldSearch.centerYAnchor.constraint(equalTo: viewForSearch.centerYAnchor),
            textFieldSearch.leadingAnchor.constraint(equalTo: viewForSearch.leadingAnchor,constant: 10),
            textFieldSearch.trailingAnchor.constraint(equalTo: viewForSearch.trailingAnchor,constant: -10),
            
            tableShop.topAnchor.constraint(equalTo: viewForSearch.bottomAnchor),
            tableShop.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableShop.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableShop.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ShopViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.row == 0 {
                return configureOnePictureCell(tableView, cellForRowAt: indexPath)
            } else {
                return configureTwoPictureCell(tableView, cellForRowAt: indexPath)
            }
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 110
        }
        
        private func configureOnePictureCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "onePictureCellIdentifier") as! OnePicrureTableViewCell
            // Настройка ячейки с одной картинкой
            return cell
        }
        
        private func configureTwoPictureCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "twoPictureCellIdentifier") as! TwoPictureTableViewCell
            // Настройка ячейки с двумя картинками
            return cell
        }
}
