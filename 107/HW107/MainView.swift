import UIKit

class MainView: UIView {
    private lazy var storiesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 85, height: 100)

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.showsHorizontalScrollIndicator = false
        collection.register(StoryCollectionViewCell.self, forCellWithReuseIdentifier: StoryCollectionViewCell.reuseIdentifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    lazy var postTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        setupLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainView {
    func setupLayouts() {
        addSubview(storiesCollectionView)
        addSubview(postTableView)

        NSLayoutConstraint.activate([
            storiesCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            storiesCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            storiesCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            storiesCollectionView.heightAnchor.constraint(equalToConstant: 115),

            postTableView.topAnchor.constraint(equalTo: storiesCollectionView.bottomAnchor, constant: 15),
            postTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            postTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            postTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    func setupPostTableViewDataSource(_ dataSource: UITableViewDataSource) {
        postTableView.dataSource = dataSource
    }

    func reloadPosts() {
        postTableView.reloadData()
    }

    func reloadStories() {
        storiesCollectionView.reloadData()
    }

    func reloadData() {
        reloadPosts()
        reloadStories()
    }
    func setupStoriesCollectionViewDataSource(_ dataSource: UICollectionViewDataSource) {
        storiesCollectionView.dataSource = dataSource
    }
}
