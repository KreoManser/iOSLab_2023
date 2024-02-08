//
//  UserRegistration+CoreDataProperties.swift
//  HW106
//
//  Created by Ильмир Шарафутдинов on 07.02.2024.
//
//

import Foundation
import CoreData


extension UserRegistration {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserRegistration> {
        return NSFetchRequest<UserRegistration>(entityName: "UserRegistration")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var posts: Set<Post>
    @NSManaged public var follows: Set<UserRegistration>
}

// MARK: Generated accessors for posts
extension UserRegistration {

    @objc(addPostsObject:)
    @NSManaged public func addToPosts(_ value: Post)

    @objc(removePostsObject:)
    @NSManaged public func removeFromPosts(_ value: Post)

    @objc(addPosts:)
    @NSManaged public func addToPosts(_ values: NSSet)

    @objc(removePosts:)
    @NSManaged public func removeFromPosts(_ values: NSSet)
    
    // MARK: Generated accessors for follows
    
    @objc(addFollowsObject:)
    @NSManaged public func addToFollows(_ value: UserRegistration)

    @objc(removeFollowsObject:)
    @NSManaged public func removeFromFollows(_ value: UserRegistration)

    @objc(addFollows:)
    @NSManaged public func addToFollows(_ values: NSSet)

    @objc(removeFollows:)
    @NSManaged public func removeFromFollows(_ values: NSSet)

}

extension UserRegistration : Identifiable {

}
