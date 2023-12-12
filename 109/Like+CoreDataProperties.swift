//
//  Like+CoreDataProperties.swift
//  CaTGramm
//
//  Created by Rustem on 12.12.2023.
//
//

import Foundation
import CoreData

extension Like {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Like> {
        return NSFetchRequest<Like>(entityName: "Like")
    }

    @NSManaged public var likeDate: Date
    @NSManaged public var likeId: UUID
    @NSManaged public var user: User
    @NSManaged public var post: Post

}

extension Like: Identifiable {

}
