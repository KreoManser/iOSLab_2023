import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate {

    var posts: [Post] = []
    var stories: [Story] = []
    var user: User?
    private var dataManager = DataManager()

    init() {
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
        table.rowHeight = 675
        return table
    }()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 1 // Интервал между элементами
        layout.minimumLineSpacing = 1

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "FeedCell")
        collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: "FeedCollectionViewCell")

        initStories()
        posts = dataManager.syncGetPosts()

        tableView.reloadData()
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 85),

            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 2),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.feedCellReuseIdentifier, for: indexPath) as? FeedTableViewCell

        if let selectedUser = user {
            cell?.configureCell(with: posts[indexPath.row], user: selectedUser, viewController: self)
        }
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        stories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FeedCollectionViewCell.reuseIdentifier,
            for: indexPath) as? FeedCollectionViewCell
        cell?.configureCell(with: stories[indexPath.row])
        return cell ?? UICollectionViewCell()
    }

    func initStories() {
        if let image1 = UIImage(named: "msCat") {
            stories.append(Story(avatarImage: image1, username: "misskitty"))
        }
        if let image2 = UIImage(named: "kingCat") {
            stories.append(Story(avatarImage: image2, username: "kingcat"))
        }
    }

}
extension FeedViewController: FeedTableViewCellDelegate {
    func reloadArrayAfterDeletingFromFeedCell(_ feedTableViewCell: FeedTableViewCell, didDeletePost post: Post) {
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            posts.remove(at: index)
        }
        tableView.reloadData()
    }
//        print("!!!!!!!! posts in FeedVC before 1) : \(posts.count)")
//        Task {
//            posts = await dataManager.asyncGetPosts()
//            tableView.reloadData()
//            print("########## posts in FeedVC after 2): \(posts.count)")
//        }
}
