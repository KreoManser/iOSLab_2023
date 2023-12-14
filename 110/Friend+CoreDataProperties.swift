//
//  Friend+CoreDataProperties.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 10.12.2023.
//
//

import Foundation
import CoreData

extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var friendshipStatus: String?
    @NSManaged public var user: User?

}

extension Friend: Identifiable {
}
