import UIKit;

/// Класс отображения экрана с корзиной.
internal class ShoppingCartViewController: UIViewController {
    var shoppingCart: ShoppingCart?
    
    /// Таблица со всеми элементам, добавленными в корзину.
    private lazy var tableView: UITableView = {
        let tableView = UITableView();
        tableView.translatesAutoresizingMaskIntoConstraints = false;
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cartCell");
        return tableView;
    }()
    
    /// Текст для отображения стоимости корзины.
    private lazy var totalPriceLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.textColor = .black;
        label.textAlignment = .right;
        
        return label;
    }()
    
    /// Картинка для пустой корзины.
    private lazy var cartImageView: UIImageView = {
        let image = UIImageView();
        image.translatesAutoresizingMaskIntoConstraints = false;
        image.image = UIImage(named: "cart");
        image.contentMode = .scaleAspectFit;
        
        return image;
    }()
    
    /// Сообщение о том, что корзин пуста
    private lazy var cartLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "Cart is empty...";
        label.font = UIFont.systemFont(ofSize: 20);
        label.textColor = .black;
        
        return label;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        view.addSubview(tableView);
        tableView.dataSource = self;
        tableView.delegate = self;
        self.title = "Shopping Cart";
        // Считаем стоимость корзины перед ее отображением
        totalPriceLabel.text = shoppingCart?.calculateTotalPrice();
        
        // Проверяем общую стоимость корзины,
        // если корзина пуста, то добавим картинку и текст на экран
        if(totalPriceLabel.text == "Total: $0.00"){
            displayEmptyCart();
        }
        
        // Регистрируем кастомную ячейку
        tableView.register(CarTableViewCell.self, forCellReuseIdentifier: CarTableViewCell.reuseIdentifier);
        
        // Добавляем строку с общей суммой к заголовку
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: totalPriceLabel);

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    /// Метод выводит картинку и текст, если корзина пуста.
    private func displayEmptyCart(){
        view.addSubview(cartImageView);
        view.addSubview(cartLabel);
        NSLayoutConstraint.activate([
            cartImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            cartImageView.widthAnchor.constraint(equalToConstant: 100),
            cartImageView.heightAnchor.constraint(equalToConstant: 100),
            cartImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cartImageView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16),
            cartImageView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16),
            cartImageView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -16),
            
            cartLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cartLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]);
    }
}

/// UITableViewDataSource методы
extension ShoppingCartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingCart?.cars.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarTableViewCell.reuseIdentifier, for: indexPath) as! CarTableViewCell;

        if let car = shoppingCart?.cars[indexPath.row] {
            cell.addButton.isUserInteractionEnabled = true;
            cell.isUserInteractionEnabled = true;
            // Так как использовал одну и ту же кастомную ячейку, поменял название у кнопки
            cell.addButton.setTitle("Delete from cart", for: .normal);
            cell.carImageView.image = car.image;
            cell.nameLabel.text = car.model;
            cell.priceLabel.text = "Price: $\(car.price)";
        }
        
        return cell;
    }
    
    /// Не получалось обработать нажатие на кнопку внутри кастомной ячейки
    /// (всегда обрабатывалось нажатие на саму ячейку, а не на кнопку,
    /// поэтому при нажатии на ячейку выполняется удаление элементов из ячейки.
    /// Решение  ужасное, но за такой промежуток времени ничего более путного не пришло в голову : ( )
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.dequeueReusableCell(withIdentifier: CarTableViewCell.reuseIdentifier, for: indexPath) as! CarTableViewCell;
        if let indexPath = tableView.indexPath(for: cell) {
            shoppingCart?.removeCar(at: indexPath.row);
            tableView.reloadData();
            // При удалении элемента, пересчитываем итоговую стоимость корзины
            totalPriceLabel.text = shoppingCart?.calculateTotalPrice()
        }
    }
    
    /// Установил высоту ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120.0;
    }
}
