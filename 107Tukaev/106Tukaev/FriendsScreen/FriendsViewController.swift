//
//  FriendsViewController.swift
//  107Tukaev
//
//  Created by surexnx on 30.11.2023.
//

import UIKit

class FriendsViewController: UIViewController {

    private lazy var customViev: ProfileView = {
        return ProfileView(frame: .zero)
    }()
    private let userId: Int

    private var dataSource: FriendsDataSource?

    init(userId: Int) {
        dataSource = FriendsDataSource(userId: userId)
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = customViev
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customViev.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let source = dataSource {
            customViev.setupDataSource(dataSource: source)
        }
        customViev.delegate = self
        customViev.reloadData()
        setupNavigation()
    }

    func setupNavigation() {
        let action: UIAction = UIAction { _ in

        }
        let user = dataSource?.dataManagerUser.syncSearch(by: userId)
        let button = UIBarButtonItem(title: user?.userLogin, image: nil, primaryAction: action)
        button.tintColor = .black
        button.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 22)], for: .normal)
        self.navigationItem.leftBarButtonItem = button
        let buttonAdd = UIBarButtonItem(image: UIImage(systemName: "plus.app"), primaryAction: nil)

        let menuItem1 = UIAction(title: "Настройки") {_ in
        }

        let menu = UIMenu(children: [menuItem1])
        let buttonButer = UIBarButtonItem(image: UIImage(systemName: "text.justifyright"), menu: menu)
        self.navigationItem.rightBarButtonItems = [buttonButer, buttonAdd]
    }
}
extension FriendsViewController: ClickCellDelegate {
    func clickCell(indexPath: IndexPath) {
        let publicationViewController = ProfileTimelineViewController(indexPath: indexPath, userId: userId)
        navigationController?.pushViewController(publicationViewController, animated: false)
    }
}
