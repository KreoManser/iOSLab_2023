//
//  User+CoreDataProperties.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 21.12.2023.
//
//

import Foundation
import CoreData

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var userAvatarImageName: String
    @NSManaged public var userCountFolowers: Int32
    @NSManaged public var userCountFolowing: Int32
    @NSManaged public var userCountPosts: Int32
    @NSManaged public var userDescription: String
    @NSManaged public var userId: Int64
    @NSManaged public var userLogin: String
    @NSManaged public var userName: String
    @NSManaged public var userPassword: String
    @NSManaged public var isFriends: Bool
    @NSManaged public var friends: Set<Friends>
    @NSManaged public var likedPost: Set<LikedPost>
    @NSManaged public var posts: Set<Post>

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

// MARK: Generated accessors for likedPost
extension User {

    @objc(addLikedPostObject:)
    @NSManaged public func addToLikedPost(_ value: LikedPost)

    @objc(removeLikedPostObject:)
    @NSManaged public func removeFromLikedPost(_ value: LikedPost)

    @objc(addLikedPost:)
    @NSManaged public func addToLikedPost(_ values: NSSet)

    @objc(removeLikedPost:)
    @NSManaged public func removeFromLikedPost(_ values: NSSet)

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

extension User : Identifiable {

}
