import UIKit

class BinViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(BinPageTableCell.self, forCellReuseIdentifier: BinPageTableCell.reuseIdentifire)
        return table
    }()
    
    var dataSource = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = [Product(image: UIImage(named: "milk") ?? UIImage.remove, name: "Молоко", cost: 2), Product(image: UIImage(named: "pashtet") ?? UIImage.remove, name: "Паштет", cost: 1)]
        
        view.backgroundColor = .white
        title = "Корзина"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
        setUpTableViewConstraints()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BinPageTableCell.reuseIdentifire, for: indexPath) as! BinPageTableCell
        let user = dataSource[indexPath.row]
        cell.configureCell(with: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
}

extension BinViewController {
    func setUpTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


