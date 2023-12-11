import UIKit
class SubscriptionPublicationsView: UIView {
    lazy var mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        let screenWidth = UIScreen.main.bounds.width
        let numberOfItemsInRow: CGFloat = 1
        let itemWidth = (screenWidth - (numberOfItemsInRow - 1) * layout.minimumInteritemSpacing) / numberOfItemsInRow
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return mainCollectionView
    }()
    lazy var storiesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        let screenWidth = UIScreen.main.bounds.width
        let numberOfItemsInRow: CGFloat = 3
        let itemWidth = (screenWidth - (numberOfItemsInRow - 1) * layout.minimumInteritemSpacing) / numberOfItemsInRow
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        storiesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return storiesCollectionView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUp() {
        setUpStoriesCollectionView()
        setUpMainCollectionView()
    }
    private func setUpStoriesCollectionView() {
        addSubview(storiesCollectionView)
        storiesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        storiesCollectionView.backgroundColor = .black
        NSLayoutConstraint.activate([
            storiesCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -80),
            storiesCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            storiesCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            storiesCollectionView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    private func  setUpMainCollectionView() {
        addSubview(mainCollectionView)
        mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
        mainCollectionView.backgroundColor = .black
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: storiesCollectionView.bottomAnchor, constant: 2),
            mainCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            mainCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
