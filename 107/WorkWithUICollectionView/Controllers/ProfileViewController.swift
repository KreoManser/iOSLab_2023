import UIKit
class ProfileViewController: UIViewController, UpdateDataDelegate, UpdateDataEverythingControllers {

    lazy  var profileView = ProfileView(frame: .zero)
    var currentCat: User?

    override func loadView() {
        super.loadView()
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.controller = self
        profileView.setupNavigationBar()
        RegistrationDataManager.shared.delegate1 = self
        updateData()
    }
    func updateData() {
        Task {
            let cat = await RegistrationDataManager.shared.getCurrentUser()
            currentCat = cat
            profileView.count = cat?.publications.count ?? 0
            profileView.cat = cat
            profileView.gridCollectionView.reloadData()
        }
    }
}
extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let piblicationViewController = PublicationViewController()
        piblicationViewController.selectedIndexPath = indexPath
        piblicationViewController.delegate = self
        present(piblicationViewController, animated: true, completion: nil)
    }
}
