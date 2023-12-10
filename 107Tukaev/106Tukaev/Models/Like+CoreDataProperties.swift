//
//  Like+CoreDataProperties.swift
//  107Tukaev
//
//  Created by surexnx on 08.12.2023.
//
//

import Foundation
import CoreData

extension Like {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Like> {
        return NSFetchRequest<Like>(entityName: "Like")
    }

    @NSManaged public var likeUser: Int16
    @NSManaged public var publication: Publication?

}

extension Like: Identifiable {

}
