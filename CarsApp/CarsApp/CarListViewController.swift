//
//  ViewController.swift
//  CarsApp
//
//  Created by kerik on 10.10.2023.
//

import UIKit

protocol AddCarDelegate: AnyObject {
    func addCar(with car: Car)
}

class CarListViewController: UIViewController {
    private lazy var mainModel = MainCarsModel()
    private lazy var dataSource = mainModel.dataSource
    
    private lazy var customButton: UIButton = {
        let action = UIAction { _ in
            let basketVC = BasketViewController()
            self.navigationController?.pushViewController(basketVC, animated: true)
        }
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "basket"), for: .normal)
        button.tintColor = .systemBlue
        button.setTitleColor(.clear, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    lazy var mainView: CarListView = CarListView(viewWidth: view.frame)

        override func viewDidLoad() {
            super.viewDidLoad()
            view.addSubview(mainView)
            ConfigureCalculatorViewOnView()
            view.backgroundColor = .white
            setupNavigationBar()
        }
}
extension CarListViewController {
    private func setupNavigationBar() {
        navigationItem.title = "Машины"
        let customRightBarButton = UIBarButtonItem(customView: customButton)
        customRightBarButton.customView?.widthAnchor.constraint(equalToConstant: 20).isActive = true
        customRightBarButton.customView?.heightAnchor.constraint(equalToConstant: 20).isActive = true
        navigationItem.rightBarButtonItem = customRightBarButton
    }
    
    /// Configure CalculatorView on root view
    private func ConfigureCalculatorViewOnView() {
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

