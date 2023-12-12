//
//  Post+CoreDataProperties.swift
//  CaTGramm
//
//  Created by Rustem on 12.12.2023.
//
//

import Foundation
import CoreData

extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var id: UUID
    @NSManaged public var avatar: String
    @NSManaged public var nickname: String
    @NSManaged public var picture: String
    @NSManaged public var text: String
    @NSManaged public var date: Date
    @NSManaged public var likes: Set<Like>
    @NSManaged public var user: User

}

// MARK: Generated accessors for likes
extension Post {

    @objc(addLikesObject:)
    @NSManaged public func addToLikes(_ value: Like)

    @objc(removeLikesObject:)
    @NSManaged public func removeFromLikes(_ value: Like)

    @objc(addLikes:)
    @NSManaged public func addToLikes(_ values: NSSet)

    @objc(removeLikes:)
    @NSManaged public func removeFromLikes(_ values: NSSet)

}

extension Post: Identifiable {

}
