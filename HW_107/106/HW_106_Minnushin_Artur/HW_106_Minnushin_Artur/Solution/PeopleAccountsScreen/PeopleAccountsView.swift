//
//  PeopleAccountView.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 21.12.2023.
//

import UIKit
import CoreData

class PeopleAccountsView: UIView {
    let coreDataManager = CoreDataManager.shared
    var peopleAccountVC: PeopleAccuntsViewController!
    var fetchedResultController: NSFetchedResultsController<User>!
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 23)
        label.text = coreDataManager.authorizationUser?.userName
        return label
    }()
    lazy var searchLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Аккаунты"
        return label
    }()
    lazy var underLineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        return label
    }()
    lazy var peopleAccountsTableView = {
        let tableView = UITableView()
        tableView.register(PeopleAccountsTableViewCell.self, forCellReuseIdentifier: "peopleAccountCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(nameLabel)
        addSubview(searchLabel)
        addSubview(underLineLabel)
        addSubview(peopleAccountsTableView)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func updateTableWithCachedData() {
        do {
            try fetchedResultController.performFetch()
            peopleAccountsTableView.reloadData()
        } catch {
            print("Fetch request failed with error: \(error)")
        }
    }
    func setupFecthController(controller: NSFetchedResultsController<User>) {
        fetchedResultController = controller
        fetchedResultController.delegate = self
    }
    func setupLayout() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 65),
            nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            searchLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            searchLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            underLineLabel.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: 10),
            underLineLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            underLineLabel.heightAnchor.constraint(equalToConstant: 1),
            underLineLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            underLineLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            peopleAccountsTableView.topAnchor.constraint(equalTo: underLineLabel.bottomAnchor, constant: 10),
            peopleAccountsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            peopleAccountsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            peopleAccountsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    func setupDataSource(dataSource: PeopleAccountsTableViewDataSource) {
        peopleAccountsTableView.dataSource = dataSource
    }
}
extension PeopleAccountsView: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            peopleAccountsTableView.deleteRows(at: [indexPath!], with: .automatic)
        case .update:
            peopleAccountsTableView.reloadRows(at: [indexPath!], with: .automatic)
        default:
            break
        }
    }
}
extension PeopleAccountsView: PeopleAccountsProtocols {
    func updateFriends(userId: Int) {
        peopleAccountVC.updateFriend(userId: userId)
    }
}
