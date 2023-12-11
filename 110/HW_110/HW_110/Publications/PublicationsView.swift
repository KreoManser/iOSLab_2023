import UIKit
class PublicationsView: UIView {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        let screenWidth = UIScreen.main.bounds.width
        let numberOfItemsInRow: CGFloat = 1
        let itemWidth = (screenWidth - (numberOfItemsInRow - 1) * layout.minimumInteritemSpacing) / numberOfItemsInRow
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    lazy var searchBar: UISearchBar = UISearchBar()
    var indexPath: IndexPath = []
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUp() {
        setUpSearchBar()
        setUpCollectionView()
    }
    private func setUpSearchBar() {
        addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Поиск"
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    private func  setUpCollectionView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
