//
//  PublicationsDataManager.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 31.10.2023.
//

import Foundation
import UIKit

class PublicationsDataManager: NSObject, UITableViewDataSource,
    UITableViewDelegate, PublicationsCellDelegate,
    UISearchBarDelegate {
    static let shared = PublicationsDataManager()

    private var profileDatamanager = ProfileDataManager.shared
    var publicationDatamanager = ProfileDataManager.shared
    private var  postCopy: [Post] = []
    private var filteredPostsArray: [Publications] = []
    private var publications: [Publications] = []
    var reloadtableView: (() -> Void)?
    var showdeleteOptionTapped: ((_ alertController: UIAlertController ) -> Void)?
    var searchPost: (([Publications]) -> Void)?
    var userDefaults = UserDefaults.standard

    var likedPost: [Publications] = [] {
        didSet {
            saveLikedPosts(likedPost)
        }
    }

    override init() {
        super.init()
        if postCopy.isEmpty {
            getPosts()
            likedPost = loadLikedPosts()
            print(postCopy)
        } else {
            print("unable to call function")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var total: Int
        if filteredPostsArray.isEmpty {
            total = publications.count
        } else {
            total = filteredPostsArray.count
        }
        print(total)
        return total
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PublicationsTableViewCell.reuseIdentifier,
            for: indexPath) as? PublicationsTableViewCell else {
            return UITableViewCell() }
        var post: Publications
        if filteredPostsArray.isEmpty {
            post = publications[indexPath.row]
        } else {
            post = filteredPostsArray[indexPath.row]
        }
        cell.tag = indexPath.row
        cell.configureCell(with: post)
        cell.delegate = self
        return cell
    }

    func getPosts() {
        publicationDatamanager.asyncRetrievePost { [weak self] postCopy in
            print("received \(postCopy)")

            DispatchQueue.main.async {
                for post in postCopy {
                    self?.publications.append(Publications(id: post.id,
                    caption: post.caption, photo: post.photo, date: post.date, isFav: post.isFav))
                }
                self?.reloadtableView?()
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    func didTapOptionDisclosure(at index: Int) {
        let alertController = UIAlertController(title: "Delete Post",
            message: "Are you sure you want to delete this post?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {_ in
            self.deletePublication(at: index)})
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        showdeleteOptionTapped?(alertController)
    }
    func deletePublication(at index: Int) {
        let postToDelete = publications[index]
        self.profileDatamanager.asyncDeletePost(Post(id: postToDelete.id,
                                                     caption: postToDelete.caption,
                                                     photo: postToDelete.photo,
                                                     date: postToDelete.date,
            isFav: postToDelete.isFav)) { [weak self] success in
            if success {
                print("Deletion process successful")
            } else {
                print("Process unsuccesful")
            }
            if let indexPoint = self?.publications.firstIndex(where: { $0 == postToDelete }) {
                self?.publications.remove(at: indexPoint)
            }
            self?.reloadtableView!()
            self!.profileDatamanager.reloadcollectionData!()
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.profileDatamanager.asyncSearchPostsByCaption(byCaption: searchText) { [weak self] success in
            print("method called")
            if success == nil {
                print("Unable to find post. It might be deleted.")
                self?.filteredPostsArray = []
            } else {
                print("post found")
                if let filteredPosts = self?.publications.first( where: { $0.caption == searchText }) {
                    self?.filteredPostsArray.append(Publications(id: filteredPosts.id,
                                                                 caption: filteredPosts.caption,
                                                                 photo: filteredPosts.photo,
                                                                 date: filteredPosts.date,
                                                                 isFav: filteredPosts.isFav))
                    print(self?.filteredPostsArray as Any)
                    self?.reloadtableView?()
                }
            }
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.reloadtableView?()
    }

    private func saveLikedPosts(_ posts: [Publications]) {
        do {
            let encoder = JSONEncoder()
            let encondedData = try encoder.encode(posts)
            userDefaults.setValue(encondedData, forKey: Keys.likedPosts)
            reloadtableView?()
        } catch {
            print("saving error")
        }
    }

    func loadLikedPosts() -> [Publications] {
        guard let userdata = userDefaults.data(forKey: Keys.likedPosts) else {
            print("userdata is empty")
            return [] }

        do {
            let decoder = JSONDecoder()
            let likedpost = try decoder.decode([Publications].self, from: userdata)
            print("likedpost retrieved")
            return likedpost
        } catch {
            print("error loading")
        }
        return []
    }

    func handleDoubleTap(for post: Publications) {
        if isPostLiked(post: post) {
            removePostFromLikedPosts(post: post)
        } else {
            print("post not unliked")
        }
    }
    func removePostFromLikedPosts(post: Publications) {
        likedPost.removeAll { $0.caption == post.caption }
    }

    private func isPostLiked(post: Publications) -> Bool {
        return likedPost.contains { $0.caption == post.caption }
    }

    }
