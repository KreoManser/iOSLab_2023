import UIKit

class ProfileViewController: UIViewController, UpdateProfileDataManagerDelegate {
    let profileView = ProfileView()
    let dataManager = ProfileDataManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProfileView()
        addTargetForButton()
        ProfileDataManager.shared.delegate = self
        ProfileDataManager.shared.navigationController = navigationController
        profileView.configUser(user: dataManager.user!)
        setButtonAction()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileView.collectionView.reloadData()
    }
    func setButtonAction() {
        print("2")
        profileView.setSettingsButtonActionClosure { [weak self] in
             let settingsViewController = SettingsViewController()
             self?.navigationController?.pushViewController(settingsViewController, animated: true)
         }
     }
    private func setUpProfileView() {
        profileView.collectionView.delegate = dataManager
        profileView.collectionView.dataSource = dataManager
        profileView.collectionView.register(
            ProfileCollectionViewCell.self,
            forCellWithReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier)
        view = profileView
    }
    func dataDidChange() {
        DispatchQueue.main.async {
            self.profileView.collectionView.reloadData()
            self.profileView.countPublicationLabel.text = String(self.dataManager.photosProfile.count)
        }
    }
    @objc func syncSaveButtonTapped() {
        let photo = Photo(id: UUID().uuidString, image: .avatar,
                          like: false, comment: "Работаю", author: "WorkCat", avatar: .avatar)
        dataManager.syncSave(model: photo)
    }
    @objc func asyncSaveButtonTapped() async {
        let photo = Photo(id: UUID().uuidString, image: .avatar,
                          like: false, comment: "Работаю", author: "WorkCat", avatar: .avatar)
        await dataManager.asyncSave(model: photo)
    }
    func addTargetForButton() {
        profileView.createContentButton.addTarget(self, action: #selector(syncSaveButtonTapped), for: .touchUpInside)
    }
}
