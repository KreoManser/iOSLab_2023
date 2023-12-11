//
//  Like+CoreDataProperties.swift
//  HW_110
//
//  Created by Давид Васильев on 10.12.2023.
//
//

import Foundation
import CoreData
extension Like {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Like> {
        return NSFetchRequest<Like>(entityName: "Like")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var user: User?
    @NSManaged public var photo: Photo?

}

extension Like: Identifiable {

}
