//
//  TableViewDataSource.swift
//  Homework6
//
//  Created by kerik on 30.10.2023.
//

import Foundation
import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostsTableViewCell.reuseIdentifier, for: indexPath) as? PostsTableViewCell
        let post = DataManager.shared.syncGetAllPosts()[indexPath.row]

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
