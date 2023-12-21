//
//  Friends+CoreDataProperties.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 21.12.2023.
//
//

import Foundation
import CoreData

extension Friends {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friends> {
        return NSFetchRequest<Friends>(entityName: "Friends")
    }
    @NSManaged public var userID: Int32
    @NSManaged public var user: User?
}
extension Friends: Identifiable {

}
