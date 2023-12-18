//
//  Image+CoreDataProperties.swift
//  107Tukaev
//
//  Created by surexnx on 08.12.2023.
//
//

import Foundation
import CoreData

extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var nameImage: String?
    @NSManaged public var publication: Publication?

}

extension Image: Identifiable {

}
