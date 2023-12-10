//
//  User+CoreDataProperties.swift
//  107Tukaev
//
//  Created by surexnx on 08.12.2023.
//
//

import Foundation
import CoreData

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var login: String?
    @NSManaged public var password: String?
    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var subcription: Int16
    @NSManaged public var subsribers: Int16
    @NSManaged public var publications: NSSet?

}

// MARK: Generated accessors for publications
extension User {

    @objc(addPublicationsObject:)
    @NSManaged public func addToPublications(_ value: Publication)

    @objc(removePublicationsObject:)
    @NSManaged public func removeFromPublications(_ value: Publication)

    @objc(addPublications:)
    @NSManaged public func addToPublications(_ values: NSSet)

    @objc(removePublications:)
    @NSManaged public func removeFromPublications(_ values: NSSet)

}

extension User: Identifiable {}
