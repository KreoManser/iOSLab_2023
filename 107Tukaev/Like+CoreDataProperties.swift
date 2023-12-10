//
//  Like+CoreDataProperties.swift
//  107Tukaev
//
//  Created by surexnx on 10.12.2023.
//
//

import Foundation
import CoreData

extension Like {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Like> {
        return NSFetchRequest<Like>(entityName: "Like")
    }

    @NSManaged public var publication: Publication?
    @NSManaged public var user: User

}

extension Like: Identifiable {

}
