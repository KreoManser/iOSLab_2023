//
//  FrendsViewController.swift
//  HW106
//
//  Created by Ильмир Шарафутдинов on 08.02.2024.
//

import UIKit

class FrendsViewController: UIViewController {
    
    let dataManager = StorageManager.shared
    var users = StorageManager.shared.obtainSavedData()
    var isFromProfile = false
    
    @IBOutlet weak var friendsLabel: UILabel!
    @IBOutlet weak var frendsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frendsTableView.delegate = self
        frendsTableView.dataSource = self
        if isFromProfile {
            friendsLabel.text = "Подписки"
        }
    }
    
    func configureUsersList(with users: [UserRegistration]) {
        self.users = users
        isFromProfile = true
    }
}

extension FrendsViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFromProfile {
            return users.count
        } else {
            return users.count - 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = frendsTableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        let user = users[indexPath.row]
        cell.configureCell(user: user)
        
        return cell
    }
    
    
}
