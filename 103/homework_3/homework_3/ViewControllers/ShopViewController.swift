import UIKit

internal class ShopViewController: UIViewController{
    
    private let dataSource: [Fruit] = [
        Fruit(image: UIImage(named: "apple"), name: "Яблоко", price: "30 ₽"),
        Fruit(image: UIImage(named: "watermelon"), name: "Aрбуз", price: "150 ₽"),
        Fruit(image: UIImage(named: "grapes"), name: "Виноград", price: "200 ₽"),
        Fruit(image: UIImage(named: "cherries"), name: "Вишня", price: "90 ₽"),
        Fruit(image: UIImage(named: "bananas"), name: "Банан", price: "25 ₽"),
        Fruit(image: UIImage(named: "strawberry"), name: "Клубника", price: "12 ₽")
    ]
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "МАГАЗИН";
        label.font = UIFont.boldSystemFont(ofSize: 20);
        label.textColor = .black;
        
        return label;
    }()
    
    private lazy var exitButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.setTitle("Выйти", for: .normal);
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12);
        button.setTitleColor(.black, for: .normal);
        button.backgroundColor = .systemGray3;
        button.layer.cornerRadius = 5;
        button.addTarget(self, action: #selector(exitButtonPressed), for: .touchUpInside);

        return button;
    }()
    
    private lazy var fruitTableView: UITableView = {
        let tableView = UITableView();
        tableView.translatesAutoresizingMaskIntoConstraints = false;
        tableView.backgroundColor = .white;
        tableView.separatorStyle = .none;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.estimatedRowHeight = 100;
        tableView.register(FruitTableViewCell.self, forCellReuseIdentifier: FruitTableViewCell.reuseIdentifier);
        
        return tableView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        view.backgroundColor = .white;
        
        addSubviews();
        setConstraints();
    }
    
    private func addSubviews(){
        view.addSubview(exitButton);
        view.addSubview(fruitTableView);
        view.addSubview(titleLabel);
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            fruitTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            fruitTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fruitTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fruitTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            
            exitButton.topAnchor.constraint(equalTo: fruitTableView.bottomAnchor, constant: 10),
            exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exitButton.widthAnchor.constraint(equalToConstant: 200),
            exitButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    @objc private func exitButtonPressed(){
        dismiss(animated: true);
    }
}

extension ShopViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FruitTableViewCell.reuseIdentifier, for: indexPath) as! FruitTableViewCell;
        let fruit = dataSource[indexPath.row];
        cell.configureCell(with: fruit);
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70;
    }
}
