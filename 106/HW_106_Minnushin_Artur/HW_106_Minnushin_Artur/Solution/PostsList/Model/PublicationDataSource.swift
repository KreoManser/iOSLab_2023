//
//  PublicationDataSource.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 02.11.2023.
//

import Foundation
import UIKit

class PublicationDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    let dataManager = DataManager.sigelton
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataManager.isSearching == false {
            dataManager.syncGetAllPost().count
        } else {
            dataManager.syncGetAllFilteredPost().count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "tableCell", for: indexPath) as? PublicationTableViewCell else { fatalError() }
        let item: PostInfo
        if dataManager.isSearching == false {
            item = dataManager.syncGetAllPost()[indexPath.row]
        } else {
            item = dataManager.syncGetAllFilteredPost()[indexPath.row]
        }
        cell.postAvatarImageView.image = UIImage(named: "avatar")
        cell.postNameLabel.text = "Artur Minnushin"
        cell.postPhotoImageView.image = UIImage(named: item.postPhotoNmae)
        cell.postCommentLabel.text = "\(cell.postNameLabel.text!): \(item.postComment)"
        cell.postDateLabel.text = "\(item.postDate)"
        cell.delegate = tableView.superview as? any AllertConnection
        cell.superView = tableView
        return cell
    }
}
