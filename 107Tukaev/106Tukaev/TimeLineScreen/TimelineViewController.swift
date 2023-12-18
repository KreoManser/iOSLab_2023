//
//  TimelineViewController.swift
//  107Tukaev
//
//  Created by surexnx on 05.11.2023.
//

import UIKit
import CoreData

class TimelineViewController: UIViewController {

    private lazy var customView: TimelineView = {
        return TimelineView()
    }()

    private var dataSource: TimelineDataSource?
    var fetchedResultController = CoreDataManager.shared.createFetchedSubPublication()

    override func loadView() {
        view = customView
        customView.controller = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = TimelineDataSource()
        if let dataSource = dataSource {
            customView.setupDataSource(dataSource: dataSource)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
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
