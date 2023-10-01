import UIKit

class ShopViewController: UIViewController {

    var dataSourcesNames: [String] = []
    var dataSourcesDescription: [String] = []
    
    lazy var shopLabel: UILabel = {
        let label = UILabel()
        label.text = "Магазин"
        label.font = UIFont.systemFont(ofSize: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var shopTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Indentifire")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        dataSourcesNames = ["Товар 1", "Товар 1", "Товар 1", "Товар 1", "Товар 1", "Товар 1", "Товар 1", "Товар 1", "Товар 1", "Товар 1", "Товар 1", "Товар 1", "Товар 1", "Товар 1", "Товар 1", "Товар 1"]
        dataSourcesDescription = ["Описание 1", "Описание 1", "Описание 1", "Описание 1", "Описание 1", "Описание 1", "Описание 1", "Описание 1", "Описание 1", "Описание 1", "Описание 1", "Описание 1", "Описание 1", "Описание 1", "Описание 1", "Описание 1",]
        
        view.addSubview(shopLabel)
        view.addSubview(shopTableView)
        setupLayoutConstrains()
    }
    
    func setupLayoutConstrains() {
        NSLayoutConstraint.activate([
            shopLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            shopLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            shopTableView.topAnchor.constraint(equalTo: shopLabel.bottomAnchor, constant: 20),
            shopTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            shopTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            shopTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

extension ShopViewController: UITableViewDataSource , UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourcesNames.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Indentifire", for: indexPath)
        
        let name = dataSourcesNames[indexPath.row]
        let description = dataSourcesDescription[indexPath.row]
        var listConfiguration = cell.defaultContentConfiguration()
        listConfiguration.text = name
        listConfiguration.image = .add
        listConfiguration.secondaryText = description
        
        cell.contentConfiguration = listConfiguration
        
        return cell
    }
    
    
}
