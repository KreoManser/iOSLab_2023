import UIKit

class PublisherViewController: UIViewController, PublisherCellDelegate {
    func postDeleted(at indexPath: IndexPath?) {
        if let indexPath = indexPath {
            print(indexPath.row)
            OperationQueue.main.addOperation {
                
                self.tablePublisher.beginUpdates()
                self.tablePublisher.deleteRows(at: [indexPath], with: .fade)
                self.tablePublisher.endUpdates()
            }
        }
    }
    
    var selectedIndexPath: IndexPath?
    
    lazy var tablePublisher: UITableView =  {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .singleLine
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .clear
        table.register(PublisherTableViewCell.self, forCellReuseIdentifier: "Publisher")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(tablePublisher)
        setupLayout()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let indexPath = selectedIndexPath {
            tablePublisher.scrollToRow(at: indexPath, at: .top, animated: true)
            selectedIndexPath = nil
        }
    }
    func setupLayout() {
        NSLayoutConstraint.activate([
            tablePublisher.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            tablePublisher.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tablePublisher.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tablePublisher.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10)
        ])
    }

}
extension PublisherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Manager.publishers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Publisher", for: indexPath) as? PublisherTableViewCell else {
            // Handle the case where the cell cannot be cast to PublisherTableViewCell
            return UITableViewCell() // Or any other appropriate action
        }
        
        let publisher = Manager.publishers[indexPath.row]
        
        cell.configure(with: publisher)
        cell.delegate = self
        
        cell.configure(with: publisher)
    
        cell.indexPath = indexPath
        cell.currentPublisher = publisher
        return cell
    }
}
extension PublisherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 350
    }
    
}
