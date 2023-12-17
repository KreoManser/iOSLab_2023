import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var id: UUID
    @NSManaged public var caption: String
    @NSManaged public var image: Data?
    @NSManaged public var date: Date
    @NSManaged public var countOfLikes: Int
    @NSManaged public var user: User?

}

extension Post : Identifiable {

}
