//
//  DetailDataManager.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 02.11.2023.

import Foundation
import UIKit

protocol DetailDataManagerDelegate: AnyObject {
    func refreshProfile() async
}

class DetailDataManager: NSObject, UITableViewDataSource, UITableViewDelegate, DetailTableViewCellDelegate {

    static var shared = DetailDataManager()
    var optionsTapped: ((_ alertController: UIAlertController) -> Void)?
    var reloadData: (() -> Void)?
    private var dataLoadCompletion: (() -> Void)?
    weak var delegate: DetailDataManagerDelegate?

    var detailPublication: [String: [DetailPublication]] = [:]

    private override init() {
        super.init()
            getPosts(dataManager: ProfileDataManager.shared)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let user = UserDefaults.standard.string(forKey: "user") ?? ""
        if let posts = detailPublication[user] {
            print("Number of posts for user \(user): \(posts.count)")
            return posts.count
        } else {
            print("No posts found for user \(user)")
            return 0
        }
    }
    private func syncGetAllPost(forUser user: String) -> [DetailPublication] {
        return detailPublication[user] ?? []
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let publication = syncGetAllPost(forUser: UserDefaults.standard.string(forKey: "user") ?? "")[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.reuseIdentifier, for: indexPath) as? DetailTableViewCell
        else { return UITableViewCell() }
        cell.optionsTapped = { [weak self] alertController in
            self?.optionsTapped!(alertController)
        }
        cell.configure(with: publication)
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        550
    }

    private func getPosts(dataManager: ProfileDataManager) {
        dataManager.asyncGetAllPosts { result in
            switch result {
            case .success(let publications):
                for publication in publications {
                    if self.detailPublication[publication.userProfile.userName] == nil {
                        self.detailPublication[publication.userProfile.userName] = []
                    }
                    self.detailPublication[publication.userProfile.userName]?.append(DetailPublication(
                        id: publication.id,
                        avatarImage: publication.userProfile.avatar,
                        accountName: publication.userProfile.userName,
                        postImage: publication.image,
                        caption: publication.caption,
                        date: publication.date,
                        isLiked: publication.isLiked))
                }
            case .failure(let error):
                print("Ошибка получения постов: \(error)")
            }
        }
    }

    func setCompletionHandler(_ completion: @escaping () -> Void) {
        dataLoadCompletion = completion
    }

    func didDeletePublication(publication: DetailPublication) {
        ProfileDataManager.shared.asyncDelete(
            ProfilePublication(
                id: publication.id,
                image: publication.postImage,
                caption: publication.caption,
                date: publication.date,
                isLiked: publication.isLiked,
                userProfile: (userName: publication.accountName, avatar: publication.avatarImage)
            ),
            completion: { result in
                switch result {
                case .success:
                    Task {
                        await self.delegate?.refreshProfile()
                    }
                    print("Удаление прошло успешно")
                case .failure(let error):
                    print("Ошибка получения постов: \(error)")
                }
            })
        if let index = detailPublication[publication.accountName]?.enumerated().first(where: { $0.element == publication })?.offset {
            detailPublication[publication.accountName]?.remove(at: index)
            reloadData?()
        }
        reloadData!()
    }
}

