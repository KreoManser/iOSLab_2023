//
//  ProfileViewController.swift
//  New106
//
//  Created by Alina on 01.11.2023.
//

import UIKit

 class PublicationViewController: UIViewController {

     private var publicationView: PublicationView?
     private var publicationDataManager: PublicationDataManager?

     override func viewDidLoad() {
         super.viewDidLoad()

         publicationDataManager = PublicationDataManager.shared
         setupShopView()
         publicationDataManager?.postTapped = { [weak self] indexPath in
             let postViewController = PostsViewController(indexPath: indexPath)
             self?.navigationController?.pushViewController(postViewController, animated: true)
         }

     }

     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         publicationView?.collectionView.reloadData()
     }

     private func setupShopView() {
         publicationView = PublicationView(frame: view.bounds)
         publicationView?.collectionView.delegate = publicationDataManager
         publicationView?.collectionView.dataSource = publicationDataManager
         publicationView?.collectionView.register(PublicationCollectionViewCell.self, forCellWithReuseIdentifier: PublicationCollectionViewCell.reuseIdentifier)
         view = publicationView
     }
 }
