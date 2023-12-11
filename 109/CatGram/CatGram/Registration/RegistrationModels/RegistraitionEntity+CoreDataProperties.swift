//
//  RegistraitionEntity+CoreDataProperties.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 10.12.2023.
//
//

import Foundation
import CoreData

extension RegistraitionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RegistraitionEntity> {
        return NSFetchRequest<RegistraitionEntity>(entityName: "RegistraitionEntity")
    }

    @NSManaged public var userName: String
    @NSManaged public var password: String

}

extension RegistraitionEntity: Identifiable {

}
