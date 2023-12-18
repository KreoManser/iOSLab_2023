//
//  UserPostsDataManager.swift
//  homework_11
//
//  Created by Кирилл Щёлоков on 18.12.2023.
//

import Foundation
import UIKit

class UserPostsDataManager: NSObject, UITableViewDataSource, UITableViewDelegate, UserPostsTableViewCellDelegate {

    var optionsTapped: ((_ alertController: UIAlertController) -> Void)?
    var reloadData: (() -> Void)?

    private var postsModels: [Post] = []

    private let profileDataManager = ProfileDataManager.shared

    private let coreDataManager = CoreDataManager.shared

    override init() {
        super.init()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getPosts(dataManager: profileDataManager)
        return postsModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = postsModels[indexPath.row]

        let cell = UserPostsTableViewCell(style: .default, reuseIdentifier: nil)

        cell.optionsTapped = { [weak self] alertController, authorName in
            if self?.coreDataManager.getAuthUser()?.login ?? "" == authorName {
                self?.optionsTapped?(alertController)
            } else {
                let alert = UIAlertController(title: "Ошибка", message: "Вы не можете удалить данную запись", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self?.optionsTapped?(alert)
            }
        }

        cell.likeTapped = { [weak self] in
            self?.coreDataManager.likePostByUser(post: post)
            return self?.coreDataManager.getLikeCountForPost(post: post) ?? 0
        }

        cell.unlikeTapped = { [weak self] in
            self?.coreDataManager.unlikePostByUser(post: post)
            return self?.coreDataManager.getLikeCountForPost(post: post) ?? 0
        }

        cell.configure(with: post, likeCount: coreDataManager.getLikeCountForPost(post: post), isLiked: coreDataManager.isPostLikedByUser(post: post))
        cell.delegate = self

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 420
    }

    private func getPosts(dataManager: ProfileDataManager) {
        postsModels = coreDataManager.obtainPostsForAuthUser()
    }

    func didDeletePost(postModel: Post) {

        profileDataManager.asyncDelete(postModel, completion: { result in
            switch result {
            case .success:
                print("Удаление прошло успешно")
            case .failure(let error):
                print("Ошибка получения постов: \(error)")
            }
        })

        if let index = postsModels.firstIndex(where: { $0.id == postModel.id }) {
            postsModels.remove(at: index)
        }

        coreDataManager.deletePostById(id: postModel.id)

        reloadData?()
    }
}
