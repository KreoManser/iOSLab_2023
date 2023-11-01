//
//  PostsViewDataSource.swift
//  HW_106
//
//  Created by Азат Зиганшин on 01.11.2023.
//

import Foundation
import UIKit

class PostsViewDataSource: NSObject, UITableViewDataSource {

    static let shared = PostsViewDataSource()

    private override init() {}

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.syncGetAllPublications().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: PostsTableViewCell.reuseIdentifier,
            for: indexPath) as? PostsTableViewCell
        cell?.selectionStyle = .none
        cell?.indexPath = indexPath
        cell?.delegate = tableView.superview as? any DeleteAlertDelegate

        let publication = DataManager.shared.syncGetAllPublications()[indexPath.row]
        cell?.configureCell(with: publication)

        return cell!
    }

}

