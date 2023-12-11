//
//  Post+CoreDataProperties.swift
//  homework_10
//
//  Created by Кирилл Щёлоков on 11.12.2023.
//
//

import Foundation
import CoreData

extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var caption: String
    @NSManaged public var date: String
    @NSManaged public var id: UUID
    @NSManaged public var isFavorite: Bool
    @NSManaged public var postImage: Data?
    @NSManaged public var author: User?
    @NSManaged public var likedBy: Like?

}

extension Post: Identifiable {

}
