//
//  Photo+CoreDataProperties.swift
//  HW_110
//
//  Created by Давид Васильев on 10.12.2023.
//
//

import Foundation
import CoreData
extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var comment: String?
    @NSManaged public var image: Data?
    @NSManaged public var date: Date?
    @NSManaged public var user: User?
    @NSManaged public var like: Like?

}

extension Photo: Identifiable {

}
