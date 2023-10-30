import UIKit

class ProfileViewController: UIViewController, UpdateProfileDataManagerDelegate {
    let profileView = ProfileView()
    private let dataManager = ProfileDataManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProfileView()
        addTargetForButton()
        ProfileDataManager.shared.delegate = self
        ProfileDataManager.shared.navigationController = navigationController
    }
    private func setUpProfileView() {
        profileView.collectionView.delegate = dataManager
        profileView.collectionView.dataSource = dataManager
        profileView.collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier)
        view = profileView
    }
    func dataDidChange() {
        DispatchQueue.main.async {
            self.profileView.collectionView.reloadData()
            self.profileView.countPublicationLabel.text = String(self.dataManager.photos.count)
        }
    }
    @objc func syncSaveButtonTapped() {
        let photo = Photo(id: UUID().uuidString, image: .avatar, like: false, comment: "12")
        dataManager.syncSave(model: photo)
    }
    @objc func asyncSaveButtonTapped() {
        let photo = Photo(id: UUID().uuidString, image: .avatar, like: false, comment: "12")
        dataManager.asyncSave(model: photo) { result in
            switch result {
            case .success:
                print("Сохранение выполнено успешно. Количество фото в профиле: \(self.dataManager.photos.count)")
            case .failure(let error):
                print("Ошибка при сохранении: \(error)")
            }
        }
    }
    func addTargetForButton() {
        profileView.createContentButton.addTarget(self, action: #selector(asyncSaveButtonTapped), for: .touchUpInside)
    }
}
