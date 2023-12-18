//
//  User+CoreDataProperties.swift
//  107Tukaev
//
//  Created by surexnx on 09.12.2023.
//
//

import Foundation
import CoreData

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var login: String
    @NSManaged public var password: String
    @NSManaged public var name: String
    @NSManaged public var image: String
    @NSManaged public var id: UUID?
    @NSManaged public var publications: Set<Publication>
    @NSManaged public var subscription: Set<User>
    @NSManaged public var subscribers: Set<User>

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

// MARK: Generated accessors for subscription
extension User {

    @objc(addSubscriptionObject:)
    @NSManaged public func addToSubscription(_ value: User)

    @objc(removeSubscriptionObject:)
    @NSManaged public func removeFromSubscription(_ value: User)

    @objc(addSubscription:)
    @NSManaged public func addToSubscription(_ values: NSSet)

    @objc(removeSubscription:)
    @NSManaged public func removeFromSubscription(_ values: NSSet)

}

// MARK: Generated accessors for subscribers
extension User {

    @objc(addSubscribersObject:)
    @NSManaged public func addToSubscribers(_ value: User)

    @objc(removeSubscribersObject:)
    @NSManaged public func removeFromSubscribers(_ value: User)

    @objc(addSubscribers:)
    @NSManaged public func addToSubscribers(_ values: NSSet)

    @objc(removeSubscribers:)
    @NSManaged public func removeFromSubscribers(_ values: NSSet)

}

extension User: Identifiable {

}
