//
//  DetailDataManager.swift
//  CatGram
//
//  Created by Аделя Миннехузина on 01.11.2023.
//

import Foundation
import UIKit

class DetailDataManager: NSObject, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    var optionsTapped: ((_ alertController: UIAlertController) -> Void)?
    var reloadData: (() -> Void)?
    static let shared = DetailDataManager()

    private var posts: [Post] = []

    private let profileDataManager = ProfileDataManager.shared

    override init() {
        super.init()
        if posts.isEmpty {
            getPosts(dataManager: profileDataManager)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]

        var cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.reuseIdentifier, for: indexPath) as? DetailTableViewCell

        cell?.configure(with: post)
        cell?.backgroundColor = .black
        cell?.selectionStyle = .none

        guard let cell = cell else { return UITableViewCell() }

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
                    self.posts.append(Post(id: post.id, image: post.image, caption: post.caption, date: post.date, isFavorite: post.isFavorite))
                }
            case .failure(let error):
                print("Ошибка получения постов: \(error)")
            }
        }
    }

    func deletePost(index: Int) {
        posts.remove(at: index)
    }

}
