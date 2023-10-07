import UIKit

class ShopViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.separatorStyle = .none
        table.register(ShopTableViewCell.self, forCellReuseIdentifier: ShopTableViewCell.reuseIdentifier)
        table.estimatedRowHeight = 120
        return table
    }()
    
    private lazy var backButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Back"
        config.baseForegroundColor = .blue
        
        return UIButton(
            configuration: config,
            primaryAction: UIAction { [weak self] _ in
                self?.backButtonTapped()
            })
    }()
    
    private func backButtonTapped(){
        let nextVC = ProfileViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    var dataSource:[Product] = []
    var tableBottomConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        _ = UIScrollView()
        
        dataSource = Array(repeating: Product(name: "Car", price: "200", color: "Yellow", ProductImage: UIImage(named: "car")), count: 20)
        addSubviews(tableView,backButton)
        configureUI()
    }
}

extension ShopViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ShopTableViewCell.reuseIdentifier, for: indexPath) as! ShopTableViewCell
        
        let user = dataSource[indexPath.row]
        cell.configureCell(with: user)
        
        return cell
    }
    
    private func addSubviews(_ subviews: UIView...) {
        subviews.forEach { view.addSubview($0) }
    }
    
    func configureUI(){
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 50),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
}
