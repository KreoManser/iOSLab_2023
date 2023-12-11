//
//  PostsDataManager.swift
//  homework_10
//
//  Created by Кирилл Щёлоков on 10.12.2023.
//

import Foundation
import UIKit

class PostsDataManager: NSObject, UITableViewDataSource, UITableViewDelegate, PostTableViewCellDelegate, UISearchBarDelegate {

    var optionsTapped: ((_ alertController: UIAlertController) -> Void)?
    var reloadData: (() -> Void)?

    private var postsModels: [Post] = []
    private var filteredPosts: [Post] = []
    private var postsArray: [Post] = []

    private let profileDataManager = ProfileDataManager.shared

    private let coreDataManager = CoreDataManager.shared

    override init() {
        super.init()
        if postsArray.isEmpty {
            getPosts(dataManager: profileDataManager)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredPosts.isEmpty {
            return postsModels.count
        } else {
            return filteredPosts.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var post: Post
        if filteredPosts.isEmpty {
            post = postsModels[indexPath.row]
        } else {
            post = filteredPosts[indexPath.row]
        }

        let cell = PostTableViewCell(style: .default, reuseIdentifier: nil)

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
        postsModels = coreDataManager.obtainAllPosts()
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

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredPosts = postsModels
            reloadData?()
        } else {
            profileDataManager.asyncSearchPosts(by: searchText, completion: { [weak self] result in
                switch result {
                case .success(let posts):
                    self?.filteredPosts = posts
                    self?.reloadData?()
                case .failure(let error):
                    print("Ошибка получения постов: \(error)")
                }

            })
        }
    }
}
