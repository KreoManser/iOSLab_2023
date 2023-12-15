import UIKit

class ProfileViewController: UIViewController {
    private var profileView: ProfileView?
    private let dataSource = ProfileViewDataSource()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        profileView?.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        profileView = ProfileView(frame: view.bounds)
        view = profileView
        profileView?.profileViewController = self
        profileView?.setupDataSource(dataSource)
        guard let user = CoreDataManager.shared.getCurUser() else { return }
        profileView?.configureProfile(user: user)
        print(1)
    }
}

extension ProfileViewController {
    func postScreen(_ indexPath: IndexPath) {
        let postController = PostViewController(indexPathToScroll: IndexPath(row: 0, section: 0))
        postController.modalPresentationStyle = .fullScreen
        present(postController, animated: true)
    }

    func settingsScreen() {
        let presentController = SettingsViewController()
        presentController.modalPresentationStyle = .fullScreen
        present(presentController, animated: true)
    }

    func subsScreen() {
        let presentController = FriendViewController()
        presentController.modalPresentationStyle = .fullScreen
        present(presentController, animated: true)
    }
}
