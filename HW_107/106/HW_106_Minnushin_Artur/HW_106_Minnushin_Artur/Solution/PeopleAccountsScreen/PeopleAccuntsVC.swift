//
//  PeopleAccuntsViewController.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 21.12.2023.
//

import UIKit
import CoreData

class PeopleAccuntsViewController: UIViewController {
    let peopleAccountView = PeopleAccountsView(frame: .zero)
    let coreDataManager = CoreDataManager.shared
    var peopleAccountDataSource: PeopleAccountsTableViewDataSource!
    var newsLineVC: NewsLineViewController!
    var fetchResoultController: NSFetchedResultsController<User>!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchResoultController = coreDataManager.createPreparedFetchedUserResultController()
        peopleAccountDataSource = PeopleAccountsTableViewDataSource(controller: fetchResoultController)
        peopleAccountView.setupFecthController(controller: fetchResoultController)
        peopleAccountView.peopleAccountVC = self
        peopleAccountView.setupDataSource(dataSource: peopleAccountDataSource)
    }
    override func viewDidAppear(_ animated: Bool) {
        peopleAccountView.updateTableWithCachedData()
    }
    override func loadView() {
        view = peopleAccountView
    }
    func updateFriend(userId: Int) {
        coreDataManager.updateFriends(userID: userId)
    }
}
