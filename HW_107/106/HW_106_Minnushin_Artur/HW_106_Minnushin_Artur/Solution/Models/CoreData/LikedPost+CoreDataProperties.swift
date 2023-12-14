//
//  LikedPost+CoreDataProperties.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 10.12.2023.
//
//

import Foundation
import CoreData

extension LikedPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikedPost> {
        return NSFetchRequest<LikedPost>(entityName: "LikedPost")
    }

    @NSManaged public var counterLikes: Int32
    @NSManaged public var isLiked: Bool
    @NSManaged public var postComment: String?
    @NSManaged public var postDate: Date?
    @NSManaged public var postID: Int64
    @NSManaged public var postPhotoNmae: String?
    @NSManaged public var userPostId: Int64
    @NSManaged public var user: NSSet?

}

// MARK: Generated accessors for user
extension LikedPost {

    @objc(addUserObject:)
    @NSManaged public func addToUser(_ value: User)

    @objc(removeUserObject:)
    @NSManaged public func removeFromUser(_ value: User)

    @objc(addUser:)
    @NSManaged public func addToUser(_ values: NSSet)

    @objc(removeUser:)
    @NSManaged public func removeFromUser(_ values: NSSet)

}

extension LikedPost: Identifiable {

}
