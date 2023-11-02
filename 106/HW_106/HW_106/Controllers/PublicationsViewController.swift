import UIKit

class PublicationsViewController: UIViewController, UpdatePublicationsDataManagerDelegate {
    func dataDidChange() {
        DispatchQueue.main.async {
            self.publicationsView.collectionView.reloadData()
        }
    }
    var selectedPublication: Int?
    let publicationsView = PublicationsView()
    private let dataManager = PublicationsDataManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.updateDelegate = self
        setUpPublicationsView()
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        DispatchQueue.main.async {
            self.publicationsView.collectionView
                .scrollToItem(at: IndexPath(item: self.selectedPublication ?? 0, section: 0),
                at: .centeredVertically, animated: true)
        }
    }
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            dataManager.sortedPublications = []
            navigationController?.popViewController(animated: true)
        }
    }
    private func setUpPublicationsView() {
        publicationsView.collectionView.delegate = dataManager
        publicationsView.collectionView.dataSource = dataManager
        publicationsView.searchBar.delegate = dataManager
        publicationsView.collectionView
            .register(PublicationCollectionViewCell.self,
            forCellWithReuseIdentifier: PublicationCollectionViewCell.reuseIdentifier)
        view = publicationsView
        dataManager.funcButtonTapped = { [weak self] alertController in
            self?.present(alertController, animated: true, completion: nil)
        }
    }
}

