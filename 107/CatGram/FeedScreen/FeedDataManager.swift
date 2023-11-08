//
//  FeedDataManager.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 05.11.2023.
//

import Foundation
import UIKit

class FeedDataManager: NSObject, UITableViewDelegate, UITableViewDataSource {

    static let shared = FeedDataManager(currentUser: nil)
    var loginDataManager = UserDataManager.shared
    var users: [User] = []
    var currentUser: User?

    // swiftlint:disable all
    var feedPosts: [Feed] = [
        Feed(id: UUID(), avatar: UIImage(named: "dp1"),
             userName: "User1", caption: "Predicted trends for2024",
             photo: UIImage(named: "croppedblazer"), date: "12th Dec 2021", catergory: "Fashion"),
        Feed(id: UUID(), avatar: UIImage(named: "dp2"), 
             userName: "Lovelycats__",caption: "They're so cutee!",
             photo: UIImage(named: "animal1"),date: "25th Dec 2023", catergory: "Animals"),
        Feed(id: UUID(), avatar: UIImage(named: "dp3"), 
             userName: "IloveNature_", caption: "Save the trees",
             photo: UIImage(named: "nature3"), date: "17th Nov 2023", catergory: "Nature"),
        Feed(id: UUID(), avatar: UIImage(named: "profile3"), 
             userName: "Animals001", caption: "<3",
             photo: UIImage(named: "blackcat"), date: "12th Oct 2022", catergory: "Animals"),
        Feed(id: UUID(), avatar: UIImage(named: "dp6"), userName: "Doosuur14", caption: "In stock: size(S/M)", photo: UIImage(named: "theblackdress"), date: "12th Dec 2021", catergory: "Fashion"),
        Feed(id: UUID(), avatar: UIImage(named: "dp1"), userName: "User1", caption: "Stunning? yes!", photo: UIImage(named: "nature1"), date: "17th Nov 2023", catergory: "Nature"),
        Feed(id: UUID(), avatar: UIImage(named: "dp2"), userName: "Lovelycats__", caption: "The wonders of God", photo: UIImage(named: "nature4"), date: "17th Nov 2023", catergory: "Nature"),
        Feed(id: UUID(), avatar: UIImage(named: "dp6"), userName: "natgeowild", caption: "The duck", photo: UIImage(named: "animal3"), date: "25th Dec 2023", catergory: "Animals"),
        Feed(id: UUID(), avatar: UIImage(named: "dp3"), userName: "catsworld", caption: "good doggy olie", photo: UIImage(named: "animal2"), date: "25th Dec 2023", catergory: "Animals"),
        Feed(id: UUID(), avatar: UIImage(named: "dp1"), userName: "casualstreestyle_", caption: "Black friday sale: $250", photo: UIImage(named: "denimfit"), date: "12th Dec 2022", catergory: "Fashion")
    ]

    func fetchUserFeed(for user: User) -> ([Feed]) {
        return feedPosts.filter {(feed: Feed) in user.interest.contains(feed.catergory) }
    }

    func getUserFeed(user: User) -> [Feed] {
        return feedPosts.filter { feed in
            return user.friends.contains(feed.userName)
        }
    }



    init(currentUser: User?) {
        super.init()
        self.currentUser = currentUser
    }
    func setCurrentUser(_ user: User?) {
            currentUser = user
        }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var feedCount: Int
//        var feedForUser: [Feed]
//        if currentUser?.interest == "Animals" {
//           feedForUser =  fetchUserFeed(for: currentUser!)
//            feedCount = feedForUser.count
//        } else if currentUser?.interest == "Fashion" {
//            feedForUser = fetchUserFeed(for: currentUser!)
//            feedCount = feedForUser.count
//        } else {
//            feedForUser = fetchUserFeed(for: currentUser!)
//            feedCount = feedForUser.count
//        }


        return getUserFeed(user: currentUser!).count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.reuseIdentifiers, for: indexPath)
                as? FeedTableViewCell
        else { return UITableViewCell() }
        var myFeed = getUserFeed(user: currentUser!)
//        if currentUser?.interest == "Animals" {
//            myFeed = fetchUserFeed(for: currentUser!)
//        } else if currentUser?.interest == "Fashion" {
//            myFeed = fetchUserFeed(for: currentUser!)
//        } else {
//            myFeed = fetchUserFeed(for: currentUser!)
//        }
        let feedPost = myFeed[indexPath.row]
        cell.configureCell(with: feedPost)
        return cell
    }

    // swiftlint:enable all
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}
