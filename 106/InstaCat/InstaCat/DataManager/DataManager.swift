//
//  DataManager.swift
//  InstaCat
//
//  Created by Камил Хайрутдинов on 29.10.2023.
//

import Foundation

public class DataManager: DataManagerProtocol {

    private var filteredPosts: [Post] = []

    private var currentUser: User = User(nickname: "", fullName: "", avatar: "", numberOfSubscribers: 0, profileDescription: "", password: "")

    var user1 = User(
        nickname: "1k_mile",
        fullName: "Kamil Kh",
        avatar: "Avatar",
        numberOfSubscribers: 123,
        profileDescription: "Я крутой",
        password: "kamil")

    var user2 = User(
        nickname: "CatMas",
        fullName: "CatMas kad",
        avatar: "cat1",
        numberOfSubscribers: 44,
        profileDescription: "Я абиба",
        password: "1234")

    var user3 = User(
        nickname: "Abiba",
        fullName: "Abiba bombom",
        avatar: "cat7",
        numberOfSubscribers: 95,
        profileDescription: "Я боба",
        password: "12345")

    private var users: [User] = []

    var filteredPostsCount: Int {
        return filteredPosts.count
    }

    var isSearching: Bool = false

    static let shared = DataManager()

    private init() {

        user1.posts = [
            Post(id: 0, imageName: "cat8", description: "Просто кот"),
            Post(id: 1, imageName: "cat6", description: "Кот делает селфи"),
            Post(id: 2, imageName: "cat4", description: "Милые коты")
        ]

        user2.posts = [
            Post(id: 0, imageName: "cat1", description: "Крутой кот"),
            Post(id: 1, imageName: "cat5", description: "сплю"),
            Post(id: 2, imageName: "cat3", description: "Кот в кепке")
        ]

        user3.posts = [
            Post(id: 0, imageName: "cat4", description: "крутой в очке"),
            Post(id: 1, imageName: "cat3", description: "Кот в кепке"),
            Post(id: 2, imageName: "cat1", description: "Крутой кот")
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
