//
//  PublicationsViewController.swift
//  106Tukaev
//
//  Created by surexnx on 01.11.2023.
//

import UIKit

class PublicationsViewController: UIViewController {

    private lazy var customView: PublicationsView = {
        return PublicationsView(frame: .zero)
    }()
    private var indexPath: IndexPath
    private var dataSource: TableCellDataSource?

    override func loadView() {
        view = customView
        customView.controller = self
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
        dataSource = TableCellDataSource()
        customView.setupDataSource(dataSource!)
        customView.reloadData()
    }

    func acyncDelete(id: UUID) {
        dataSource?.dataManager.asyncDeletePublication(id: id)
    }
}
