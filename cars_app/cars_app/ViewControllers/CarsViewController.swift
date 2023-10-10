import UIKit

/// Класс, который отображает сам магазин покупки машин.
internal class CarsViewController: UIViewController {
    /// Здесь хранятся доступные для покупки автомобили.
    private var cars: [Car] = [Car(model: "Car 1", price: 20000.0, image: UIImage(named: "1")),
                               Car(model: "Car 2", price: 22000.0, image: UIImage(named: "2")),
                               Car(model: "Car 3", price: 25000.0, image: UIImage(named: "3")),
                               Car(model: "Car 4", price: 28000.0, image: UIImage(named: "4")),
                               Car(model: "Car 5", price: 30000.0, image: UIImage(named: "5")),
                               Car(model: "Car 6", price: 32000.0, image: UIImage(named: "6")),
                               Car(model: "Car 7", price: 35000.0, image: UIImage(named: "7")),
                               Car(model: "Car 8", price: 38000.0, image: UIImage(named: "8"))];
    /// Корзина покупателя.
    private var shoppingCart: ShoppingCart?
    
    /// Таблица всех доступных для покупки машин
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "carCell")
        return tableView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad();
        view.addSubview(tableView);
        tableView.dataSource = self;
        tableView.delegate = self;
        self.title = "Store";
        shoppingCart = ShoppingCart();
        // Кнопка для перехода в корзину, находится рядом с заголовком
        let cartButton = UIBarButtonItem(title: "Корзина", style: .plain, target: self, action: #selector(cartButtonTapped));
            
        // Добавление кнопки на экран
        self.navigationItem.rightBarButtonItem = cartButton;

        tableView.register(CarTableViewCell.self, forCellReuseIdentifier: CarTableViewCell.reuseIdentifier);
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    /// Обработка нажатия на кнопку перехода в корзину
    @objc func cartButtonTapped() {
        let shoppingCartVC = ShoppingCartViewController()
        shoppingCartVC.shoppingCart = self.shoppingCart

        self.navigationController?.pushViewController(shoppingCartVC, animated: true)
    }
}

/// UITableViewDataSource методы
extension CarsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarTableViewCell.reuseIdentifier, for: indexPath) as! CarTableViewCell;
        let car = cars[indexPath.row];
        
        cell.addButton.isUserInteractionEnabled = true
        cell.isUserInteractionEnabled = true

        cell.addButton.isEnabled = true;
        cell.carImageView.image = car.image;
        cell.nameLabel.text = car.model;
        cell.priceLabel.text = "Price: $\(car.price)";
        
        return cell;
    }
    
    /// Тут такая же история, как и с ShoppingCartViewController.
    /// не придумал ничего лучше, поэтому добавление происходит при нажатии на саму ячейку, а не на кнопку.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.dequeueReusableCell(withIdentifier: CarTableViewCell.reuseIdentifier, for: indexPath) as! CarTableViewCell;
        if let indexPath = tableView.indexPath(for: cell) {
            let selectedCar = cars[indexPath.row]
            shoppingCart?.addCar(selectedCar)
            tableView.reloadData()
        }
    }
    
    /// Задаем высоту ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120.0;
    }
}
