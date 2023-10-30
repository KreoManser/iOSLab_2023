//
//  DetailPostViewDataSourse.swift
//  CatGram
//
//  Created by Mac on 2023-10-30.
//

import UIKit

class DetailPostViewDataSourse: NSObject, UITableViewDataSource {

    var users: [Post]

    init(_ data: [Post]) {
        self.users = data
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailPostTableViewCell.reuseIdentifier,
            for: indexPath) as? DetailPostTableViewCell
            else { return UITableViewCell() }
        let post = users[indexPath.row]
        cell.configureCell(with: post)
        cell.backgroundColor = .white
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
