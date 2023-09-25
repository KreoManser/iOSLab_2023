import UIKit

class ShopViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(ShopTableViewCell.self, forCellReuseIdentifier: ShopTableViewCell.reuseIdentifier)
        return table
    }()
    var shopText: UILabel = {
        let text = UILabel ()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "Shop"
        text.textAlignment = .center
        text.backgroundColor = .systemBrown
        text.textColor = UIColor.white
        return text
    }()
    
    var data = [Product] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        initData()
        
        view.addSubview(tableView)
        view.addSubview(shopText)
        
        let textHeight: CGFloat = 30.0
        let textdWidth: CGFloat = 800.0
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
//          Ограничения для shopText
            shopText.topAnchor.constraint(equalTo: safeArea.topAnchor),
            shopText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shopText.widthAnchor.constraint(equalToConstant: textdWidth),
            shopText.heightAnchor.constraint(equalToConstant: textHeight),
            
//          Ограничения для tableView
            tableView.topAnchor.constraint(equalTo: shopText.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
            
        ])
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Categories"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShopTableViewCell.reuseIdentifier, for: indexPath) as! ShopTableViewCell
        
        let product = data[indexPath.row]
        cell.configureCell(with: product)

        return cell
    }
    
    func initData () {
        data = [
            Product(name: "Set", catImage: UIImage(named: "3in1Cats")!),
            Product(name: "King", catImage: UIImage(named: "kingCat")!),
            Product(name: "Mini", catImage: UIImage(named: "miniCat")!),
            Product(name: "Sport", catImage: UIImage(named: "sportCat")!),
            Product(name: "Barbie", catImage: UIImage(named: "msCat")!),
            Product(name: "Ken", catImage: UIImage(named: "mrCat")!),
            Product(name: "Funny", catImage: UIImage(named: "funnyCat")!),
            Product(name: "Sir", catImage: UIImage(named: "sirCat")!),
        ]
    }
    
}
