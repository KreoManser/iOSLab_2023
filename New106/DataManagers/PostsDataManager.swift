//
//  PostsDataManager.swift
//  New106
//
//  Created by Alina on 01.11.2023.
//

import UIKit


class PostsDataManager: NSObject, UITableViewDataSource, UITableViewDelegate, PostTableViewCellDelegate {

     var deleteTapped: ((_ alertController: UIAlertController) -> Void)?
     var reloadData: (() -> Void)?

     private var PublicationsModels: [Publication] = []
     private var postsArray: [Post] = []

     private let publicationDataManager = PublicationDataManager.shared

     override init() {
         super.init()
         if postsArray.isEmpty {
             getPosts(dataManager: publicationDataManager)
         }
     }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return PublicationsModels.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let post = PublicationsModels[indexPath.row]

         guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath) as? PostTableViewCell else { return UITableViewCell()}

         cell.deleteTapped = { [weak self] alertController in
             self?.deleteTapped!(alertController)
         }
         cell.isUserInteractionEnabled = false

         cell.configure(with: post)
         cell.delegate = self

         return cell
     }

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 500
     }

     private func getPosts(dataManager: PublicationDataManager) {
         dataManager.asyncGetAllPosts { result in
             switch result {
             case .success(let posts):
                 for post in posts {
                     self.PublicationsModels.append(Publication(id: post.id, postImage: post.image, caption: post.caption, date: post.date))
                 }
             case .failure(_):
                 print("Ошибка")
             }
         }
     }

    func didDeletePost(postModel publicationModel: Publication) {

        publicationDataManager.asyncDelete(Post(id: publicationModel.id, image: publicationModel.postImage, caption: publicationModel.caption, date: publicationModel.caption), completion: { result in
             switch result {
             case .success:
                 print("Пост удален")
             case .failure(_):
                 print("Ошибка")
             }
         })

         if let index = PublicationsModels.firstIndex(where: { $0 == publicationModel }) {
             PublicationsModels.remove(at: index)
         }
         reloadData!()

     }
 }
