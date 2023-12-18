//
//  User+CoreDataProperties.swift
//  homework_10
//
//  Created by Кирилл Щёлоков on 11.12.2023.
//
//

import Foundation
import CoreData

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var avatarImage: Data?
    @NSManaged public var id: UUID
    @NSManaged public var login: String
    @NSManaged public var password: String
    @NSManaged public var friends: NSSet?
    @NSManaged public var likedPosts: NSSet?
    @NSManaged public var posts: NSSet?

}

// MARK: Generated accessors for friends
extension User {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: Friends)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: Friends)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

// MARK: Generated accessors for likedPosts
extension User {

    @objc(addLikedPostsObject:)
    @NSManaged public func addToLikedPosts(_ value: Like)

    @objc(removeLikedPostsObject:)
    @NSManaged public func removeFromLikedPosts(_ value: Like)

    @objc(addLikedPosts:)
    @NSManaged public func addToLikedPosts(_ values: NSSet)

    @objc(removeLikedPosts:)
    @NSManaged public func removeFromLikedPosts(_ values: NSSet)

}

// MARK: Generated accessors for posts
extension User {

    @objc(addPostsObject:)
    @NSManaged public func addToPosts(_ value: Post)

    @objc(removePostsObject:)
    @NSManaged public func removeFromPosts(_ value: Post)

    @objc(addPosts:)
    @NSManaged public func addToPosts(_ values: NSSet)

    @objc(removePosts:)
    @NSManaged public func removeFromPosts(_ values: NSSet)

}

extension User: Identifiable {

}
