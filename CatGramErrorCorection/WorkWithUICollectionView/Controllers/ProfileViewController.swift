import UIKit
protocol MainUpdateWithOperationDelegate: AnyObject {
    func deletePost()
}
class ProfileViewController: UIViewController, MainUpdateWithOperationDelegate, ManagerDelegate, PublishersDelegate {
    lazy  var profileView = ProfileView(frame: .zero)
    weak var delegate: MainUpdateWithOperationDelegate?
    override func loadView() {
        super.loadView()
        view = profileView
    }
    func updateData() {
        DataManager.asyncGetPublisher { publishers in
            self.profileView.publishers = publishers
            DispatchQueue.main.async {
                self.profileView.count = publishers.count
            }
        }
    }
     override func viewDidLoad() {
         super.viewDidLoad()
         profileView.controller = self
         profileView.setupNavigationBar()
         updateData()
     }
    func deletePost() {
        profileView.gridCollectionView.reloadData()
    }
 }
extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let publisherViewController = PublisherViewController()
        publisherViewController.selectedIndexPath = indexPath
        publisherViewController.delegate = self
        publisherViewController.delegate1 = self
        present(publisherViewController, animated: true, completion: nil)
    }
}
