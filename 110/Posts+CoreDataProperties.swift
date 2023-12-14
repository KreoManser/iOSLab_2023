//
//  Posts+CoreDataProperties.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 10.12.2023.
//
//

import Foundation
import CoreData

extension Posts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Posts> {
        return NSFetchRequest<Posts>(entityName: "Posts")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var caption: String?
    @NSManaged public var photo: Data?
    @NSManaged public var date: String?
    @NSManaged public var isFav: Bool

}

extension Posts: Identifiable {

}
