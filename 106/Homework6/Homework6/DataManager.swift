//
//  DataManager.swift
//  Homework6
//
//  Created by kerik on 30.10.2023.
//

import Foundation
import UIKit

protocol DataManagerProtocol {
    func syncSave(_ post: Post)
    func asyncSave(_ post: Post) async

    func syncSetCurrentUser(_ user: User)
    func asyncSetCurrentUser(_ user: User) async

    func syncGetUsers() -> [User]
    func asyncGetUsers() async -> [User]

    func syncGetUserPosts() -> [Post]
    func asyncGetUserPosts() async -> [Post]

    func syncGetCurrentUser() -> User
    func asyncGetCurrentUser() async -> User

    func syncGetAllPosts() -> [Post]
    func asyncGetAllPosts() async -> [Post]

    func syncDelete(index: Int)
    func asyncDelete(index: Int) async

    func syncSearchByDescription(_ description: String)
    func asyncSearchByDescription(_ description: String) async

    func syncGetUserAndPostsWithoutCurrentUser() -> [(User, Post)]
    func asyncGetUserAndPostsWithoutCurrentUser() async -> [(User, Post)]

    func syncGetPostsWithoutCurrentUserPosts() -> [Post]
    func asyncGetPostsWithoutCurrentUserPosts() async -> [Post]
}

public class DataManager: DataManagerProtocol {
    private var users: [User] = []
    private var currentUser = User(avatar: "", fullName: "", login: "", password: "", numberOfSubscribers: 0)

    private var posts: [Post] = []
    private var searchedPosts: [Post] = []
    var isSearching: Bool = false

    static let shared = DataManager()

    var firstUser = User(
        avatar: "profile",
        fullName: "Kirill Abramov",
        login: "kerikg",
        password: "kerikg",
        posts: [
            Post(id: 7, imageName: "cat7", description: "Кот 7", date: "7-09-2022")
        ],
        numberOfSubscribers: 100
    )
    var secondUser = User(
        avatar: "cat1",
        fullName: "Алблак 52",
        login: "cat",
        password: "cat",
        posts: [
            Post(id: 1, imageName: "cat1", description: "Кот 1", date: "18-04-2023"),
            Post(id: 2, imageName: "cat2", description: "Кот 2", date: "30-05-2022"),
            Post(id: 3, imageName: "cat3", description: "Кот 3", date: "20-06-2011"),
            Post(id: 4, imageName: "cat4", description: "Кот 4", date: "10-06-2004")
        ],
        numberOfSubscribers: 52
    )
    var thirdUser = User(
        avatar: "cat4",
        fullName: "Чудила",
        login: "huligan2004",
        password: "qwerty123",
        posts: [
            Post(id: 5, imageName: "cat5", description: "Кот 5", date: "7-09-2022"),
            Post(id: 6, imageName: "cat6", description: "Кот 6", date: "7-09-2022")
        ],
        numberOfSubscribers: 228
    )

    private init() {
        posts = [
            Post(id: 1, imageName: "cat1", description: "Кот 1", date: "18-04-2023"),
            Post(id: 2, imageName: "cat2", description: "Кот 2", date: "30-05-2022"),
            Post(id: 3, imageName: "cat3", description: "Кот 3", date: "20-06-2011"),
            Post(id: 4, imageName: "cat4", description: "Кот 4", date: "10-06-2004"),
            Post(id: 5, imageName: "cat5", description: "Кот 5", date: "7-09-2022"),
            Post(id: 6, imageName: "cat6", description: "Кот 6", date: "7-09-2022"),
            Post(id: 7, imageName: "cat7", description: "Кот 7", date: "7-09-2022")
        ]

        users.append(firstUser)
        users.append(secondUser)
        users.append(thirdUser)
    }

    func syncSave(_ post: Post) {
        posts.append(post)
    }

    func asyncSave(_ post: Post) async {
        posts.append(post)
    }

    func syncGetAllPosts() -> [Post] {
        return posts
    }

    func asyncGetAllPosts() async -> [Post] {
        return posts
    }

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

    func syncDelete(index: Int) {
        currentUser.posts.remove(at: index)
    }

    func asyncDelete(index: Int) async {
        currentUser.posts.remove(at: index)
    }

    func syncSearchByDescription(_ description: String) {
        searchedPosts = currentUser.posts.filter { $0.description.lowercased().contains(description.lowercased()) }
    }

    func asyncSearchByDescription(_ description: String) async {
        self.searchedPosts = currentUser.posts.filter { $0.description.lowercased().contains(description.lowercased()) }
    }

    var searchedPostsCount: Int {
        return searchedPosts.count
    }

    func syncGetSearchedPosts() -> [Post] {
        return searchedPosts
    }

    func asyncGetSearchedPosts() async -> [Post] {
        return searchedPosts
    }

    func syncGetUserAndPostsWithoutCurrentUser() -> [(User, Post)] {
        let users = usersWithoutCurrentUser()
        let userPost: [(User, Post)] = users.flatMap { user in
            return user.posts.map { post in
                return (user, post)
            }
        }

        return userPost
    }

    func asyncGetUserAndPostsWithoutCurrentUser() async -> [(User, Post)] {
        let users = usersWithoutCurrentUser()
        let userPost: [(User, Post)] = users.flatMap { user in
            return user.posts.map { post in
                return (user, post)
            }
        }

        return userPost
    }

    func syncGetPostsWithoutCurrentUserPosts() -> [Post] {
        return usersWithoutCurrentUser().flatMap { $0.posts }
    }

    func asyncGetPostsWithoutCurrentUserPosts() async -> [Post] {
        return usersWithoutCurrentUser().flatMap { $0.posts }
    }

    func checkData (login: String, password: String) -> Bool {
        for user in users {
            if user.login == login && user.password == password {
                return true
            }
        }
        return false
    }

    func createStories() -> [Story] {
        let stories: [Story] = [
            Story(image: UIImage(named: "cat1") ?? UIImage()),
            Story(image: UIImage(named: "cat2") ?? UIImage()),
            Story(image: UIImage(named: "cat3") ?? UIImage()),
            Story(image: UIImage(named: "cat4") ?? UIImage()),
            Story(image: UIImage(named: "cat5") ?? UIImage()),
            Story(image: UIImage(named: "cat6") ?? UIImage()),
            Story(image: UIImage(named: "cat7") ?? UIImage())
        ]
        return stories
    }

    func usersWithoutCurrentUser() -> [User] {
        let curUser = syncGetCurrentUser()
        let usersExcludingCurrent = users.filter { $0.login != curUser.login }
        return usersExcludingCurrent
    }

    func checkUsers(_ login: String, _ password: String) async -> User? {
        let users = await DataManager.shared.asyncGetUsers()
        return users.first(where: { $0.login == login && $0.password == password })
    }
}
