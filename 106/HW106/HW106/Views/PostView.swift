import UIKit

class PostView: UIView {
    private lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search"
        bar.tintColor = .black
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
        postTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

extension PostView: PostTableAlertDelegate {
    func presentAlert(indexPath: IndexPath) {
        let alert = UIAlertController(title: "",
        message: "Are you sure you want to delete this post? Access to it will be lost forever!",
        preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.postViewController?.delete(indexPath)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        postViewController?.present(alert, animated: true)
    }

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
