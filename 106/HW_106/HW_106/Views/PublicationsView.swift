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
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUp() {
        setUpCollectionView()
    }
    private func  setUpCollectionView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        ])
    }
}
