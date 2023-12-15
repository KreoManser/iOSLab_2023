import Foundation
import CoreData

extension Like {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Like> {
        return NSFetchRequest<Like>(entityName: "Like")
    }

    @NSManaged public var id: UUID
    @NSManaged public var post: Post?
    @NSManaged public var user: User?

}

extension Like: Identifiable {

}
