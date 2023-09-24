//
//  ShopViewController.swift
//  homework_3
//
//  Created by Кирилл Щёлоков on 24.09.2023.
//

import UIKit

class ShopViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    lazy var backButton : UIButton = {
        let backButton = UIButton()
        return backButton
    }()
    
    lazy var shopLable : UILabel = {
        let shopLabel = UILabel()
        return shopLabel
    }()
    
    lazy var searchTextField : UITextField = {
        let searchTextField = UITextField()
        return searchTextField
    }()
    
    lazy var shopCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 190, height: 250)
        let shopCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return shopCollectionView
    }()
    
    var dataSource : [(UIImage?, String, String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        shopCollectionView.dataSource = self
        shopCollectionView.delegate = self
        dataSource.append((UIImage(named: "homeImage"), "100", "Очень красивая иконка под любой дизайн"))
        dataSource.append((UIImage(named: "sunImage"), "150", "Супер красивая иконка под любой дизайн"))
        dataSource.append((UIImage(named: "dogImage"), "200", "Невероятно красивая иконка под любой дизайн"))
        setUp()
        
        shopCollectionView.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: ShopCollectionViewCell.reuseIdentifier)

    }
    
    private func setUp(){
        view.backgroundColor = .white
        setUpBackButton()
        setUpShopLabel()
        setUpSearchTextField()
        setUpshopCollectionView()
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
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
    }
    
    private func setUpShopLabel(){
        view.addSubview(shopLable)
        shopLable.translatesAutoresizingMaskIntoConstraints = false
        shopLable.font = UIFont.systemFont(ofSize: 20)
        shopLable.text = "Магазин"
        
        NSLayoutConstraint.activate([
            shopLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 1),
            shopLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setUpSearchTextField(){
        view.addSubview(searchTextField)
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.placeholder = "Поиск"
        searchTextField.font = UIFont.systemFont(ofSize: 14)
        searchTextField.backgroundColor = .opaqueSeparator
        searchTextField.layer.cornerRadius = 7
        searchTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: searchTextField.frame.height))
        searchTextField.leftViewMode = .always
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 31),
            searchTextField.heightAnchor.constraint(equalToConstant: 34),
            searchTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
    private func setUpshopCollectionView(){
        view.addSubview(shopCollectionView)
        shopCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shopCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 66),
            shopCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            shopCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            shopCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = shopCollectionView.dequeueReusableCell(withReuseIdentifier: ShopCollectionViewCell.reuseIdentifier, for: indexPath) as! ShopCollectionViewCell
                
        let product = dataSource[indexPath.row]
        cell.configureProduct(with: product)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (collectionView.frame.width / 2) - 10 // Поделите ширину коллекции на 2 и вычтите 10, чтобы создать некоторый отступ между ячейками
            return CGSize(width: width, height: 100)
        }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    
    @objc
    private func backButtonAction(){
        navigationController?.popViewController(animated: true)
    }

}
