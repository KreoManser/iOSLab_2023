//
//  LikedPost+CoreDataProperties.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 20.12.2023.
//
//

import Foundation
import CoreData

extension LikedPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikedPost> {
        return NSFetchRequest<LikedPost>(entityName: "LikedPost")
    }

    @NSManaged public var postID: Int64
    @NSManaged public var userPostId: Int64
    @NSManaged public var user: User?

}

extension LikedPost: Identifiable {
}
