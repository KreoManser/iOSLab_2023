//
//  NewsLineTableDataSource.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 07.12.2023.
//

import UIKit

class NewsLineTableDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    let dataManager = DataManager.sigelton
    var posts: [PostInfo] = []
    override init() {
        dataManager.getAllPostsFriends()
        posts = dataManager.postNewsLine
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "newsLineTableCell",
            for: indexPath) as? NewsLineTableViewCell else { return UITableViewCell() }
        let item = dataManager.postNewsLine[indexPath.row]
        let user = dataManager.getUserByID(id: item.userPostId)
        cell.postID = item.postID
        cell.postUserID = item.userPostId
        cell.postAvatarImageView.image = UIImage(named: user.userAvatarImageName ?? "" )
        cell.postNameLabel.text = (user.userName )
        cell.postPhotoImageView.image = UIImage(named: item.postPhotoNmae)
        cell.postCommentLabel.text = "\(cell.postNameLabel.text ?? ""): \(item.postComment )"
        cell.postDateLabel.text = "\(item.postDate.getDataInString())"
        cell.postLikeCountLabel.text = "Лайков: \(item.counterLikes)"
        cell.delegate = tableView.superview as? any AllertConnectionNewsLine
        cell.superView = tableView
        cell.setUpLikeButton(cheker: item.isLiked)
        return cell
    }
}
