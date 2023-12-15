import Foundation
import CoreData

extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var postDate: String
    @NSManaged public var postDescription: String
    @NSManaged public var postImageName: String
    @NSManaged public var liked: NSSet?
    @NSManaged public var user: User?

}

// MARK: Generated accessors for liked
extension Post {

    @objc(addLikedObject:)
    @NSManaged public func addToLiked(_ value: Like)

    @objc(removeLikedObject:)
    @NSManaged public func removeFromLiked(_ value: Like)

    @objc(addLiked:)
    @NSManaged public func addToLiked(_ values: NSSet)

    @objc(removeLiked:)
    @NSManaged public func removeFromLiked(_ values: NSSet)

}

extension Post: Identifiable {

}
