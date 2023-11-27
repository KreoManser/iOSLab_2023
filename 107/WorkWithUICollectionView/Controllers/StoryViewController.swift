//
//  StoryViewController.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 04.11.2023.
//

import UIKit

class StoryViewController: UIViewController, UpdateDataDelegate, UpdateDataEverythingControllers, PublicationCellDelegate {
    func postDeleted(at indexPath: IndexPath?) {
    }

    lazy var storyView = StoryView(frame: .zero)
    var currentCat: User?
    override func loadView() {
        super.loadView()
        view = storyView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        storyView.setupNavigationBar()
        storyView.controler = self
        RegistrationDataManager.shared.delegate = self
        updateData()
    }
    func updateData() {
        Task {
            let publications = await PublicationDataManager.shared.asyncGetEverythingPublication()
            storyView.publication = publications
            storyView.tableStoryPosts.reloadData()
        }
    }
}
