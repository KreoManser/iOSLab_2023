//
//  DataManager.swift
//  catInstgram
//
//  Created by marwa awwad mohamed awwad on 22/12/2023.
//

import Foundation

protocol DataManagerProtocol {

    func syncSetCurrentUser(_ user: User)
    func asyncSetCurrentUser(_ user: User) async

    func syncGetUsers() -> [User]

    func asyncGetUsers() async -> [User]

    func syncGetUserPosts() -> [Post]
    func asyncGetUserPosts() async -> [Post]

    func syncGetCurrentUser() -> User
    func asyncGetCurrentUser() async -> User

    func syncDeletePost(index: Int)
    func asyncDeletePost(index: Int) async

    func syncGetSearchedPosts() -> [Post]
    func asyncGetSearchedPosts() async -> [Post]

    func syncSearchByName(_ name: String)
    func asyncSearchByName(_ name: String) async

    func syncGetUserSubscription() -> [User]
    func asyncGetUserSubscription() async -> [User]

    func syncGetUserSubscriptionPostsWithUser() -> [(User, Post)]
    func asyncGetUserSubscriptionPostsWithUser() async -> [(User, Post)]

    func synGetUserSubscriptionPosts() -> [Post]
    func asynGetUserSubscriptionPosts() async -> [Post]
}

public class DataManager: DataManagerProtocol {

    private var filteredPosts: [Post] = []

    private var currentUser: User = User(username: "", fullName: "", avatar: "", numberOfSubscribers: 0, profileDescription: "", password: "")

    var user1 = User(
        username: "elhakem",
        fullName: "marwa_ahmed_123",
        avatar: "wegz",
        numberOfSubscribers: 123,
        profileDescription: "المفيد",
        password: "123")

    var user2 = User(
        username: "Abyo",
        fullName: "marwa_ahmed_123",
        avatar: "abyo",
        numberOfSubscribers: 123,
        profileDescription: "باشا اعتمد",
        password: "123")

    var user3 = User(
        username: "lagacy",
        fullName: "marwa_ahmed_123",
        avatar: "legacy",
        numberOfSubscribers: 123,
        profileDescription: "2 AM",
        password: "123")

    private var users: [User] = []

    var filteredPostsCount: Int {
        return filteredPosts.count
    }

    var isSearching: Bool = false

    static let shared = DataManager()

    private init() {

        user1.posts = [
            Post(id: 0, imageName: "cool", description: "cool cat", isLiked: false),
            Post(id: 1, imageName: "wegz", description: "المفيد", isLiked: false),
            Post(id: 2, imageName: "Legacy", description: "2 am", isLiked: false)
            
        ]

        user2.posts = [
            Post(id: 0, imageName: "cool", description: "cool cat", isLiked: false),
            Post(id: 1, imageName: "wegz", description: "المفيد", isLiked: false),
            Post(id: 2, imageName: "legacy", description: "2 am", isLiked: false)
        ]

        user3.posts = [
            Post(id: 0, imageName: "cool", description: "cool cat", isLiked: false),
            Post(id: 1, imageName: "wegz", description: "المفيد", isLiked: false),
            Post(id: 2, imageName: "legacy", description: "2 am", isLiked: false)
        
        ]

        user1.subscriptions.append(user2)
        user1.subscriptions.append(user3)
        user2.subscriptions.append(user1)
        user3.subscriptions.append(user2)

        users.append(user1)
        users.append(user2)
        users.append(user3)
    }

    // MARK: - Новые методы

    func syncSetCurrentUser(_ user: User) {
        currentUser = user
    }

    func asyncSetCurrentUser(_ user: User) async {
        currentUser = user
    }

    func syncGetUsers() -> [User] {
        return users
    }

    func asyncGetUsers() async -> [User] {
        return users
    }

    func syncGetUserPosts() -> [Post] {
        return currentUser.posts
    }

    func asyncGetUserPosts() async -> [Post] {
        return currentUser.posts
    }

    func syncGetCurrentUser() -> User {
        return currentUser
    }

    func asyncGetCurrentUser() async -> User {
        return currentUser
    }

    func syncDeletePost(index: Int) {
        currentUser.posts.remove(at: index)
    }

    func asyncDeletePost(index: Int) async {
        currentUser.posts.remove(at: index)
    }

    func syncGetSearchedPosts() -> [Post] {
        return filteredPosts
    }

    func asyncGetSearchedPosts() async -> [Post] {
        return filteredPosts
    }

    func syncSearchByName(_ name: String) {
        filteredPosts = currentUser.posts.filter { $0.description.lowercased().contains(name.lowercased()) }
    }

    func asyncSearchByName(_ name: String) async {
        filteredPosts = currentUser.posts.filter { $0.description.lowercased().contains(name.lowercased()) }
    }

    func syncGetUserSubscription() -> [User] {
        return currentUser.subscriptions
    }

    func asyncGetUserSubscription() async -> [User] {
        return currentUser.subscriptions
    }

    func syncGetUserSubscriptionPostsWithUser() -> [(User, Post)] {
        let userPost: [(User, Post)] = currentUser.subscriptions.flatMap { user in
            return user.posts.map { post in
                return (user, post)
            }
        }

        return userPost
    }

    func asyncGetUserSubscriptionPostsWithUser() async -> [(User, Post)] {
        let userPost: [(User, Post)] = currentUser.subscriptions.flatMap { user in
            return user.posts.map { post in
                return (user, post)
            }
        }

        return userPost
    }

    func synGetUserSubscriptionPosts() -> [Post] {
        return currentUser.subscriptions.flatMap { $0.posts }
    }

    func asynGetUserSubscriptionPosts() async -> [Post] {
        return currentUser.subscriptions.flatMap { $0.posts }
    }

}
