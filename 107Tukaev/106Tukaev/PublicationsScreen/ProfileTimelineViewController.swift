//
//  PublicationsViewController.swift
//  106Tukaev
//
//  Created by surexnx on 01.11.2023.
//

import UIKit
import CoreData

class ProfileTimelineViewController: UIViewController {

    private lazy var customView: ProfileTimelineView = {
        return ProfileTimelineView(frame: .zero)
    }()
    private var indexPath: IndexPath
    private var user: User
    private var dataSource: ProfileTimelineDataSource?
    var fetchedResultController: NSFetchedResultsController<Publication>

    override func loadView() {
        view = customView
    }
    init(indexPath: IndexPath, user: User) {
        self.indexPath = indexPath
        self.user = user
        fetchedResultController = CoreDataManager.shared.createFetchedUserPubl(user: user)
        super.init(nibName: nil, bundle: nil)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = ProfileTimelineDataSource(user: user)
        if let source = dataSource {
            customView.setupDataSource(source)
        }
        customView.controller = self
        customView.scroll(indexPath)
        DispatchQueue.main.async {
            self.customView.scroll(self.indexPath)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateTableWithCachedData()
    }

    func updateTableWithCachedData() {
        do {
            try fetchedResultController.performFetch()
            customView.reloadData()
        } catch {
            print("Fetch request failed with error: \(error)")
        }
    }

}
extension ProfileTimelineViewController {

    func present(_ viewControllerToPresent: UIViewController) {
        present(viewControllerToPresent, animated: false)
    }

    func acyncDelete(id: UUID) {

        do {
            try dataSource?.dataManager.deletePubl(id)
            customView.reloadData()
        } catch {
            print("error\(error)")
        }

    }
}

