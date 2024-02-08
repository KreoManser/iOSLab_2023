//
//  Post+CoreDataProperties.swift
//  HW106
//
//  Created by Ильмир Шарафутдинов on 07.02.2024.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var id: String
    @NSManaged public var login: String?
    @NSManaged public var inscription: String?
    @NSManaged public var date: String
    @NSManaged public var avatarImageView: Data?
    @NSManaged public var user: UserRegistration?

}

extension Post : Identifiable {

}
