import UIKit

class PostView: UIView {
    private lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search"
        bar.tintColor = .black
        bar.delegate = self
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()

    lazy var postTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    weak var postViewController: PostViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        setupLayouts()
        setupSwipeGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostView {
    func setupLayouts() {
        addSubview(searchBar)
        addSubview(postTableView)

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            postTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 15),
            postTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            postTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            postTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    func setupDataSource(_ dataSource: UITableViewDataSource) {
        postTableView.dataSource = dataSource
    }

    func reloadData() {
        postTableView.reloadData()
    }

    func scrollToPost(_ indexPath: IndexPath) {
        postTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
}

extension PostView {
    func setupSwipeGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))

        swipeGesture.direction = .right
        self.addGestureRecognizer(swipeGesture)
    }

    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right {
            postViewController?.dismissPostScreen()
        }
    }
}

extension PostView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let postViewController = postViewController else { return }
        postViewController.findByName(searchText)

        guard let text = searchBar.text else { return }

        if text.isEmpty {
            DataManager.shared.isSearching = false
        } else {
            DataManager.shared.isSearching = true
        }
        reloadData()
    }
}
