//
//  RegistrationDataManager.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 10.12.2023.
//

import Foundation
import CoreData

class RegistrationDataManager {

    static let shared = RegistrationDataManager()

    private init() {}

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CatGramData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
