import UIKit

protocol ListOfPostsViewControllerDelegate: AnyObject {
    func reloadArrayAfterDeletingFromList(_ listOfPostsViewController: ListOfPostsViewController, didDeletePost post: Post)
}
class ListOfPostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var posts: [Post] = []

    let profileVC = ProfileViewController()
    let user: User?
    private var dataManager = DataManager()
    var index: IndexPath?
    weak var delegate: ListOfPostsViewControllerDelegate?

    init(index: IndexPath, user: User, posts: [Post]) {
        self.index = index
        self.user = user
        self.posts = posts
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)
        table.rowHeight = 675
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()
        view.backgroundColor = .white
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let selectedIndexPath = index {
            tableView.scrollToRow(at: selectedIndexPath, at: .top, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath) as? PostTableViewCell

        if let selectedUser = user {
            cell?.configureCell(with: posts[indexPath.row], user: selectedUser, viewController: self)
        }
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }

}
extension ListOfPostsViewController: PostTableViewCellDelegate {
    func reloadArrayAfterDeleting(_ postTableViewCell: PostTableViewCell, didDeletePost post: Post) {
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            posts.remove(at: index)
        }
        delegate?.reloadArrayAfterDeletingFromList(self, didDeletePost: post)
        tableView.reloadData()
//        print("№№№№№№№count of posts in profile table view\(posts)")

    }
}
extension ListOfPostsViewController: ProfilePostLikeDataManagerDelegate {
    func reloadArrayAfterLiking(_ dataManager: DataManager) {
        posts = dataManager.syncGetPosts()
        tableView.reloadData()
        print("!!!!!!!!count of posts in profile table view\(posts)")
    }
}
