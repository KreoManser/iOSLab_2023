//
//  PublicationDataSource.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 02.11.2023.
//

import Foundation
import UIKit

class PostsDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    let dataManager = DataManager.sigelton
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("re")
        if dataManager.isSearching == false {
            return dataManager.syncGetAllPost().count
        } else {
            return dataManager.syncGetAllFilteredPost().count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "tableCell", for: indexPath) as? PostsTableViewCell else { fatalError() }
        let item: PostInfo
        if dataManager.isSearching == false {
            item = dataManager.syncGetAllPost()[indexPath.row]
        } else {
            item = dataManager.syncGetAllFilteredPost()[indexPath.row]
        }
        cell.postAvatarImageView.image = UIImage(named: dataManager.user?.userAvatarImageName ?? "")
        cell.postNameLabel.text = (dataManager.user?.userName ?? "")
        cell.postPhotoImageView.image = UIImage(named: item.postPhotoNmae)
        cell.postCommentLabel.text = "\(cell.postNameLabel.text ?? ""): \(item.postComment )"
        cell.postDateLabel.text = "\(item.postDate.getDataInString())"
        cell.postLikeCountLabel.text = "Лайков: \(item.counterLikes)"
        cell.delegate = tableView.superview as? any AllertConnection
        cell.superView = tableView
        cell.setUpLikeButton(cheker: item.isLiked)
        return cell
    }
}