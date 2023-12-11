import UIKit
class SubscriptionPublicationsViewController: UIViewController {
    let subPublicationsView = SubscriptionPublicationsView()
    private let dataManager = SubscriptionPublicationsDataManager.shared
    private let storiesDataManager = StoriesDataManager.shared
    func dataDidChange() {
        DispatchQueue.main.async {
            self.subPublicationsView.mainCollectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPSubPublicationsView()
    }
    func setUpPSubPublicationsView() {
        view = subPublicationsView
        subPublicationsView.mainCollectionView.delegate = dataManager
        subPublicationsView.mainCollectionView.dataSource = dataManager
        subPublicationsView.mainCollectionView.register(
            SubsPublicationsCollectionViewCell.self,
            forCellWithReuseIdentifier: SubsPublicationsCollectionViewCell.reuseIdentifier)
        subPublicationsView.storiesCollectionView.delegate = storiesDataManager
        subPublicationsView.storiesCollectionView.dataSource = storiesDataManager
        subPublicationsView.storiesCollectionView.register(
            StoriesCollectionViewCell.self,
            forCellWithReuseIdentifier: StoriesCollectionViewCell.reuseIdentifier)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subPublicationsView.mainCollectionView.reloadData()
        subPublicationsView.storiesCollectionView.reloadData()
    }
}
