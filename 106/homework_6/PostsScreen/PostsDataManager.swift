//
//  PostsDataManager.swift
//  homework_6
//
//  Created by Кирилл Щёлоков on 29.10.2023.
//

import Foundation
import UIKit

class PostsDataManager: NSObject, UITableViewDataSource, UITableViewDelegate, PostTableViewCellDelegate {

    var deleteTapped: ((_ alertController: UIAlertController) -> Void)?
    var reloadData: (() -> Void)?

    private var postsModels: [PostModel] = []
    private var postsArray: [Post] = []

    private let profileDataManager = ProfileDataManager.shared

    override init() {
        super.init()
        if postsArray.isEmpty {
            getPosts(dataManager: profileDataManager)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = postsModels[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath) as? PostTableViewCell else { return UITableViewCell()}

        cell.deleteTapped = { [weak self] alertController in
            self?.deleteTapped!(alertController)
        }
        cell.isUserInteractionEnabled = false

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
}
