//
//  User+CoreDataProperties.swift
//  CaTGramm
//
//  Created by Rustem on 12.12.2023.
//
//

import Foundation
import CoreData

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var userName: String
    @NSManaged public var avatar: String
    @NSManaged public var password: String
    @NSManaged public var profileDescription: String
    @NSManaged public var likes: Set<Like>
    @NSManaged public var posts: Set<Post>

}

// MARK: Generated accessors for likes
extension User {

    @objc(addLikesObject:)
    @NSManaged public func addToLikes(_ value: Like)

    @objc(removeLikesObject:)
    @NSManaged public func removeFromLikes(_ value: Like)

    @objc(addLikes:)
    @NSManaged public func addToLikes(_ values: NSSet)

    @objc(removeLikes:)
    @NSManaged public func removeFromLikes(_ values: NSSet)

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
