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
        dataSource = PublicationsDataSource()
        profileView.setupDataSource(dataSource: dataSource!)
        profileView.collectionView.reloadData()
        setupNavigation()
    }

    private var dataSource: PublicationsDataSource?

    override func loadView() {
        view = profileView
        profileView.controller = self
    }

    func setupNavigation() {
        let action: UIAction = UIAction { _ in

        }
        let button = UIBarButtonItem(title: "Surexnx", image: nil, primaryAction: action)
        button.tintColor = .black
        button.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 22)], for: .normal)
        navigationItem.leftBarButtonItem = button
        let buttonAdd = UIBarButtonItem(image: UIImage(systemName: "plus.app"), primaryAction: nil)
        let buttonButer = UIBarButtonItem(image: UIImage(systemName: "text.justifyright"), primaryAction: nil)
        navigationItem.rightBarButtonItems = [buttonButer, buttonAdd]
    }

    func cliclCell(indexPath: IndexPath) {
        let publicationViewController = PublicationsViewController(indexPath: indexPath)
        navigationController?.pushViewController(publicationViewController, animated: false)
    }
}

