//
//  User+CoreDataProperties.swift
//  HW_110
//
//  Created by Давид Васильев on 10.12.2023.
//
//

import Foundation
import CoreData
extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var login: String?
    @NSManaged public var password: String?
    @NSManaged public var fullName: String?
    @NSManaged public var avatar: Data?
    @NSManaged public var photos: NSSet?
    @NSManaged public var friends: NSSet?
    @NSManaged public var likes: NSSet?

}

// MARK: Generated accessors for photos
extension User {

    @objc(addPhotosObject:)
    @NSManaged public func addToPhotos(_ value: Photo)

    @objc(removePhotosObject:)
    @NSManaged public func removeFromPhotos(_ value: Photo)

    @objc(addPhotos:)
    @NSManaged public func addToPhotos(_ values: NSSet)

    @objc(removePhotos:)
    @NSManaged public func removeFromPhotos(_ values: NSSet)

}

// MARK: Generated accessors for friends
extension User {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: Friend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: Friend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

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

extension User: Identifiable {

}
