//
//  FeedDataManager.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 05.11.2023.
//

import Foundation
import UIKit

class FeedDataManager: NSObject, UITableViewDelegate, UITableViewDataSource {

    static var shared = FeedDataManager(currentUser: nil)
    var loginDataManager = UserDataManager.shared
    var users: [User] = []
    var currentUser: User?
    let userDefaults = UserDefaults.standard
    var reloadtableView: (() -> Void)?
    var likedPosts: [Feed] = [] {
        didSet {
            saveLikedPosts(likedPosts)
        }
    }

    var didTaplikeButton: (() -> Void)?

    // swiftlint:disable all
    var feedPosts: [Feed] = [
        Feed(id: UUID(), avatar: UIImage(named: "dp1"),
             userName: "User1", caption: "Predicted trends for2024",
             photo: UIImage(named: "croppedblazer"), date: "12th Dec 2021", category: "Fashion", isLiked: false),
        Feed(id: UUID(), avatar: UIImage(named: "dp2"),
             userName: "Lovelycats__",caption: "They're so cutee!",
             photo: UIImage(named: "animal1"),date: "25th Dec 2023", category: "Animals", isLiked: false),
        Feed(id: UUID(), avatar: UIImage(named: "dp3"),
             userName: "IloveNature_", caption: "Save the trees",
             photo: UIImage(named: "nature3"), date: "17th Nov 2023", category: "Nature", isLiked: false),
        Feed(id: UUID(), avatar: UIImage(named: "profile3"),
             userName: "Animals001", caption: "<3",
             photo: UIImage(named: "blackcat"), date: "12th Oct 2022", category: "Animals", isLiked: false),
        Feed(id: UUID(), avatar: UIImage(named: "dp6"), userName: "Doosuur14", caption: "In stock: size(S/M)", photo: UIImage(named: "theblackdress"), date: "12th Dec 2021", category: "Fashion", isLiked: false),
        Feed(id: UUID(), avatar: UIImage(named: "dp1"), userName: "User1", caption: "Stunning? yes!", photo: UIImage(named: "nature1"), date: "17th Nov 2023", category: "Nature", isLiked: false),
        Feed(id: UUID(), avatar: UIImage(named: "dp2"), userName: "Lovelycats__", caption: "The wonders of God", photo: UIImage(named: "nature4"), date: "17th Nov 2023", category: "Nature", isLiked: false),
        Feed(id: UUID(), avatar: UIImage(named: "dp6"), userName: "natgeowild", caption: "The duck", photo: UIImage(named: "animal3"), date: "25th Dec 2023", category: "Animals", isLiked: false),
        Feed(id: UUID(), avatar: UIImage(named: "dp3"), userName: "catsworld", caption: "good doggy olie", photo: UIImage(named: "animal2"), date: "25th Dec 2023", category: "Animals", isLiked: false),
        Feed(id: UUID(), avatar: UIImage(named: "dp1"), userName: "casualstreestyle_", caption: "Black friday sale: $250", photo: UIImage(named: "denimfit"), date: "12th Dec 2022", category: "Fashion", isLiked: false)
    ]

    func fetchUserFeed(for user: User) -> ([Feed]) {
        return feedPosts.filter {(feed: Feed) in user.interest.contains(feed.category) }
    }

    func getUserFeed(user: User) -> [Feed] {
        return feedPosts.filter { feed in
            return user.friends.contains(feed.userName)
        }
    }


    init(currentUser: User?) {
        super.init()
        self.currentUser = currentUser
        likedPosts = loadLikedPosts()
        print("Liked Posts on Initialization:", likedPosts)

    }
    func setCurrentUser(_ user: User?) {
        currentUser = user
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let currentUser = currentUser {
            return getUserFeed(user: currentUser).count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.reuseIdentifiers, for: indexPath)
                                as? FeedTableViewCell
        else { return UITableViewCell() }
        var myFeed = getUserFeed(user: currentUser!)
        let feedPost = myFeed[indexPath.row]
        cell.configureCell(with: feedPost )
        return cell
    }

    // swiftlint:enable all
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }

    //    func saveLikedPosts() {
    //        let likedPostsIds = likedPosts.map { $0.id.uuidString}
    //            userDefaults.set(likedPostsIds, forKey: "likedPosts")
    //        print("posts saved")
    //        }
    //    private func loadLikedPosts() {
    //        if let likedPostsIds = userDefaults.stringArray(forKey: "likedPosts") {
    //            likedPosts = feedPosts.filter { feed in
    //                return likedPostsIds.contains(feed.id.uuidString)
    //            }
    //        }
    //        print("post obtained")
    //    }

    private func saveLikedPosts(_ posts: [Feed]) {
        do {
            let encoder = JSONEncoder()
            let encondedData = try encoder.encode(posts)
            userDefaults.setValue(encondedData, forKey: Keys.likedPosts)
            reloadtableView?()
        } catch {
            print("saving error")
        }
    }

    func loadLikedPosts() -> [Feed] {
        guard let userdata = userDefaults.data(forKey: Keys.likedPosts) else {
            print("userdata is empty")
            return [] }

        do {
            let decoder = JSONDecoder()
            let likedpost = try decoder.decode([Feed].self, from: userdata)
            print("likedpost retrieved")
            return likedpost
        } catch {
            print("error loading")
        }
        return []
    }

    func handleDoubleTap(for post: Feed) {
        if isPostLiked(post: post) {
            removePostFromLikedPosts(post: post)
        } else {
           print("post not unliked")
        }
    }
    func removePostFromLikedPosts(post: Feed) {
        likedPosts.removeAll { $0.caption == post.caption }
    }
    private func isPostLiked(post: Feed) -> Bool {
        return likedPosts.contains { $0.caption == post.caption }
    }
}
