//
//  PublicationsViewController.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 30.10.2023.
//

import UIKit

class PublicationsViewController: UIViewController {

    var publicationView: PublicationsView?
    var publicationsManager: PublicationsDataManager?
    var profileDataManager = ProfileDataManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        publicationsManager = PublicationsDataManager()
        setUpNavBar()
        setUpView()
        self.publicationsManager?.reloadtableView = { [weak self] in
            DispatchQueue.main.async {
                self?.publicationView?.tableView.reloadData()
            }
        }

        publicationsManager?.showdeleteOptionTapped = { [weak self] alertController in
            self?.present(alertController, animated: true)
        }

        publicationView?.searchBar.becomeFirstResponder()
    }
    private func setUpNavBar() {
        navigationItem.title = "POSTS"
        navigationItem.largeTitleDisplayMode = .always
    }
    private func  setUpView() {
        publicationView = PublicationsView(frame: view.bounds)
        publicationView?.tableView.delegate = publicationsManager
        publicationView?.tableView.dataSource = publicationsManager
        publicationView?.tableView.register(PublicationsTableViewCell.self, forCellReuseIdentifier: PublicationsTableViewCell.reuseIdentifier)
        publicationView?.searchBar.delegate = publicationsManager
        view = publicationView
    }
}
