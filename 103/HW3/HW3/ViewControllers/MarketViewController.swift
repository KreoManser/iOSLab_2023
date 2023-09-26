import UIKit

class MarketViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.register(CategoryTableViewCell.self, forCellReuseIdentifier: "CategoryTableViewCell")
        
        return table
    }()
    
    private lazy var exitButton: UIButton = {
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
    
    var dataSource: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = [Category(name: "Молочная продукция", image: UIImage(named: "molochka")!), Category(name: "Выпечка", image: UIImage(named: "bakers")!), Category(name: "Фрукты", image: UIImage(named: "fruits")!), Category(name: "Овощи", image: UIImage(named: "vegetables")!)]
        
        setupLayout()
    }
    
    func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        view.addSubview(exitButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
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

extension MarketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        let category = dataSource[indexPath.row]
        cell.configureCell(category: category)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
}
