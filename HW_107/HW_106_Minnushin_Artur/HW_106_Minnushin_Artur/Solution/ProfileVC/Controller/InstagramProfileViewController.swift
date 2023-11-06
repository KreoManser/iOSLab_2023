//
//  ViewController.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 29.10.2023.
//

import UIKit

class InstagramProfileViewController: UIViewController {
    let dataSource = ProfileCollectionDataSource()
    let profileView = InstargramProfileView(frame: .zero)
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.configureCollection(dataSource: dataSource)
        profileView.profileViewController = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileView.reloadData()
    }
    override func loadView() {
        view = profileView
    }
    
    func publicationPresintation(indexPath: IndexPath) {
        let publicationVC = PublicationViewController(indexPath: indexPath)
        publicationVC.modalPresentationStyle = .overFullScreen
        present(publicationVC, animated: true)
    }
}
