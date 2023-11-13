//
//  DetailDataManager.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 02.11.2023.

import Foundation
import UIKit

class DetailDataManager: NSObject, UITableViewDataSource, UITableViewDelegate, DetailTableViewCellDelegate {
    func didDeletePublication(publication: DetailPublication) {
        profileDataManager.asyncDelete(
            ProfilePublication(
                id: publication.id,
                image: publication.postImage,
                caption: publication.caption,
                date: publication.date,
                isFavorite: publication.isFavorite,
                userProfile: (userName: publication.accountName, avatar: publication.avatarImage)
            ),
            completion: { result in
            switch result {
            case .success:
                print("Удаление прошло успешно")
            case .failure(let error):
                print("Ошибка получения постов: \(error)")
            }
        })
        if let index = detailPublication.firstIndex(where: { $0 == publication }) {
            detailPublication.remove(at: index)
        }
        reloadData!()
    }
    var optionsTapped: ((_ alertController: UIAlertController) -> Void)?
    var reloadData: (() -> Void)?

    private var detailPublication: [DetailPublication] = []
    private var filteredPosts: [DetailPublication] = []
    private var publicationArray: [ProfilePublication] = []

    private var profileDataManager = ProfileDataManager.shared

    override init() {
        super.init()
        if publicationArray.isEmpty {
            getPosts(dataManager: profileDataManager)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredPosts.isEmpty {
            return detailPublication.count
        } else {
            return filteredPosts.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var publication: DetailPublication
        if filteredPosts.isEmpty {
            publication = detailPublication[indexPath.row]
        } else {
            publication = filteredPosts[indexPath.row]
        }
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
                    self.detailPublication.append(
                        DetailPublication(
                            id: publication.id,
                            avatarImage: publication.userProfile.avatar,
                            accountName: publication.userProfile.userName,
                            postImage: publication.image,
                            caption: publication.caption,
                            date: publication.date,
                            isFavorite: publication.isFavorite)
                    )
                }
            case .failure(let error):
                print("Ошибка получения постов: \(error)")
            }
        }
    }
}
