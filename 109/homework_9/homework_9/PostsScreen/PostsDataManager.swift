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
    private let userDefaults = UserDefaults.standard
    private var likedArray: [String] = []

    override init() {
        super.init()
        likedArray = getAllLikedPosts()
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

        let cell = PostTableViewCell(style: .default, reuseIdentifier: nil)

        cell.optionsTapped = { [weak self] alertController, authorName in
            if self?.getAuthUser()?.login ?? "" == authorName {
                self?.optionsTapped?(alertController)
            } else {
                let alert = UIAlertController(title: "Ошибка", message: "Вы не можете удалить данную запись", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self?.optionsTapped?(alert)
            }
        }

        cell.likeTapped = { [weak self] in
            self?.likedArray.append(post.caption)
            self?.saveLikedPosts()
        }

        cell.unlikeTapped = { [weak self] in
            self?.likedArray.removeAll(where: {$0 == post.caption})
            self?.saveLikedPosts()
        }

        cell.configure(with: post, isLiked: self.likedArray.contains(where: {$0 == post.caption}))
        cell.delegate = self

        return cell
    }

    func getAuthUser() -> User? {
        do {
            guard let user = UserDefaults.standard.data(forKey: "loggedInUser") else { return nil}
            let decodedUser = try JSONDecoder().decode(User.self, from: user)
            return decodedUser
        } catch {
            print("obtain error \(error)")
        }
        return nil
    }

    private func saveLikedPosts() {
        userDefaults.set(likedArray, forKey: getAuthUser()?.login ?? "")
    }

    private func getAllLikedPosts() -> [String] {
        guard let posts = userDefaults.array(forKey: getAuthUser()?.login ?? "") as? [String] else {return []}
        return posts
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }

    private func getPosts(dataManager: ProfileDataManager) {
        dataManager.asyncGetAllPosts { result in
            switch result {
            case .success(let posts):
                for post in posts {
                    self.postsModels.append(PostModel(logoImage: post.image ?? UIImage.question, id: post.id, postImage: post.image,
                        caption: post.caption, date: post.date, isFavorite: post.isFavorite, author: (post.author.0, post.author.1)))
                }
            case .failure(let error):
                print("Ошибка получения постов: \(error)")
            }
        }
    }

    func didDeletePost(postModel: PostModel) {

        profileDataManager.asyncDelete(Post(id: postModel.id, image: postModel.postImage, caption: postModel.caption,
            date: postModel.caption, isFavorite: postModel.isFavorite, author: postModel.author), completion: { result in
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
                    self?.filteredPosts = []
                    for post in posts {
                        self?.filteredPosts.append(PostModel(logoImage: post.image ?? UIImage.question, id: post.id, postImage: post.image,
                            caption: post.caption, date: post.date, isFavorite: post.isFavorite, author: (post.author.0, post.author.1)))
                    }
                    self?.reloadData?()
                case .failure(let error):
                    print("Ошибка получения постов: \(error)")
                }

            })
        }
    }
}
