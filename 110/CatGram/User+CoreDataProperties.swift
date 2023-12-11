import Foundation
import CoreData

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var username: String?
    @NSManaged public var profileImage: Data?
    @NSManaged public var id: UUID?
    @NSManaged public var accountDescription: String?
    @NSManaged public var login: String?
    @NSManaged public var password: String?

}

extension User: Identifiable {

}
