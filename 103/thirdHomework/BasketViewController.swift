import UIKit

class BasketViewController: UIViewController {
    
    private lazy var titleLableView: UILabel = {
        let titleLableView = UILabel()
        titleLableView.text = "Корзина"
        titleLableView.translatesAutoresizingMaskIntoConstraints = false
        titleLableView.textColor = .black
        titleLableView.font = UIFont.boldSystemFont(ofSize: 30.0)
        return titleLableView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Identifier")
        return tableView
    }()
    
    private lazy var exitButtonView: UIButton = {
        let exitButtonView = UIButton()
        exitButtonView.translatesAutoresizingMaskIntoConstraints = false
        exitButtonView.backgroundColor = .systemGray4
        exitButtonView.layer.cornerRadius = 10.0
        exitButtonView.setTitle("Выйти", for: .normal)
        exitButtonView.setTitleColor(.black, for: .normal)
        exitButtonView.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        exitButtonView.addTarget(self, action: #selector(exitToProfileViewController), for: .touchDown)
        return exitButtonView
    }()
    
    @objc private func exitToProfileViewController() {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    private var dataSource: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        dataSource = [ "Мусор", "Мусор", "Мусор", "Мусор", "Мусор","Мусор", "Мусор", "Мусор", "Мусор", "Мусор","Мусор", "Мусор", "Мусор", "Мусор", "Мусор","Мусор", "Мусор", "Мусор", "Мусор", "Мусор", ]
        view.addSubview(tableView)
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(titleLableView)
        view.addSubview(exitButtonView)
      
        NSLayoutConstraint.activate([
            titleLableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            
            tableView.topAnchor.constraint(equalTo: titleLableView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: exitButtonView.topAnchor, constant: -30),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            exitButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            exitButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exitButtonView.widthAnchor.constraint(equalToConstant: 223),
        ])
    }
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Identifier", for: indexPath)
        
        let model = dataSource[indexPath.row]
        var listConfiguration = cell.defaultContentConfiguration()
        
        listConfiguration.text = model
        cell.contentConfiguration = listConfiguration
        
        return cell
    }
    
}
