//
//  PostsView.swift
//  New106
//
//  Created by Alina on 01.11.2023.
//

import UIKit

 class PostsView: UIView {

     lazy var tableView: UITableView = UITableView()
     private var indexPath: IndexPath

     required init(frame: CGRect, indexPath: IndexPath) {
         self.indexPath = indexPath
         super.init(frame: frame)
         backgroundColor = .white
         setUpTableView()
     }

     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

     

     private func setUpTableView() {
         addSubview(tableView)
         tableView.translatesAutoresizingMaskIntoConstraints = false

         NSLayoutConstraint.activate([
             tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
             tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
             tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
             tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
         ])
     }

 }
