//
//  ViewController.swift
//  106Tukaev
//
//  Created by surexnx on 29.10.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    private lazy var profileView: ProfileView = {
        return ProfileView(frame: .zero)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let source = dataSource {
            profileView.setupDataSource(dataSource: source)
        }
        profileView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileView.reloadData()
    }

    private var dataSource: PublicationsDataSource?

    override func loadView() {
        view = profileView
        profileView.controller = self
        dataSource = PublicationsDataSource()
        setupNavigation()
    }

    func setupNavigation() {
        let action: UIAction = UIAction { _ in

        }
        let user = dataSource?.getUser()
        let button = UIBarButtonItem(title: user?.userLogin, image: nil, primaryAction: action)
        button.tintColor = .black
        button.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 22)], for: .normal)
        self.navigationItem.leftBarButtonItem = button
        let buttonAdd = UIBarButtonItem(image: UIImage(systemName: "plus.app"), primaryAction: nil)
        let buttonButer = UIBarButtonItem(image: UIImage(systemName: "text.justifyright"), primaryAction: nil)
        self.navigationItem.rightBarButtonItems = [buttonButer, buttonAdd]
    }

    func cliclCell(indexPath: IndexPath) {
        let publicationViewController = ProfileTimelineViewController(indexPath: indexPath)
        navigationController?.pushViewController(publicationViewController, animated: false)
    }
}

