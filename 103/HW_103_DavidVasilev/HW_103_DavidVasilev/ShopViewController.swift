import UIKit

class ShopViewController: UIViewController, UITableViewDelegate{
    var dataSource: [Product ] = []
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.separatorStyle = .none
        table.register( ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.reuseIdentifier)
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let pattern = Product(name: "Honey",price: 455.90,productImage:UIImage(named:"honey")!, addInBusketButton: UIButton())
        dataSource = Array(repeating: pattern,count: 30)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
extension ShopViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reuseIdentifier, for: indexPath) as! ProductTableViewCell
        
        let product = dataSource[indexPath.row]
        cell.layer.borderWidth = 1
        cell.configureCell(with: product)
        let backButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(exitButtonTapped(_:)))
        navigationItem.leftBarButtonItem = backButton
        return cell
    }
    @objc func exitButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
