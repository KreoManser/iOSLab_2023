//
//  TableViewDataSource.swift
//  InstaCat
//
//  Created by Камил Хайрутдинов on 29.10.2023.
//

import Foundation
import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath) as? PostTableViewCell
        let post = DataManager.shared.syncGetAllPosts()[indexPath.row]

        cell?.delegate = tableView.superview as? any PostTableAlertDelegate

        cell?.superView = tableView
        cell?.configureCell(post)

        return cell!
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.syncGetAllPosts().count
    }

    override init() {
        super.init()
    }
}
