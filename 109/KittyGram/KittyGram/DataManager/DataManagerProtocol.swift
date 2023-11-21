//
//  DataManagerProtocol.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 22.11.2023.
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
