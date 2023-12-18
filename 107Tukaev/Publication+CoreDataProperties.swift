//
//  Publication+CoreDataProperties.swift
//  107Tukaev
//
//  Created by surexnx on 08.12.2023.
//
//

import Foundation
import CoreData

extension Publication {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Publication> {
        return NSFetchRequest<Publication>(entityName: "Publication")
    }

    @NSManaged public var discription: String?
    @NSManaged public var date: Date
    @NSManaged public var user: User
    @NSManaged public var likes: Set<Like>
    @NSManaged public var images: Set<Image>
    @NSManaged public var id: UUID
}

// MARK: Generated accessors for likes
extension Publication {

    @objc(addLikesObject:)
    @NSManaged public func addToLikes(_ value: Like)

    @objc(removeLikesObject:)
    @NSManaged public func removeFromLikes(_ value: Like)

    @objc(addLikes:)
    @NSManaged public func addToLikes(_ values: NSSet)

    @objc(removeLikes:)
    @NSManaged public func removeFromLikes(_ values: NSSet)

}

// MARK: Generated accessors for images
extension Publication {

    @objc(addImagesObject:)
    @NSManaged public func addToImages(_ value: Image)

    @objc(removeImagesObject:)
    @NSManaged public func removeFromImages(_ value: Image)

    @objc(addImages:)
    @NSManaged public func addToImages(_ values: NSSet)

    @objc(removeImages:)
    @NSManaged public func removeFromImages(_ values: NSSet)

}

extension Publication: Identifiable {

}
