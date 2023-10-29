//
//  PostsDataManager.swift
//  homework_6
//
//  Created by Кирилл Щёлоков on 29.10.2023.
//

import Foundation
import UIKit

class PostsDataManager: NSObject, UITableViewDataSource, UITableViewDelegate, PostTableViewCellDelegate, UISearchBarDelegate {

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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredPosts.isEmpty {
            return postsModels.count
        } else {
            return filteredPosts.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var post: PostModel
        if filteredPosts.isEmpty {
            post = postsModels[indexPath.row]
        } else {
            post = filteredPosts[indexPath.row]
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath) as? PostTableViewCell else { return UITableViewCell()}

        cell.optionsTapped = { [weak self] alertController in
            self?.optionsTapped!(alertController)
        }

        cell.configure(with: post)
        cell.delegate = self

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }

    private func getPosts(dataManager: ProfileDataManager) {
        dataManager.asyncGetAllPosts { result in
            switch result {
            case .success(let posts):
                for post in posts {
                    self.postsModels.append(PostModel(id: post.id, postImage: post.image, caption: post.caption, date: post.date, isFavorite: post.isFavorite))
                }
            case .failure(let error):
                print("Ошибка получения постов: \(error)")
            }
        }
    }

    func didDeletePost(postModel: PostModel) {

        profileDataManager.asyncDelete(Post(id: postModel.id, image: postModel.postImage, caption: postModel.caption, date: postModel.caption, isFavorite: postModel.isFavorite), completion: { result in
            switch result {
            case .success:
                print("Удаление прошло успешно")
            case .failure(let error):
                print("Ошибка получения постов: \(error)")
            }
        })

        if let index = postsModels.firstIndex(where: { $0 == postModel }) {
            postsModels.remove(at: index)
        }
        reloadData!()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredPosts = postsModels
            reloadData!()
        } else {
            profileDataManager.asyncSearchPosts(by: searchText, completion: { [weak self] result in
                switch result {
                case .success(let posts):
                    self?.filteredPosts = []
                    for post in posts {
                        self?.filteredPosts.append(PostModel(id: post.id, postImage: post.image, caption: post.caption, date: post.date, isFavorite: post.isFavorite))
                    }
                    self?.reloadData!()
                case .failure(let error):
                    print("Ошибка получения постов: \(error)")
                }

            })
        }
    }
}
