import UIKit
protocol MainUpdateWithOperationDelegate: AnyObject {
    func updateTable()
}
class ProfileViewController: UIViewController, MainUpdateWithOperationDelegate, UpdateDataDelegate {
    lazy  var profileView = ProfileView(frame: .zero)
    weak var delegate: MainUpdateWithOperationDelegate?
    override func loadView() {
        super.loadView()
        view = profileView
    }
    //var publishers: [Publisher] = []
    func updateData() {
        DataManager.asyncGetPublisher { publishers in
            self.profileView.publishers = publishers
           
            DispatchQueue.main.async {
                self.profileView.count = publishers.count
                self.updateTable()
            }
           
        }
    }
//    func updateData() {
//        Task {
//            publishers = await DataManager.asyncGetPublisher1()
//            await setData()
//        }
//    }
//    func setData() async {
//        self.profileView.publishers = self.publishers
//        self.profileView.count = self.publishers.count
//    }
     override func viewDidLoad() {
         super.viewDidLoad()
         profileView.controller = self
         profileView.setupNavigationBar()
         updateData()
     }
    func updateTable() {
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
