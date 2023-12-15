import Foundation
import CoreData

extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var user: User
    @NSManaged public var friendUserEntity: User

}

extension Friend: Identifiable {

}
