//
//  Post+CoreDataProperties.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 10.12.2023.
//
//

import Foundation
import CoreData

extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var counterLikes: Int32
    @NSManaged public var isLiked: Bool
    @NSManaged public var postComment: String?
    @NSManaged public var postDate: Date
    @NSManaged public var postID: Int64
    @NSManaged public var postPhotoNmae: String?
    @NSManaged public var userPostId: Int64
    @NSManaged public var user: User?

}

extension Post: Identifiable {
}
