//
//  NewsLineTableDataSource.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 07.12.2023.
//

import UIKit
import CoreData

class NewsLineTableDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    let coreDataManager = CoreDataManager.shared
    var fetchedResultController: NSFetchedResultsController<Post>!
    func setupFetchedResultController(
        fetchedResultController: NSFetchedResultsController<Post>) {
        self.fetchedResultController = fetchedResultController
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultController.sections?[section] else {
            return 0
        }
        return section.numberOfObjects
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "newsLineTableCell",
            for: indexPath) as? NewsLineTableViewCell else { return UITableViewCell() }
        let item = fetchedResultController.object(at: indexPath)
        let user = coreDataManager.obtaineSavedData().first(where: {$0.userId == item.userPostId})
        cell.postID = Int(item.postID)
        cell.postUserID = Int(item.userPostId)
        cell.postAvatarImageView.image = UIImage(named: user!.userAvatarImageName ?? "" )
        cell.postNameLabel.text = (user!.userName )
        cell.postPhotoImageView.image = UIImage(named: item.postPhotoNmae!)
        cell.postCommentLabel.text = "\(cell.postNameLabel.text ?? ""): \(item.postComment ?? "" )"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        cell.postDateLabel.text = dateFormatter.string(from: item.postDate)
        cell.postLikeCountLabel.text = "Лайков: \(item.counterLikes)"
        cell.delegate = tableView.superview as? any AllertConnectionNewsLine
        cell.superView = tableView
        cell.setUpLikeButton(cheker: item.isLiked)
        return cell
    }
}
