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

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PostsTableViewCell.reuseIdentifier,
            for: indexPath) as? PostsTableViewCell else {
            return UITableViewCell()
        }

        cell.selectionStyle = .none
        cell.indexPath = indexPath
        cell.delegate = tableView.superview as? any DeleteAlertDelegate

        DataManager.shared.asyncGetAllPublications(completion: { publications in
            let publication = publications[indexPath.row]
            cell.configureCell(with: publication)
        })

        return cell
    }

}

