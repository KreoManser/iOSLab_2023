import UIKit

class ProfileViewController: UIViewController {
    private var profileView = ProfileView(frame: .zero)
    private let dataSource = ProfileViewDataSource()

    override func loadView() {
        view = profileView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        profileView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        profileView.profileViewController = self
        profileView.setupDataSource(dataSource)

        Task {
            await profileView.configureProfile(user: LoginDataManager.loginShared.getCurUser())
        }
    }
}

extension ProfileViewController {
    func postScreen(_ indexPath: IndexPath) {
        let postController = PostViewController(indexPathToScroll: indexPath)
        postController.modalPresentationStyle = .fullScreen
        present(postController, animated: true)
    }
}
