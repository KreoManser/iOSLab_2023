import UIKit

class PostViewController: UIViewController {
    private var indexPath: IndexPath?
    private var postView = PostView(frame: .zero)
    let postDataSource = PostTableViewDataSource()

    override func loadView() {
        view = postView
        postView.setupDataSource(postDataSource)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        postView.postViewController = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let index = self.indexPath else { return }
        postView.scrollToPost(index)
    }

    init(indexPathToScroll: IndexPath) {
        super.init(nibName: "", bundle: nil)
        self.indexPath = indexPathToScroll
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostViewController {
    func delete(_ indexPath: IndexPath) {
        DataManager.shared.syncDelete(indexPath.row + 1)
        postView.reloadData()
    }

    func dismissPostScreen() {
        dismiss(animated: true)
    }

    func findByName(_ name: String) {
        DataManager.shared.syncFindByName(name)
    }
}
