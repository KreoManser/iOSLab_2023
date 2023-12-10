//
//  FriendsTableViewCell.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 10.12.2023.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {
    lazy var friendsUsername: UILabel = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpFriendsUsername()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpFriendsUsername() {
        addSubview(friendsUsername)
        friendsUsername.translatesAutoresizingMaskIntoConstraints = false
        friendsUsername.textColor = .black
        friendsUsername.font = UIFont.systemFont(ofSize: 15)
        NSLayoutConstraint.activate([
            friendsUsername.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ])
    }
   func configureCell(with username: Friend) {
        friendsUsername.text = username.user?.username
    }

}

extension UITableViewCell {
    static var reuseIdentifierforTableView: String {
        return String(describing: self)
    }
}
