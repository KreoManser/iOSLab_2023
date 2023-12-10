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
    var user: User?
    override func viewDidLoad() {
        super.viewDidLoad()

        profileView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileView.reloadData()
    }

    private var dataSource: PublicationsDataSource?

    override func loadView() {
        view = profileView
        profileView.delegate = self
        dataSource = PublicationsDataSource()
        if let source = dataSource {
            profileView.setupDataSource(dataSource: source)
            user = dataSource?.dataManager.authUser
        }
        setupNavigation()
    }

    func setupNavigation() {
        let action: UIAction = UIAction { _ in

        }
        let button = UIBarButtonItem(title: user?.login, image: nil, primaryAction: action)
        button.tintColor = .black
        button.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 22)], for: .normal)
        self.navigationItem.leftBarButtonItem = button
        let buttonAdd = UIBarButtonItem(image: UIImage(systemName: "plus.app"), primaryAction: nil)

        let menuItem1 = UIAction(title: "Настройки") {_ in
            self.navigationController?.pushViewController(SettingsViewController(), animated: false)
        }

        let menu = UIMenu(children: [menuItem1])
        let buttonButer = UIBarButtonItem(image: UIImage(systemName: "text.justifyright"), menu: menu)
        self.navigationItem.rightBarButtonItems = [buttonButer, buttonAdd]
    }
}
extension ProfileViewController: ClickCellDelegate {
    func clickCell(indexPath: IndexPath) {
        let publicationViewController = ProfileTimelineViewController(indexPath: indexPath, user: user ?? User())
        navigationController?.pushViewController(publicationViewController, animated: false)
    }
}
