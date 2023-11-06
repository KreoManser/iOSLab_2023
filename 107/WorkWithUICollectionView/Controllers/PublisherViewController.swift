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
class PublisherViewController: UIViewController, PublisherCellDelegate, UpdateDataDelegate {
    weak var delegate1: UpdateDataDelegate?
    func updateData() {
//        DataManager.asyncGetPublisher { publishers in
//            self.delegate1?.updateData()
//            self.publishersView.publishers = publishers
//        }
        guard let newCat = DataManager.currentCat else{return}
        publishersView.publishers = newCat.publishers
        
    }
    weak var delegate: MainUpdateWithOperationDelegate?
    lazy var publishersView = PublishersView(frame: .zero)
    var managerData = DataManager.shared
    var selectedIndexPath: IndexPath?
    override func loadView() {
        super.loadView()
        view = publishersView
    }
    func postDeleted(at indexPath: IndexPath?) {
        if let newIndexPath = indexPath {
            OperationQueue.main.addOperation {
                self.publishersView.tablePublisher.beginUpdates()
                self.publishersView.tablePublisher.deleteRows(at: [newIndexPath], with: .fade)
                self.publishersView.tablePublisher.endUpdates()
                self.delegate?.updateTable()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        publishersView.controller = self
        managerData.delegate = self
        updateData()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let indexPath = selectedIndexPath {
            publishersView.tablePublisher.scrollToRow(at: indexPath, at: .top, animated: true)
            selectedIndexPath = nil
        }
    }
}
