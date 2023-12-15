//
//  PostsViewController.swift
//  New106
//
//  Created by Alina on 01.11.2023.
//

import UIKit

 class PostsViewController: UIViewController {

     private var postView: PostsView?
     private var postDataManager: PostsDataManager?
     private var indexPath: IndexPath

     init(indexPath: IndexPath) {
         self.indexPath = indexPath
         super.init(nibName: nil, bundle: nil)
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

     override func viewDidLoad() {
         super.viewDidLoad()

         postDataManager = PostsDataManager()
         setupPostView()
         postDataManager?.deleteTapped = { [weak self] alertController in
             self?.present(alertController, animated: true, completion: nil)
         }
         postDataManager?.reloadData = { [weak self] in
             self?.postView?.tableView.reloadData()
         }
         DispatchQueue.main.async {
             self.postView?.tableView.scrollToRow(at: self.indexPath, at: .top, animated: false)
         }
     }

     private func setupPostView() {
         postView = PostsView(frame: view.bounds, indexPath: indexPath)
         view = postView
         postView?.tableView.delegate = postDataManager
         postView?.tableView.dataSource = postDataManager
         postView?.tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)
         postView?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
     }
 }
