//
//  PublicationViewController.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 02.11.2023.
//

import UIKit

class PublicationViewController: UIViewController {
    var indexPath: IndexPath?
    let publicationView = PublicationView(frame: .zero)
    let publicatiomDataSource = PublicationDataSource()
    var user: User?
    var delegate: GetData?
    override func viewDidLoad() {
        super.viewDidLoad()
        publicationView.setupDataSource(dataSource: publicatiomDataSource)
        publicationView.publicationViewController = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        publicationView.scrollToSellectedCell(indexPath: self.indexPath!)
    }
    override func loadView() {
        view = publicationView
    }
    init (indexPath: IndexPath) {
        super.init(nibName: "", bundle: nil)
        self.indexPath = indexPath
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func dismisPublicationVC() {
        dismiss(animated: true, completion: nil)
    }
    func deletePost(indexPath: IndexPath) {
        DataManager.sigelton.syncDelete(indexPath: indexPath.row + 1)
        publicationView.reloadData()
    }
    func searchPostsByName(name: String) {
        DataManager.sigelton.asyncSearchByName(postName: name)
    }
}
