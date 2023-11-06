import UIKit

class PostsDataManager: NSObject {
    var optionsTapped: ((_ alertController: UIAlertController) -> Void)?
    var reloadData: (() -> Void)?

    private var postsModels: [PostModel] = []
    private var filteredPosts: [PostModel] = []
    private var postsArray: [Post] = []
    private let profileDataManager = ProfileDataManager.shared

    override init() {
        super.init()
        if postsArray.isEmpty {
            getPosts(dataManager: profileDataManager)
        }
    }
}

// MARK: - UITableViewDataSource

extension PostsDataManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPosts.isEmpty ? postsModels.count : filteredPosts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var post: PostModel
        if filteredPosts.isEmpty {
            post = postsModels[indexPath.row]
        } else {
            post = filteredPosts[indexPath.row]
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        PostTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }

        cell.optionsTapped = { [weak self] alertController in
            self?.optionsTapped?(alertController)
        }

        cell.configure(with: post)
        cell.delegate = self

        return cell
    }
}

// MARK: - UITableViewDelegate

extension PostsDataManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}

// MARK: - PostTableViewCellDelegate

extension PostsDataManager: PostTableViewCellDelegate {
    func didDeletePost(postModel: PostModel) {
        profileDataManager.asyncDelete(Post(id: postModel.id,
                                            image: postModel.postImage,
                                            description: postModel.description,
                                            date: postModel.date)) { result in
            switch result {
            case .success:
                print("Post deleted successfully")
            case .failure(let error):
                print("Error deleting post: \(error)")
            }
        }

        if let index = postsModels.firstIndex(where: { $0 == postModel }) {
            postsModels.remove(at: index)
        }
        reloadData?()
    }
}

// MARK: - UISearchBarDelegate

extension PostsDataManager: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredPosts = postsModels
            reloadData?()
        } else {
            profileDataManager.asyncSearchPosts(by: searchText) { [weak self] result in
                switch result {
                case .success(let posts):
                    self?.filteredPosts = posts.map { PostModel(id: $0.id, postImage: $0.image,
                                                                description: $0.description, date: $0.date) }
                    self?.reloadData?()
                case .failure(let error):
                    print("Error searching posts: \(error)")
                }
            }
        }
    }
}

// MARK: - Extension

extension PostsDataManager {
    private func getPosts(dataManager: ProfileDataManager) {
        dataManager.asyncGetAllPosts { [weak self] result in
            switch result {
            case .success(let posts):
                self?.postsModels = posts.map { PostModel(id: $0.id, postImage: $0.image,
                                                          description: $0.description, date: $0.date) }
            case .failure(let error):
                print("Error fetching posts: \(error)")
            }
        }
    }
}
