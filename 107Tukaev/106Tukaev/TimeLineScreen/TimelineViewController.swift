//
//  TimelineViewController.swift
//  107Tukaev
//
//  Created by surexnx on 05.11.2023.
//

import UIKit

class TimelineViewController: UIViewController {

    private lazy var customView: TimelineView = {
        return TimelineView()
    }()

    private var dataSource: TimelineDataSource?

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
        customView.reloadData()

    }

}
