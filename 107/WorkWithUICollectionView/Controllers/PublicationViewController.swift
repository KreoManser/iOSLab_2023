//
//  PublisherViewController.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 30.10.2023.
//

import UIKit
protocol UpdateDataDelegate: AnyObject {
    func updateData()
}
class PublicationViewController: UIViewController, PublicationCellDelegate, UpdateDataDelegate, UpdateDataEverythingControllers {
    var currentCat: User?
    weak var delegate: UpdateDataDelegate?
    func updateData() {
        Task {
            let cat = await RegistrationDataManager.shared.getCurrentUser()
            currentCat = cat
            publicationView.cat = cat
            guard let newPublication = cat?.publications else {return}
            publicationView.publications = newPublication
            publicationView.cat = cat
            publicationView.tablePublication.reloadData()
        }
    }
    lazy var publicationView = PublicationsView(frame: .zero)

    var selectedIndexPath: IndexPath?

    override func loadView() {
        super.loadView()
        view = publicationView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        publicationView.controller = self
        RegistrationDataManager.shared.delegate2 = self
        updateData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let indexPath = selectedIndexPath {
            publicationView.tablePublication.scrollToRow(at: indexPath, at: .top, animated: true)
            selectedIndexPath = nil
        }
    }
}
