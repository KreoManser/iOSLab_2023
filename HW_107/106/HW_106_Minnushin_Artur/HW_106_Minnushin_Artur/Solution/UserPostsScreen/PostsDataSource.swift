//
//  PublicationDataSource.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 02.11.2023.
//

import Foundation
import UIKit

class PostsDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    let dataManager = CoreDataManager.shared
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.getPostsAuthorizationUser().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "tableCell", for: indexPath) as? PostsTableViewCell else { fatalError() }
        let item = dataManager.getPostsAuthorizationUser()[indexPath.row]
        let user = dataManager.getAuthorizationUser()
        cell.userId = Int(user.userId)
        cell.postId = Int(item.postID)
        cell.postAvatarImageView.image = UIImage(named: user.userAvatarImageName!)
        cell.postNameLabel.text = (user.userName)
        cell.postPhotoImageView.image = UIImage(named: item.postPhotoNmae!)
        cell.postCommentLabel.text = "\(cell.postNameLabel.text ?? ""): \(item.postComment ?? "" )"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        cell.postDateLabel.text = dateFormatter.string(from: item.postDate)
        cell.postLikeCountLabel.text = "Лайков: \(item.counterLikes)"
        cell.delegate = tableView.superview as? any AllertConnection
        cell.setUpLikeButton(cheker: item.isLiked)
        return cell
    }
}
