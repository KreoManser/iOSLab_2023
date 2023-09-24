//
//  BusketViewController.swift
//  homework_3
//
//  Created by Кирилл Щёлоков on 24.09.2023.
//

import UIKit

class BusketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Variables
    
    lazy var backButton : UIButton = {
        let backButton = UIButton()
        return backButton
    }()
    
    lazy var busketLabel : UILabel = {
        let busketLabel = UILabel()
        return busketLabel
    }()
    
    lazy var busketTableView : UITableView = {
        let busketTableView = UITableView()
        return busketTableView
    }()
    
    lazy var sumLabel : UILabel = {
        let sumLable = UILabel()
        return sumLable
    }()
    
    lazy var submitButton : UIButton = {
       let submitButton = UIButton()
        return submitButton
    }()
    
    var dataSource : [(UIImage?, String, String)] = []

    // MARK: - SetUp

    override func viewDidLoad() {
        super.viewDidLoad()
        busketTableView.dataSource = self
        busketTableView.delegate = self
        dataSource.append((UIImage(named: "homeImage"), "100", "Очень красивая иконка под любой дизайн"))
        dataSource.append((UIImage(named: "sunImage"), "150", "Супер красивая иконка под любой дизайн"))
        dataSource.append((UIImage(named: "dogImage"), "200", "Невероятно красивая иконка под любой дизайн"))

        setUp()
        
        busketTableView.register(BusketTableViewCell.self, forCellReuseIdentifier: BusketTableViewCell.reuseIdentifier)
        
        
    }
    
    private func setUp(){
        view.backgroundColor = .white
        setUpBackButton()
        setUpBusketLabel()
        setUpBusketTableView()
        setUpSumLabel()
        setUpSubmitButton()
    }
    
    private func setUpBackButton(){
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.layer.cornerRadius = 12
        backButton.backgroundColor = .opaqueSeparator
        backButton.setTitle("<", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 1),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
    }
    
    private func setUpBusketLabel(){
        view.addSubview(busketLabel)
        busketLabel.translatesAutoresizingMaskIntoConstraints = false
        busketLabel.font = UIFont.systemFont(ofSize: 20)
        busketLabel.text = "Корзина"
        
        NSLayoutConstraint.activate([
            busketLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 1),
            busketLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setUpBusketTableView(){
        view.addSubview(busketTableView)
        busketTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            busketTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            busketTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            busketTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            busketTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80)
        ])
    }
    
    private func setUpSumLabel(){
        view.addSubview(sumLabel)
        sumLabel.translatesAutoresizingMaskIntoConstraints = false
        sumLabel.font = UIFont.systemFont(ofSize: 20)
        sumLabel.text = getSumProducts() + "$"
        
        NSLayoutConstraint.activate([
            sumLabel.heightAnchor.constraint(equalToConstant: 24),
            sumLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            sumLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -262),
            sumLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -56),
        ])
    }
    
    private func setUpSubmitButton(){
        view.addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.layer.cornerRadius = 7
        submitButton.backgroundColor = .opaqueSeparator
        submitButton.setTitle("Оплатить", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        NSLayoutConstraint.activate([
            submitButton.heightAnchor.constraint(equalToConstant: 48),
            submitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            submitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -3),
        ])
    }
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = busketTableView.dequeueReusableCell(withIdentifier: BusketTableViewCell.reuseIdentifier, for: indexPath) as! BusketTableViewCell
        
        let product = dataSource[indexPath.row]
        cell.configureProduct(with: product)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // MARK: - Functions
    
    private func getSumProducts() -> String{
        var sum = 0
        for item in dataSource{
            guard let cost = Int(item.1) else {continue}
            sum += cost
        }
        return String(sum)
    }
    
    @objc
    private func backButtonAction(){
        navigationController?.popViewController(animated: true)
    }
    
}
