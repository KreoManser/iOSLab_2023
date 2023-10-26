//
//  BasketViewController.swift
//  AutoRepairShop
//
//  Created by Нияз Ризванов on 11.10.2023.
//

import UIKit

class BasketViewController: UIViewController {

    private lazy var basketView: BasketCarsView = {
        return BasketCarsView(frame: .zero)
    }()
   
    private let dataManager = DataManager()
    
    private let configureBasket = ConfigureTableViewBasket()
    
    override func loadView() {
        super.loadView()
        
        view = basketView
    }
    
    var cars: [Car] = []
    
    var car: Car? {
        willSet{
            setupData()
        }
        didSet{
            updateData()
        }
    }

    func setupData(){
        configureBasket.controller = self
        configureBasket.tableCar = basketView.tableCar
        basketView.dataSource = configureBasket.setupDataSource()
    }
    
    private var caunter = 0
    
    func addCars() {
        guard let newCar = car else {return}
        cars.append(newCar)
        self.caunter += 1
        basketView.footerLabel.text = "Всего: \(caunter)"
    }
    
    func updateData() {
        guard let newCar = car else {return}
        configureBasket.cars.append(newCar)
        addCars()
        guard var snapshot = configureBasket.dataSource?.snapshot() else { return }
        snapshot.appendItems([newCar], toSection: 0)
        configureBasket.dataSource?.apply(snapshot)
    }
    
    func deleteCountCars() {
        guard let newCar = car else {return}
        cars.append(newCar)
        self.caunter -= 1
        basketView.footerLabel.text = "Всего: \(caunter)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        basketView.basketController = self
            }
    func deleteCarForBasket(_ car: Car) {
        guard var snapshot = configureBasket.dataSource?.snapshot() else { return }
        if let objectIndex = configureBasket.cars.firstIndex(where: {$0.id == car.id} ){
            configureBasket.cars.remove(at: objectIndex)
            cars.remove(at: objectIndex)
            snapshot.deleteItems([car])
            deleteCountCars()
            configureBasket.dataSource?.apply(snapshot)
            //configureBasket.updateDataSource(with: configureBasket.cars, animated: true)
        }
    }
}

extension BasketViewController: ShoppingCartDelegate {
    
    func addCarForBasket(_ car: Car) {
        if !cars.contains(car){
            self.car = car
        }
        
    }
}

/*
 class BasketViewController: UIViewController {

     private lazy var basketView: BasketCarsView = {
         return BasketCarsView(frame: .zero)
     }()
    
     private let dataManager = DataManager()
     
     
     private let configureDataSourse = ConfigureTableViewBasket()
 //    weak var shopViewController: ShopViewController?
 //
 //    init() {
 //        super.init(nibName: nil, bundle: nil)
 //        shopViewController?.shoppingCartDelegate = self
 //    }
 //
 //    required init?(coder: NSCoder) {
 //        fatalError("init(coder:) has not been implemented")
 //    }
     override func loadView() {
         super.loadView()
         
         view = basketView
     }
     
     var cars: [Car] = []
     var car: Car? {
         willSet{
             setupData()
         }
         didSet{
             updateData()
         }
     }

     func setupData(){
         configureDataSourse.tableCar = basketView.tableCar
         basketView.dataSource = configureDataSourse.setupDataSource()
     }
     
     private var caunter = 0
     
     func addCars() {
         guard let newCar = car else {return}
         cars.append(newCar)
         self.caunter += 1
         basketView.footerLabel.text = "Всего: \(caunter)"
     }
     
     func updateData() {
         guard let newCar = car else {return}
         configureDataSourse.cars.append(newCar)
         addCars()
         guard var snapshot = configureDataSourse.dataSource?.snapshot() else { return }
         snapshot.appendItems([newCar], toSection: 0)
         configureDataSourse.dataSource?.apply(snapshot)
     }
     
     func deleteCountCars() {
         self.caunter += 1
         basketView.footerLabel.text = "Всего: \(caunter)"
     }
     
     override func viewDidLoad() {
         super.viewDidLoad()

         basketView.basketController = self
     }
 }
 extension BasketViewController: ShoppingCartDelegate {
     func didSelectCar(_ car: Car) {
         if !cars.contains(car){
             self.car = car
         }
         
     }
 }

 */
