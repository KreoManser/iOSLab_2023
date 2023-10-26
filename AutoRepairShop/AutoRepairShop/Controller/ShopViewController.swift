//
//  ViewController.swift
//  AutoRepairShop
//
//  Created by Нияз Ризванов on 10.10.2023.
//

import UIKit

protocol ShoppingCartDelegate: AnyObject {
    func addCarForBasket(_ car: Car)
    //func deleteCarForBasket(_ car: Car)
}
class ShopViewController: UIViewController {
    weak var shoppingCartDelegate: ShoppingCartDelegate?
    
    private lazy var shopView: ShopCarsView = {
        return ShopCarsView(frame: .zero)
    }()
    
    var basketViewController = BasketViewController()
    
    private let dataManager = DataManager()
    
    private let configureShop = ConfigureTableViewShop()
    
    //private let configureBasket = ConfigureTableViewBasket()
    
    override func loadView() {
        super.loadView()
        
        view = shopView
    }
    
    override func viewDidLoad() {
        shopView.shopCarsController = self
        configureShop.controller = self
        
        shoppingCartDelegate = basketViewController
        configureShop.dataSource = dataManager.obtainStrings()
        shopView.setupDataSourse(dataSourse: configureShop)
        shopView.setupNavigationBar()
    }
    
    func addCar(car: Car) {
//        let car = configureShop.dataSource
//        basketViewController.car = car[indexPath.row]
        shoppingCartDelegate?.addCarForBasket(car)
    }
    
//    func deleteCar(car: Car) {
//        shoppingCartDelegate?.deleteCarForBasket(car)
//    }
    
    func showBasket() {
        navigationController?.pushViewController(basketViewController, animated: true)
    }
}

/*
 protocol ShoppingCartDelegate: AnyObject {
     func didSelectCar(_ car: Car)
 }
 class ShopViewController: UIViewController {
     weak var shoppingCartDelegate: ShoppingCartDelegate?
     
     private lazy var shopView: ShopCarsView = {
         return ShopCarsView(frame: .zero)
     }()
     
     var basketViewController = BasketViewController()
     
     private let dataManager = DataManager()
     
     private let configureShop = ConfigureTableViewShop()
     
     override func loadView() {
         super.loadView()
         
         view = shopView
     }
     
     override func viewDidLoad() {
         shopView.shopCarsController = self
         configureShop.dataSource = dataManager.obtainStrings()
         shopView.setupDataSourse(dataSourse: configureShop)
         shopView.setupNavigationBar()
         
     }
     
     func pressCell(indexPath: IndexPath) {
         shoppingCartDelegate = basketViewController
 //        let car = configureShop.dataSource
 //        basketViewController.car = car[indexPath.row]
         let car = configureShop.dataSource[indexPath.row]
         shoppingCartDelegate?.didSelectCar(car)
     }
     
     func showBasket() {
         //basketViewController.setupData()
         navigationController?.pushViewController(basketViewController, animated: true)
     }
 }*/
