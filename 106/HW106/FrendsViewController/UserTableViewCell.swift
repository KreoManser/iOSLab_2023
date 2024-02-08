//
//  UserTableViewCell.swift
//  HW106
//
//  Created by Ильмир Шарафутдинов on 08.02.2024.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    var followingUser: UserRegistration?
    let dataManager = StorageManager.shared
    let currentUserLogin = UserDefaults.standard.string(forKey: "currentUser")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(user: UserRegistration) {
        self.followingUser = user
        if user.name != currentUserLogin {
            userNameLabel.text = user.name
            userImageView.image = UIImage(named: "котик")
        }
        
        if let user = getCurrentUser(),
            let followingUser = followingUser,
            user.follows.contains(followingUser) {
            toggleFollowButton()
        }
    }
    
    func toggleFollowButton() {
        followButton.isSelected.toggle()
        followButton.backgroundColor = followButton.isSelected ? .lightGray : .link
        followButton.tintColor = followButton.isSelected ? .black : .white
    }
    
    func getCurrentUser() -> UserRegistration? {
        let users = dataManager.obtainSavedData()
        for user in users {
            if user.name == currentUserLogin {
                return user
            }
        }
        return nil
    }
    
    @IBAction func followButtonAction(_ sender: Any) {
        toggleFollowButton()
        followButton.isSelected ? follow() : unfollow()
    }
    
    func unfollow() {
        let user = getCurrentUser()
        if let followingUser = followingUser, let user = user {
            user.removeFromFollows(followingUser)
            dataManager.saveContext()
        }
    }
    
    func follow() {
        let user = getCurrentUser()
        if let followingUser = followingUser, let user = user {
            user.addToFollows(followingUser)
            dataManager.saveContext()
        }
    }
}
