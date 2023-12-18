//
//  Like+CoreDataProperties.swift
//  homework_10
//
//  Created by Кирилл Щёлоков on 11.12.2023.
//
//

import Foundation
import CoreData

extension Like {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Like> {
        return NSFetchRequest<Like>(entityName: "Like")
    }

    @NSManaged public var id: UUID
    @NSManaged public var post: Post?
    @NSManaged public var user: User?

}

extension Like: Identifiable {

}
