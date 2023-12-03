//
//  DataManager.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 22.11.2023.
//

import Foundation

enum UserError: Error {
    case decodingFailder
}

public class DataManager: DataManagerProtocol {

    let userDefaults = UserDefaults(suiteName: "KittyGram")

    private var filteredPosts: [Post] = []

    var currentUserKey: String {
        return "currentUser"
    }

    var loginBoolKey: String {
        return "loggedIn"
    }

    var usersKey: String {
        return "users"
    }

    var currentUser: User?

    private var users: [User] = []

    var filteredPostsCount: Int {
        return filteredPosts.count
    }

    var isSearching: Bool = false

    static let shared = DataManager()

    private init() {

        getUsersData()
    }

    // MARK: - Новые методы
    func syncGetUsers() -> [User] {
        return users
    }

    func asyncGetUsers() async -> [User] {
        return users
    }

    func syncGetUserPosts() -> [Post] {
        guard let user = currentUser else { return [] }
        return user.posts
    }

    func asyncGetUserPosts() async -> [Post] {
        guard let user = currentUser else { return [] }
        return user.posts
    }

    func syncDeletePost(index: Int) {
        currentUser?.posts.remove(at: index)
    }

    func asyncDeletePost(index: Int) async {
        currentUser?.posts.remove(at: index)
    }

    func syncGetSearchedPosts() -> [Post] {
        return filteredPosts
    }

    func asyncGetSearchedPosts() async -> [Post] {
        return filteredPosts
    }

    func syncSearchByName(_ name: String) {
        filteredPosts = currentUser?.posts.filter { $0.description.lowercased().contains(name.lowercased()) } ?? []
    }

    func asyncSearchByName(_ name: String) async {
        filteredPosts = currentUser?.posts.filter { $0.description.lowercased().contains(name.lowercased()) } ?? []
    }

    func syncGetUserSubscription() -> [User] {
        guard let user = currentUser else { return [] }
        return user.subscriptions
    }

    func asyncGetUserSubscription() async -> [User] {
        guard let user = currentUser else { return [] }
        return user.subscriptions
    }

    func syncGetUserSubscriptionPostsWithUser() -> [(User, Post)] {
        let userPost: [(User, Post)] = currentUser?.subscriptions.flatMap { user in
            return user.posts.map { post in
                return (user, post)
            }
        } ?? []

        return userPost
    }

    func asyncGetUserSubscriptionPostsWithUser() async -> [(User, Post)] {
        let userPost: [(User, Post)] = currentUser?.subscriptions.flatMap { user in
            return user.posts.map { post in
                return (user, post)
            }
        } ?? []

        return userPost
    }

    func synGetUserSubscriptionPosts() -> [Post] {
        guard let user = currentUser else { return [] }
        return user.subscriptions.flatMap { $0.posts }
    }

    func asynGetUserSubscriptionPosts() async -> [Post] {
        guard let user = currentUser else { return [] }
        return user.subscriptions.flatMap { $0.posts }
    }

    func checkUser() throws {
        if currentUser == nil {
            guard let userData = userDefaults?.data(forKey: currentUserKey) else { throw UserError.decodingFailder }
            let decoder = JSONDecoder()
            do {
                currentUser = try decoder.decode(User.self, from: userData)
            } catch {
                print(error)
            }
        }
    }

    func logOutUser() {
        currentUser = nil
        userDefaults?.removeObject(forKey: currentUserKey)
        userDefaults?.setValue(false, forKey: loginBoolKey)
    }

    func saveUser(user: User) throws {
        let encoder = JSONEncoder()
        let userData = try encoder.encode(user)
        userDefaults?.setValue(userData, forKey: currentUserKey)
    }

    func saveData() throws {
        userDefaults?.removeObject(forKey: currentUserKey)
        let encoder = JSONEncoder()
        let userData = try encoder.encode(currentUser)
        userDefaults?.setValue(userData, forKey: currentUserKey)

        userDefaults?.removeObject(forKey: usersKey)
        let usersData = try encoder.encode(users)
        userDefaults?.setValue(usersData, forKey: usersKey)
    }

    private func getUsersData() {
        let userData = userDefaults?.data(forKey: usersKey)
        if userData == nil {
            setupUsers()
            let encoder = JSONEncoder()
            let usersData = try? encoder.encode(users)
            userDefaults?.setValue(usersData, forKey: usersKey)
        } else {
            let decoder = JSONDecoder()
            let usersData = userDefaults?.data(forKey: usersKey)
            guard let usersData = usersData else { return }
            do {
                users = try decoder.decode([User].self, from: usersData)
            } catch {
                print("Users decode error")
            }

        }
    }

    private func setupUsers() {
        print("setup users")
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

        user1.posts = [
            Post(id: 0, imageName: "cat8", description: "Просто кот", likes: 1),
            Post(id: 1, imageName: "cat6", description: "Кот делает селфи", likes: 1),
            Post(id: 2, imageName: "cat4", description: "Милые коты", likes: 1)
        ]

        user2.posts = [
            Post(id: 4, imageName: "cat1", description: "Крутой rjт", likes: 1),
            Post(id: 5, imageName: "cat5", description: "сплю", likes: 1),
            Post(id: 6, imageName: "cat3", description: "Кот в кепке", likes: 1)
        ]

        user3.posts = [
            Post(id: 7, imageName: "cat4", description: "кот в очке", likes: 1),
            Post(id: 8, imageName: "cat3", description: "Кот в кепке", likes: 1),
            Post(id: 9, imageName: "cat1", description: "Крутой кт", likes: 1)
        ]

        user1.subscriptions.append(user2)
        user1.subscriptions.append(user3)
        user2.subscriptions.append(user1)
        user3.subscriptions.append(user2)

        users.append(user1)
        users.append(user2)
        users.append(user3)

    }

}

extension DataManager: PostLikeObserver {

    func saveLikedPost(postId: Int) {
        currentUser?.likedPostsId.append(postId)
    }

    func deleteLikedPost(postId: Int) {
        guard let posts = currentUser?.likedPostsId else { return }
        let index = posts.firstIndex(where: { $0 == postId })
        currentUser?.likedPostsId.remove(at: index ?? -1)
    }

}
