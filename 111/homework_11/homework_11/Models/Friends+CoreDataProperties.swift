//
//  Friends+CoreDataProperties.swift
//  homework_10
//
//  Created by Кирилл Щёлоков on 11.12.2023.
//
//

import Foundation
import CoreData

extension Friends {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friends> {
        return NSFetchRequest<Friends>(entityName: "Friends")
    }

    @NSManaged public var id: UUID
    @NSManaged public var friend: User
    @NSManaged public var user: User

}

extension Friends: Identifiable {

}
