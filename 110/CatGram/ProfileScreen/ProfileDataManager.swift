//
//  ProfileDataManager.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 29.10.2023.
//

import Foundation
import UIKit

class ProfileDataManager: NSObject, DataManaging, UICollectionViewDataSource {

        static let shared = ProfileDataManager()
        var coreDataManager = CoreDataManager.shared
        var postsForProfile: [Posts] = []

    // MARK: - Respective/Custom queues for all methods
    private let saveQueue = OperationQueue()
    private let deleteQueue = OperationQueue()
    private let searchQueue = OperationQueue()
    private let retrievePostQueue = OperationQueue()

    // MARK: - Closure to notify the viewcontroller that image was tapped.
    var didTapImage: ((_ indexPath: IndexPath) -> Void)?
    var reloadcollectionData: (() -> Void)?
    var userDefaults = UserDefaults.standard
    override init() {
        super.init()
        if postsForProfile.isEmpty {
            toCreatePosts()
            print(self.postsForProfile)
        } else {
            print("array for posts is empty")
        }
    }

    // MARK: - Creating new posts
    func createPost(id: UUID, caption: String, photo: UIImage?, date: String, isFav: Bool) {
        let context = coreDataManager.viewContext
        context.perform {
            let newPost = Posts(context: context)
            newPost.id = id
            newPost.caption = caption
            newPost.photo = photo?.pngData()
            newPost.date = date
            newPost.isFav = isFav

            self.postsForProfile.append(newPost)
            self.reloadcollectionData?()
            print(self.postsForProfile)
            do {
                try context.save()
            } catch {
                print("error while trying to save the new post \(error)")
            }
        }

    }

    // MARK: - Updating the post by caption.
    func updatePost(post: Posts, newCaption: String) {
        let context = coreDataManager.viewContext
        context.perform {
            post.caption = newCaption
            do {
                try context.save()
            } catch {
                print("error while trying to update post caption \(error)")
            }
        }
    }

    // MARK: - Deleting posts
    func deletePost(post: Posts) {
        let context = coreDataManager.viewContext
        context.perform {
            context.delete(post)
            do {
                try context.save()
                DispatchQueue.main.async {
                   self.postsForProfile.removeAll { $0.id == post.id }
                    self.reloadcollectionData?()
             }
            } catch {
                print(error)
            }
        }

    }

    // MARK: - Reading/Fetching posts

    func fetchPosts() -> [Posts] {
            let context = coreDataManager.viewContext
            var fetchedPosts: [Posts] = []

            context.performAndWait {
                let fetchRequest = Posts.fetchRequest()

                do {
                    fetchedPosts = try context.fetch(fetchRequest)
                } catch {
                    print("Error occurred while fetching posts \(error)")
                }
            }

            return fetchedPosts
        }

    func toCreatePosts() {
     createPost(id: UUID(), caption: "Are you kitten me?",
                   photo: UIImage(named: "whitecat.jpeg"), date: "20th May 2018", isFav: false)
     createPost(id: UUID(), caption: "Putting the fur in furniture",
                   photo: UIImage(named: "greycat.jpeg"), date: "14th Oct 2021", isFav: false)
     createPost(id: UUID(), caption: "Black cats are not evil",
                   photo: UIImage(named: "blackcat.jpeg"), date: "26th Dec 2023", isFav: false)
    }

    func savePost(_ post: Posts) {
        let context = coreDataManager.viewContext
        do {
            try context.save()
            postsForProfile.append(post)
        } catch {
            print("Problem encountered while trying to save \(error)")
        }
    }

    func retrievePost() -> [Posts] {
        return postsForProfile
    }

    func searchPostByCaption(byCaption caption: String) -> [Posts] {
        let filteredPosts = self.postsForProfile.filter { $0.caption == caption }
        return filteredPosts
    }

    func deletePost(_ post: Posts) {
        if let index = postsForProfile.firstIndex(where: { $0.id == post.id}) {
            postsForProfile.remove(at: index)
        }
    }
    func asyncSavePost(_ post: Posts, completion: @escaping (Bool) -> Void) {
        saveQueue.addOperation {
            self.postsForProfile.append(post)
            completion(true)
        }
    }
    func asyncSearchPostsByCaption(byCaption caption: String, completion: @escaping (Posts?) -> Void) {
        searchQueue.addOperation {
            if let filteredPosts = self.postsForProfile.first( where: { $0.caption == caption }) {
                print("post found!")
                completion(filteredPosts)
            } else {
                print("post not found!")
                completion(nil)
            }
        }
    }

    func asyncDeletePost(_ post: Posts, completion: @escaping (Bool) -> Void) {
        self.deleteQueue.addOperation {
            let context = self.coreDataManager.viewContext
            context.perform {
                context.delete(post)
                print("post deleted")
                do {
                    try context.save()
                    DispatchQueue.main.async {
                        print("Before removing: \(self.postsForProfile)")
                        self.postsForProfile.removeAll { $0.id == post.id }
                        print("After removing: \(self.postsForProfile)")
                        self.reloadcollectionData?()
                 }
                    completion(true)
                } catch {
                    print("error while trying to delete post \(error)")
                    completion(false)
                }
            }

        }
    }

    func asyncRetrievePost(completion: @escaping ([Posts]) -> Void) {
        self.retrievePostQueue.addOperation {
            print("posts retrieved!")
            let context = self.coreDataManager.viewContext
            let fetchRequest = Posts.fetchRequest()
            context.perform {
                do {
                    let posts = try context.fetch(fetchRequest)
                    print("posts retrieved!")
                    completion(posts)
                } catch {
                    print("Error occurred while fetching posts \(error)")
                    completion([])
                }
            }
        }
    }
}

extension ProfileDataManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postsForProfile.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProfileCollectionViewCell.reuseidentifier,
            for: indexPath) as? ProfileCollectionViewCell else {
            return UICollectionViewCell()}
        let posts = postsForProfile
        let post = posts[indexPath.row]
        cell.configure(with: post)
        cell.contentMode = .scaleAspectFill
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didTapImage?(indexPath)
    }
}

extension ProfileDataManager: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 3
        let height = width
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView,

                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
