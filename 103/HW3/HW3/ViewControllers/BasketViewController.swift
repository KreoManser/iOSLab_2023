import UIKit

class BasketViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reuseIdentifier, for: indexPath) as! ProductTableViewCell
        let product = dataSource[indexPath.row]
        cell.configureCell(product: product)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        104
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Your basket"
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.reuseIdentifier)
        
        return table
    }()
    
    lazy var exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Exit", for: .normal)
        button.backgroundColor = .darkGray
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleExit), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var dataSource: [Product] = []
    
    var tableBottomConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = [Product(image: UIImage(named: "milk")!, name: "Молоко 'Сернурское'", price: "67₽", count: "1шт."), Product(image: UIImage(named: "bananas")!, name: "Бананы", price: "124₽", count: "3шт."), Product(image: UIImage(named: "bread")!, name: "Хлеб 'Витебский'", price: "56₽", count: "1шт.")]
        
        setupLayout()
    }
    
    func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        view.addSubview(exitButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            exitButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -85),
            exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exitButton.heightAnchor.constraint(equalToConstant: 35),
            exitButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func handleExit() {
        self.dismiss(animated: true, completion: nil)
    }
}
