//
//  PublicationsViewController.swift
//  106Tukaev
//
//  Created by surexnx on 01.11.2023.
//

import UIKit

class ProfileTimelineViewController: UIViewController {

    private lazy var customView: ProfileTimelineView = {
        return ProfileTimelineView(frame: .zero)
    }()
    private var indexPath: IndexPath
    private var dataSource: ProfileTimelineDataSource?

    override func loadView() {
        view = customView
    }
    init(indexPath: IndexPath) {
        self.indexPath = indexPath
        super.init(nibName: nil, bundle: nil)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        customView.scroll(indexPath)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = ProfileTimelineDataSource()
        if let source = dataSource {
            customView.setupDataSource(source)
        }
        customView.controller = self

    }
}
extension ProfileTimelineViewController {
    func present(_ viewControllerToPresent: UIViewController) {
        present(viewControllerToPresent, animated: false)
    }

    func acyncDelete(id: Int) {
        dataSource?.dataManager.syncDelete(id: id)
    }
}

